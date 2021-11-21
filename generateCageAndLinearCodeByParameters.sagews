︠9e3823fe-4b51-411e-8447-5683dc2599d0s︠
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
    getAndshowCageInformations(cage,g);

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
def getAndshowCageInformations(graph,g):
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
    print(' \n')
    print(graph.incidence_matrix());
    print(' \n')
    print('Pocet automorfizmov: ');
    print(len(graph.automorphism_group()));
    print(' \n')
    print('Grupy automorfizmov: ');
    print(graph.automorphism_group().list());
    print(' \n')
    H = getParityCheckMatrix(graph)
    C = codes.from_parity_check_matrix(H)
    print('Lineárny kód vygenerovaný z kontrolnej matice: ');
    print(C);
    print(' \n')
    G = getGeneratorMatrix(H)
    print('Generujúca matica lineárneho kódu: ');
    print(' \n')
    print(G);
    print(' \n')
    print('Maximalny pocet slov zakodovanych v kode: ');
    print(getMaxNumberOfCodewords(G));
    print(' \n')
    print('Minimálna vzdialenost v kóde: ');
    d = g;
    n = G.ncols();
    M = getMaxNumberOfCodewords(G)
    print(perfectCodeParameter(n,M,d));
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
    Gr = C.permutation_automorphism_group(algorithm = "partition");
    print(Gr);
    print(' \n')
    print('počet automorfizmov z lineárneho kódu: ');
    print(Gr.order());

def getMaxNumberOfCodewords(G):
    return 2^G.nrows();

# udava vzdialenost nasho kodu od perfektneho v intervale 0 - 1, kedy 1 je perfektny kod 23,2^12,7 7,2^4,3
def perfectCodeParameter(n,M,d):
    if d % 2 == 1:
        t = (d-1)/2;     # t=(d-1)/2 pre neparne
    else:
        t = (d-2)/2;     # parne (d-1)/2 dostavam desatinne cislo, uvazujem len cele, preto d-2
    sum = 0.0;
    for i in range(0,t+1):
        sum = sum + combinationNumber(n,i);
    parameter = (M*sum)/(2^n)
    return parameter;

def factorial(n):
    fact = 1;
    for i in range(1,n+1):
        fact = fact * i
    return fact;

