︠7ea8f36d-cecc-41fd-912c-583289713221s︠
import random

def main():
# ***************vstupne data*****************
    k = 3;
    g = 5;
# ********************************************
    print(' \n')
    print("Cage("+str(k)+","+str(g)+")\n");
    cageConstruction(k,g);

    print(' \n')
    print('Overenie vypoctom: ');
    testingcontrollDataForPotentionalCage(k,g);


# sledujeme 3 zoznamy uvazovanych klietok s ktorymi porovnavame parametre, pre kazdy zoznam sa grafy generuju inym sposobom
def cageConstruction(k,g):
    sageCages = [[3,5], [3,6], [3,7], [3,8], [3,10], [3,11], [4,5], [7,5]];
    exoosCages = [[3,14], [3,16], [3,17], [3,18], [3,20], [3,23], [3,25], [4,7], [4,9], [4,10], [5,10], [7,7], [7,8], [10,5], [11,5], [12,5], [13,5]];
    myConstructedCages = [[6,4]];

    cageInput =[];
    cageInput.append(k);
    cageInput.append(g);

    if ((cageInput in sageCages) == false and (cageInput in exoosCages) == false and (cageInput in myConstructedCages) == false):
        print("\n");
        print("Klietka nie je medzi uvazovanymi alebo neexistuje\n");
        return;

    graph = graphs.EmptyGraph();
    if cageInput in sageCages:
        if k == 3:
            if g == 5:
                cage = graphs.PetersenGraph();
            if g == 6:
                cage = graphs.HeawoodGraph();
            if g == 7:
                cage = graphs.McGeeGraph();
            if g == 8:
                cage = graphs.TutteCoxeterGraph();
            if g == 10:
                cage = graphs.Balaban10Cage();
            if g == 11:
                cage = graphs.Balaban11Cage();
        if k == 4 and g == 5:
            cage = graphs.RobertsonGraph();
        if k == 7 and g == 5:
            cage = graphs.HoffmanSingletonGraph();
    elif cageInput in exoosCages:
        cage = generateGraphandCageFromExoosAdjacencylist("ExoosCages/cage_"+str(k)+"_"+str(g)+".txt");
    elif cageInput in myConstructedCages:
        if k == 6 and g == 4:
            cage = generate_6_4CageGraph();
    if (cageVerification(cage,k,g) == False):
        print("Klietka neexistuje\n");
        return;
    getAndshowCageInformations(cage);

# vypocita najmensi mozny pocet vrcholov pre potencionalnu klietku (testovacie data)
def calculateMooreBound(k,g):
    M = 0;
    if g % 2 == 1:
        exp = (g - 3) / 2;
        for i in range(exp + 1):
            M = M + (k * ((k - 1) ^ i));
        M = M + 1;
    else:
        exp = (g - 2)/2;
        for i in range(exp + 1):
            M = M + ((k - 1) ^ i);
        M = 2 * M;
    return M;

# vypocita potencionalnu minimalnu velkost kodu na zaklade Moorovho ohranicenia (testovacie data)
def codeSizeByMooreBound(M,k):
    row = M;
    column = numberOfEdgesByMooreBound(M,k);
    size = str(row) + " x " + str(column);
    return size;

# vypocita potencionalny pocet hran na zaklade Moorovho ohranicenia (testovacie data)
def numberOfEdgesByMooreBound(M,k):
    return M * k / 2;

def generate_6_4CageGraph():
    m = calculateMooreBound(6,4);
    s =[]
    for i in range(m/2):
        s.append(6);
    graph = graphs.DegreeSequenceBipartite(s,s);
    for i in range (m):
        graph.set_vertex(i, str(i))
    graph.name("Cage (6,4)");
    return graph;

# ziska vsetky cykly prechadzajúce vrcholom 0
def getCycles(graph):
    listOfGirths = [];
    listsOfGirthVertices = graph.minimum_cycle_basis(by_weight=False);
    for listOfGirthVertices in listsOfGirthVertices:
        cycleGraph = graph.subgraph(listOfGirthVertices);
        listOfGirths.append(cycleGraph.cycle_basis());
    return listOfGirths;

# vrati kontrolnu maticu linearneho kodu ako incidencnu maticu klietky ziskanu z grafu nad polom Z2
def getParityCheckMatrix(graph):
    return matrix(GF(2), graph.incidence_matrix());

# vrati kontrolnu maticu linearneho kodu ako incidencnu maticu klietky ziskanu z grafu nad polom Z2
def getGeneratorMatrix(H):
    # vygeneruje lin kod z kontrolnej matice
    C = codes.from_parity_check_matrix(H);
    return C.systematic_generator_matrix();