def combinationNumber(n,k):
    return factorial(n)/(factorial(k)*factorial(n-k));

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
︡d4a5416e-f76e-4764-8d0e-dc42eaf0bb89︡{"stdout":" \n\nCage(3,5)\n\n"}︡{"file":{"filename":"/home/user/.sage/temp/project-376af7c8-9ff4-41d1-b610-f8b2428e9ab4/1017/tmp_zyu2mkod.svg","show":true,"text":null,"uuid":"39d44476-0083-4134-b2a9-f044fb21aa84"},"once":false}︡{"stdout":" \n"}︡{"stdout":"\nCykly formujúce klietku: \n[[[4, 3, 8, 5, 0]], [[1, 2, 3, 4, 0]], [[1, 6, 8, 5, 0]], [[1, 2, 7, 5, 0]], [[4, 9, 7, 5, 0]], [[1, 6, 9, 4, 0]]]"}︡{"stdout":"\n \n\nVrcholy klietky: \n10\n[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]\n \n\nHrany klietky: \n15\n[(0, 1), (0, 4), (0, 5), (1, 2), (1, 6), (2, 3), (2, 7), (3, 4), (3, 8), (4, 9), (5, 7), (5, 8), (6, 8), (6, 9), (7, 9)]\n \n\nIncidencna matica klietky, ktorá je zároveň kontrolnou maticou lin. kódu: \n \n\n[1 1 1 0 0 0 0 0 0 0 0 0 0 0 0]\n[1 0 0 1 1 0 0 0 0 0 0 0 0 0 0]\n[0 0 0 1 0 1 1 0 0 0 0 0 0 0 0]\n[0 0 0 0 0 1 0 1 1 0 0 0 0 0 0]\n[0 1 0 0 0 0 0 1 0 1 0 0 0 0 0]\n[0 0 1 0 0 0 0 0 0 0 1 1 0 0 0]\n[0 0 0 0 1 0 0 0 0 0 0 0 1 1 0]\n[0 0 0 0 0 0 1 0 0 0 1 0 0 0 1]\n[0 0 0 0 0 0 0 0 1 0 0 1 1 0 0]\n[0 0 0 0 0 0 0 0 0 1 0 0 0 1 1]\n \n\nPocet automorfizmov: \n120"}︡{"stdout":"\n \n\nGrupy automorfizmov: \n[(), (0,5,8,3,2,1)(4,7,6), (0,4,3,2,1)(5,9,8,7,6), (0,8,2)(1,5,3)(4,6,7), (0,1)(2,5,6,4)(3,7,8,9), (0,7,4,2)(1,5,9,3)(6,8), (0,9,8,2)(1,4,6,3)(5,7), (0,3,5,2)(1,4,8,7)(6,9), (0,6,3)(1,8,4)(2,5,9), (0,2)(3,4)(5,7)(8,9), (1,5,4)(2,7,9,6,8,3), (0,5,7,9,4)(1,8,2,6,3), (0,4)(1,9,5,3)(2,6,7,8), (0,8,1,3)(2,4,5,6)(7,9), (0,1,6,9,4)(2,8,7,3,5), (0,7,3)(1,9,8)(2,4,5), (0,9,3)(1,7,8)(2,5,6), (0,3)(1,2)(5,8)(6,7), (0,6,4,8)(1,9,3,5)(2,7), (0,2,5,3)(1,7,8,4)(6,9), (1,4)(2,3)(6,9)(7,8), (0,5,8,6,9,4)(1,7,3), (0,4)(1,3)(5,9)(6,8), (0,8,4,5,3)(1,6,9,7,2), (0,1,2,7,9,4)(3,5,6), (0,7,6,3)(1,2)(4,5,9,8), (0,9,3)(1,6,8,5,7,2), (0,3)(1,8)(2,5), (0,6,2)(3,5,9)(4,8,7), (0,2,4,1,3)(5,7,9,6,8), (2,6)(3,8)(4,5)(7,9), (0,5,7,9,6,1)(2,4,8), (0,4,9,6,1)(2,5,3,7,8), (0,8,1,5,6)(2,7,9,4,3), (0,1)(2,4,6,5)(3,9,8,7), (0,7,3,6)(1,5,2,8)(4,9), (0,9,5,6)(1,4,7,8)(2,3), (0,3,7,6)(1,4,2,9)(5,8), (0,6,5,1,8)(2,3,4,9,7), (0,2,6)(3,9,5)(4,7,8), (1,5)(2,8)(6,7), (0,5)(1,8)(2,3)(4,7), (0,4,3,2,7,5)(1,9,8), (0,8)(1,3)(4,6), (0,1,6,8,5)(2,9,3,7,4), (0,7,8)(1,9,3)(2,6,4), (0,9,8)(1,7,3)(4,6,5), (0,3,5,4,8)(1,2,7,9,6), (0,6,7,3)(1,9,2,4)(5,8), (0,2,9,8)(1,7,6,5)(3,4), (1,4,5)(2,9,8)(3,7,6), (0,5)(1,7,4,8)(2,9,3,6), (0,4,9,7,5)(1,3,6,2,8), (0,8)(1,6)(2,9)(3,4), (0,1,2,3,8,5)(4,6,7), (0,7,8)(1,2,3,4,9,6), (0,9,2,8)(1,6)(3,5,4,7), (0,3,1,8)(2,6,5,4)(7,9), (0,6)(3,7)(4,9)(5,8), (0,2,8)(1,3,5)(4,7,6), (3,7)(4,5)(8,9), (0,5,7,2,1)(3,6,4,8,9), (0,4,9,7,2,1)(3,6,5), (0,8,9,2)(1,5,6,7)(3,4), (0,1)(2,5)(3,8)(4,6), (0,7,1,5,2)(3,4,9,6,8), (0,9,2)(1,4,7)(3,5,6), (0,3,1,4,2)(5,8,6,9,7), (0,6,3,7)(1,8,2,5)(4,9), (0,2)(3,5)(4,7), (1,5)(2,7)(3,9)(6,8), (0,5)(1,8,4,7)(2,6,3,9), (0,4,3,8,5)(1,9,2,6,7), (0,8,7)(1,3,9)(2,4,6), (0,1,6,9,7,5)(2,8,4), (0,7)(1,9)(2,4), (0,9,1,7)(2,5,4,6)(3,8), (0,3,6,7)(1,2)(4,8,9,5), (0,6,4,1,9)(2,7,5,8,3), (0,2,5,1,7)(3,8,6,9,4), (1,4,5)(2,3,8,6,9,7), (0,5)(1,7)(4,8)(6,9), (0,4,9,6,8,5)(1,3,7), (0,8,7)(1,6,9,4,3,2), (0,1,2,7,5)(3,9,8,4,6), (0,7)(1,2)(3,6)(4,9), (0,9,5,4,7)(1,6,8,3,2), (0,3,7)(1,8,9)(2,5,4), (0,6,2)(3,4,9,7,5,8), (0,2,4,7)(1,3,9,5)(6,8), (2,6)(3,9)(7,8), (0,5,8,6,1)(2,4,7,3,9), (0,4,3,8,6,1)(2,5,9), (0,8,4,6)(1,5,3,9)(2,7), (0,1)(2,4)(5,6)(7,9), (0,7,6)(1,5,9)(2,8,4), (0,9,1,4,6)(2,3,8,5,7), (0,3,6)(1,4,8)(2,9,5), (0,6,5,9)(1,8,7,4)(2,3), (0,2,6)(3,8,5,7,9,4), (1,5,4)(2,8,9)(3,6,7), (0,5,7,2,3,4)(1,8,9), (0,4)(1,9)(2,7)(3,5), (0,8,9)(1,3,7)(4,5,6), (0,1,6,8,3,4)(2,9,5), (0,7,1,9)(2,6,4,5)(3,8), (0,9)(1,7)(5,6), (0,3,9)(1,2,7,5,8,6), (0,6,7)(1,9,5)(2,4,8), (0,2,9)(1,7,4)(3,6,5), (1,4)(2,9)(3,6), (0,5,8,3,4)(1,7,6,2,9), (0,4)(1,3,5,9)(2,8,7,6), (0,8,2,9)(1,6)(3,7,4,5), (0,1,2,3,4)(5,6,7,8,9), (0,7,4,5,9)(1,2,3,8,6), (0,9)(1,6)(2,8)(5,7), (0,3,9)(1,8,7)(2,6,5), (0,6)(4,8)(5,9), (0,2,8,9)(1,3,6,4)(5,7)]\n \n\nLineárny kód vygenerovaný z kontrolnej matice: \n[15, 6] linear code over GF(2)\n \n\nGenerujúca matica lineárneho kódu: \n \n\n[1 0 1 0 1 0 0 0 0 0 0 1 1 0 0]\n[0 1 1 0 0 0 0 0 0 1 0 1 1 1 0]\n[0 0 0 1 1 0 1 0 0 0 0 0 0 1 1]\n[0 0 0 0 0 1 1 0 1 0 0 0 1 1 1]\n[0 0 0 0 0 0 0 1 1 1 0 0 1 1 0]\n[0 0 0 0 0 0 0 0 0 0 1 1 1 1 1]\n \n\nMaximalny pocet slov zakodovanych v kode: \n64\n \n\nMinimálna vzdialenost v kóde: \n0.236328125000000\n"}︡{"stdout":"5"}︡{"stdout":"\n \n\nOverenie vypoctom G * Ht = {nulova matica}: \n[1 0 1 0 1 0 0 0 0 0 0 1 1 0 0]\n[0 1 1 0 0 0 0 0 0 1 0 1 1 1 0]\n[0 0 0 1 1 0 1 0 0 0 0 0 0 1 1]\n[0 0 0 0 0 1 1 0 1 0 0 0 1 1 1]\n[0 0 0 0 0 0 0 1 1 1 0 0 1 1 0]\n[0 0 0 0 0 0 0 0 0 0 1 1 1 1 1]\nx\n[1 1 0 0 0 0 0 0 0 0]\n[1 0 0 0 1 0 0 0 0 0]\n[1 0 0 0 0 1 0 0 0 0]\n[0 1 1 0 0 0 0 0 0 0]\n[0 1 0 0 0 0 1 0 0 0]\n[0 0 1 1 0 0 0 0 0 0]\n[0 0 1 0 0 0 0 1 0 0]\n[0 0 0 1 1 0 0 0 0 0]\n[0 0 0 1 0 0 0 0 1 0]\n[0 0 0 0 1 0 0 0 0 1]\n[0 0 0 0 0 1 0 1 0 0]\n[0 0 0 0 0 1 0 0 1 0]\n[0 0 0 0 0 0 1 0 1 0]\n[0 0 0 0 0 0 1 0 0 1]\n[0 0 0 0 0 0 0 1 0 1]\n=\n[0 0 0 0 0 0 0 0 0 0]\n[0 0 0 0 0 0 0 0 0 0]\n[0 0 0 0 0 0 0 0 0 0]\n[0 0 0 0 0 0 0 0 0 0]\n[0 0 0 0 0 0 0 0 0 0]\n[0 0 0 0 0 0 0 0 0 0]\n \n\nPermutation Group with generators [(2,3)(6,7)(8,11)(9,15)(10,12)(13,14), (2,4)(3,5)(6,8)(7,10)(11,14)(12,13), (2,5)(3,4)(6,12)(7,11)(8,13)(10,14), (1,2,8,6,4)(3,10,9,7,5)(11,14,12,15,13)]\n \n\npočet automorfizmov z lineárneho kódu: \n120\n \n\nOverenie vypoctom: \nMoorové ohraničenie potencionálnej klietky - pocet vrcholov: M(3,5) = 10\nRozmer uvažovanej minimalnej matice Kodu:  10 x 15\nObvod cyklu v incidencnej matici:  10\nMinimalny pocet hran:  15\n"}︡{"done":true}