# realne data na zaklade vypooctov z klietky
def getAndshowCageInformations(graph):
    cycles = [];
    graph.show(figsize=10);
    print(' \n')
    print('Cykly formujúce klietku: ');
    cycles = getCycles(graph);
    print(cycles);
    print(' \n')
    print('Vrcholy klietky: ');
    print(len(graph.vertices()));
    print(graph.vertices());
    print(' \n')
    print('Hrany klietky: ');
    print(len(graph.edges(labels=False)));
    print(graph.edges(labels=False));
    print(' \n')
    print('Incidencna matica klietky, ktorá je zároveň kontrolnou maticou lin. kódu: ');
    print(graph.incidence_matrix());
    print(' \n')
    print('Pocet automorfizmov: ');
    print(len(graph.automorphism_group()));
    print(' \n')
#     print('Grupy automorfizmov: ');
#     print(graph.automorphism_group().list());
#     print(' \n')
    H = getParityCheckMatrix(graph)
    C = codes.from_parity_check_matrix(H)
    print('Lineárny kód vygenerovaný z kontrolnej matice: ');
    print(C);
    print(' \n')
    G = getGeneratorMatrix(H)
    print('Generujúca matica lineárneho kódu: ');
    print(G);
    print(' \n')
    print('Minimálna vzdialenost v kóde: ');
    print(C.minimum_distance());
    print(' \n')
    print('Overenie vypoctom G * Ht = {nulova matica}: ');
    print(G);
    print('x');
    print(H.transpose());
    print('=');
    print(linearCodeVerification(H,G));
    print(' \n')
#     print('Generatory grup automorfizmov: ');
#     print(C.automorphism_group_gens(equivalence="permutational"))
#     print(' \n')
    Gr = C.permutation_automorphism_group();
#     print(Gr);
#     print(' \n')
    print('počet automorfizmov z lineárneho kódu: ');
    print(Gr.order());

# testovacie dáta pre porovnanie na základe Moorovho ohraničenia pre potencionálnu klietku
def testingcontrollDataForPotentionalCage(k,g):
    M = calculateMooreBound(k,g);
    print("Moorové ohraničenie potencionálnej klietky - pocet vrcholov: M("+str(k)+","+str(g)+") = "+str(M));
    rozmerMaticeKodu = codeSizeByMooreBound(M,k);
    print('Rozmer uvažovanej minimalnej matice Kodu: ', rozmerMaticeKodu);
    matrixGirth = 2*g;
    print('Obvod cyklu v incidencnej matici: ', matrixGirth);
    pocetHran = numberOfEdgesByMooreBound(M,k);
    print('Minimalny pocet hran: ', pocetHran);

# odstranenie hodnot zo zoznamu na zaklade hodnoty
def remove_values_from_list(the_list, val):
    return [value for value in the_list if value != val]

# parsovanie Exoo dokumentov so zoznamami susednych vrcholov na generovanie grafu
def generateGraphandCageFromExoosAdjacencylist(filePath):
    file = open(filePath, "r");
    graph = graphs.EmptyGraph();
    mainVertex = 0;
    for line in file:
        line = line.replace('\n', '');
        adjacencyVerticies = line.split(" ");
        adjacencyVerticies = remove_values_from_list(adjacencyVerticies, '');
        for adjacencyVertex in adjacencyVerticies:
            graph.add_edge(mainVertex, int(adjacencyVertex));
        mainVertex += 1;
    file.close();
    return graph;

# test vysledkov
def cageVerification(cage,k,g):
    M = calculateMooreBound(k,g);
    minPocetHran = numberOfEdgesByMooreBound(M,k);
#     verifikacia poctu vrcholov
    if len(cage.vertices()) < M or len(cage.incidence_matrix().column(0)) < M:
        return False;
#     verifikacia poctu hran
    if len(cage.edges()) < minPocetHran or len(cage.incidence_matrix().row(0)) < minPocetHran:
        return False;
    return True;

# overenie G * Ht = 0 //overi spravnost vygenerovanej generacnejmatice ako aj kodu samotneho lin kodu a vrati nulovu stvorcovu maticu
def linearCodeVerification(H,G):
    return G * (H.transpose());

main()
︡cd27f407-5e48-41c7-87ea-0690a79c70ec︡{"stdout":" \n\nCage(3,5)\n\n"}︡{"file":{"filename":"/home/user/.sage/temp/project-376af7c8-9ff4-41d1-b610-f8b2428e9ab4/2403/tmp_z9s0wtqt.svg","show":true,"text":null,"uuid":"f0b3c9de-3188-43b2-bb83-3190bbe04518"},"once":false}︡{"stdout":" \n"}︡{"stdout":"\nCykly formujúce klietku: \n[[[4, 3, 8, 5, 0]], [[1, 2, 3, 4, 0]], [[1, 6, 8, 5, 0]], [[1, 2, 7, 5, 0]], [[4, 9, 7, 5, 0]], [[1, 6, 9, 4, 0]]]\n \n\nVrcholy klietky: \n10\n[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]\n \n\nHrany klietky: \n15\n[(0, 1), (0, 4), (0, 5), (1, 2), (1, 6), (2, 3), (2, 7), (3, 4), (3, 8), (4, 9), (5, 7), (5, 8), (6, 8), (6, 9), (7, 9)]\n \n\nIncidencna matica klietky, ktorá je zároveň kontrolnou maticou lin. kódu: \n[1 1 1 0 0 0 0 0 0 0 0 0 0 0 0]\n[1 0 0 1 1 0 0 0 0 0 0 0 0 0 0]\n[0 0 0 1 0 1 1 0 0 0 0 0 0 0 0]\n[0 0 0 0 0 1 0 1 1 0 0 0 0 0 0]\n[0 1 0 0 0 0 0 1 0 1 0 0 0 0 0]\n[0 0 1 0 0 0 0 0 0 0 1 1 0 0 0]\n[0 0 0 0 1 0 0 0 0 0 0 0 1 1 0]\n[0 0 0 0 0 0 1 0 0 0 1 0 0 0 1]\n[0 0 0 0 0 0 0 0 1 0 0 1 1 0 0]\n[0 0 0 0 0 0 0 0 0 1 0 0 0 1 1]\n \n\nPocet automorfizmov: \n120\n \n\nLineárny kód vygenerovaný z kontrolnej matice: \n[15, 6] linear code over GF(2)\n \n\nGenerujúca matica lineárneho kódu: \n[1 0 1 0 1 0 0 0 0 0 0 1 1 0 0]\n[0 1 1 0 0 0 0 0 0 1 0 1 1 1 0]\n[0 0 0 1 1 0 1 0 0 0 0 0 0 1 1]\n[0 0 0 0 0 1 1 0 1 0 0 0 1 1 1]\n[0 0 0 0 0 0 0 1 1 1 0 0 1 1 0]\n[0 0 0 0 0 0 0 0 0 0 1 1 1 1 1]\n \n\nMinimálna vzdialenost v kóde: \n5"}︡{"stdout":"\n \n\nOverenie vypoctom G * Ht = {nulova matica}: \n[1 0 1 0 1 0 0 0 0 0 0 1 1 0 0]\n[0 1 1 0 0 0 0 0 0 1 0 1 1 1 0]\n[0 0 0 1 1 0 1 0 0 0 0 0 0 1 1]\n[0 0 0 0 0 1 1 0 1 0 0 0 1 1 1]\n[0 0 0 0 0 0 0 1 1 1 0 0 1 1 0]\n[0 0 0 0 0 0 0 0 0 0 1 1 1 1 1]\nx\n[1 1 0 0 0 0 0 0 0 0]\n[1 0 0 0 1 0 0 0 0 0]\n[1 0 0 0 0 1 0 0 0 0]\n[0 1 1 0 0 0 0 0 0 0]\n[0 1 0 0 0 0 1 0 0 0]\n[0 0 1 1 0 0 0 0 0 0]\n[0 0 1 0 0 0 0 1 0 0]\n[0 0 0 1 1 0 0 0 0 0]\n[0 0 0 1 0 0 0 0 1 0]\n[0 0 0 0 1 0 0 0 0 1]\n[0 0 0 0 0 1 0 1 0 0]\n[0 0 0 0 0 1 0 0 1 0]\n[0 0 0 0 0 0 1 0 1 0]\n[0 0 0 0 0 0 1 0 0 1]\n[0 0 0 0 0 0 0 1 0 1]\n=\n[0 0 0 0 0 0 0 0 0 0]\n[0 0 0 0 0 0 0 0 0 0]\n[0 0 0 0 0 0 0 0 0 0]\n[0 0 0 0 0 0 0 0 0 0]\n[0 0 0 0 0 0 0 0 0 0]\n[0 0 0 0 0 0 0 0 0 0]\n \n\npočet automorfizmov z lineárneho kódu: \n120\n \n\nOverenie vypoctom: \nMoorové ohraničenie potencionálnej klietky - pocet vrcholov: M(3,5) = 10\nRozmer uvažovanej minimalnej matice Kodu:  10 x 15\nObvod cyklu v incidencnej matici:  10\nMinimalny pocet hran:  15\n"}︡{"done":true}









