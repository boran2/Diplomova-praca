︠fe7f27ac-7812-48c0-9e10-5855e8a65743︠
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


# vygeneruje Cage(6,4), bez vstupnych parametrov ako bipartitny graf - individualny pristup
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

# vrati generujucu maticu linearneho kodu
def getGeneratorMatrix(H):
    # vygeneruje lin kod z kontrolnej matice
    C = codes.from_parity_check_matrix(H);
    return C.systematic_generator_matrix();

# realne data na zaklade vypooctov z klietky
def getAndshowCageInformations(graph,g):
    cycles = [];
    graph.show(figsize=10);
    cycles = getCycles(graph);
    ver = len(graph.vertices());
    edg = len(graph.edges(labels=False));
    autGroup = len(graph.automorphism_group())
    R = getRate(ver, edg);
    H = getParityCheckMatrix(graph);
    C = codes.from_parity_check_matrix(H)
    G = getGeneratorMatrix(H)
    n = G.ncols();
    m = getMaxNumberOfCodewords(G)
    d = C.minimum_distance();
    p = perfectCodeParameter(n,m,d)
    Gr = C.permutation_automorphism_group(algorithm = "partition");
    autGroupC = Gr.order()
    print(' \n')
    print('Cykly formujúce klietku: ' + str(cycles) + ' \n');
    print(' \n')
    print('Počet vrcholov klietky ver = ' + str(ver) + ' \n');
    # print(graph.vertices());
    print('Počet hran klietky edg = ' + str(edg) + ' \n');
    # print(graph.edges(labels=False));
    print('Počet automorfizmov z klietky autGroup = ' + str(autGroup) + ' \n');
    # print('Grupy automorfizmov: ');
    # print(graph.automorphism_group().list());
    # print(' \n')
    print('Incidencna matica klietky, Kontrolna matica H:  \n' + str(H) + ' \n');
    print('Informačný pomer R = ' + str(R) + ' \n');
    print('Lineárny kód C = ' + str(C) + ' \n');
    print('Generujúca matica lineárneho kódu G: \n' + str(G) + ' \n');
    print('Maximalny pocet slov zakodovanych v kode m = ' + str(m) + ' \n');
    print('Parameter perfektneho kodu p(n,m,d) = ' + str(p) + ' \n');
    print('Minimálna vzdialenost v kóde d = ' + str(d) + ' \n');
    print('Overenie ci je Lineárny kód validný: '+ str(isLinearCodeValid(G,H)) + ' \n');
#     print('Generatory grup automorfizmov: ');
#     print(C.automorphism_group_gens(equivalence="permutational"))
#     print(' \n')
    print('počet automorfizmov z lineárneho kódu AutGroup(C) = ' + str(autGroupC) + ' \n');

# zisti pocet kodovych slov z generujucej matice G
def getMaxNumberOfCodewords(G):
    return 2^G.nrows();

# udava vzdialenost nasho kodu od perfektneho v intervale 0 - 1, kedy 1 je perfektny kod
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

# vypocet faktorialu
def factorial(n):
    fact = 1;
    for i in range(1,n+1):
        fact = fact * i
    return fact;

# vypocet kombinacneho cisla
def combinationNumber(n,k):
    return factorial(n)/(factorial(k)*factorial(n-k));

# vypocita informacny pomer z matice H
def getRate(nRows, nCols):
    return (nCols - nRows) / nCols;

# testovacie dáta pre porovnanie na základe Moorovho ohraničenia pre potencionálnu klietku
def testingcontrollDataForPotentionalCage(k,g):
    M = calculateMooreBound(k,g);
    minRozmerMaticeH = codeSizeByMooreBound(M,k);
    matrixGirth = 2*g;
    minPocetHran = numberOfEdgesByMooreBound(M,k);
    print('Moorové ohraničenie potencionálnej klietky - pocet vrcholov: M('+str(k)+','+str(g)+') = '+str(M));
    print('Minimalny rozmer matice H = ', minRozmerMaticeH);
    print('Obvod cyklu v incidencnej matici = ', matrixGirth);
    print('Minimalny pocet hran = ', minPocetHran);

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

# ak je sucet vsetkych elementov matice sucinu G a Ht rovny 0 a sucasne plati ze ma tato matica rovnaky pocet riadkov ako G a rovnaky pocet stlpcov ako H^t potom je kod validny
def isLinearCodeValid(G,H):
    Ht = H.transpose();
    validationMatrix = G * Ht;
    elementsSum = sum(sum(validationMatrix));
    if len(G.column(0)) == len(validationMatrix.column(0)) and len(Ht.row(0)) == len(validationMatrix.row(0)) and elementsSum == 0:
        return True;
    else:
        return False;

main()
︡088b732d-0a2d-4c8d-ade2-028660d437f5︡{"stdout":" \n\nCage(3,5)\n\n"}︡{"file":{"filename":"/home/user/.sage/temp/project-376af7c8-9ff4-41d1-b610-f8b2428e9ab4/2767/tmp_ti1wo4fx.svg","show":true,"text":null,"uuid":"819faba1-46e9-4ea2-be6b-58833d10e97a"},"once":false}︡{"stdout":" \n"}︡{"stdout":"\nCykly formujúce klietku: [[[4, 3, 8, 5, 0]], [[1, 2, 3, 4, 0]], [[1, 6, 8, 5, 0]], [[1, 2, 7, 5, 0]], [[4, 9, 7, 5, 0]], [[1, 6, 9, 4, 0]]] \n\n \n\nPočet vrcholov klietky ver = 10 \n\nPočet hran klietky edg = 15 \n\nPočet automorfizmov z klietky autGroup = 120 \n\nIncidencna matica klietky, Kontrolna matica H:  \n[1 1 1 0 0 0 0 0 0 0 0 0 0 0 0]\n[1 0 0 1 1 0 0 0 0 0 0 0 0 0 0]\n[0 0 0 1 0 1 1 0 0 0 0 0 0 0 0]\n[0 0 0 0 0 1 0 1 1 0 0 0 0 0 0]\n[0 1 0 0 0 0 0 1 0 1 0 0 0 0 0]\n[0 0 1 0 0 0 0 0 0 0 1 1 0 0 0]\n[0 0 0 0 1 0 0 0 0 0 0 0 1 1 0]\n[0 0 0 0 0 0 1 0 0 0 1 0 0 0 1]\n[0 0 0 0 0 0 0 0 1 0 0 1 1 0 0]\n[0 0 0 0 0 0 0 0 0 1 0 0 0 1 1] \n\nInformačný pomer R = 0.3333333333333333 \n\nLineárny kód C = [15, 6] linear code over GF(2) \n\nGenerujúca matica lineárneho kódu G: \n[1 0 1 0 1 0 0 0 0 0 0 1 1 0 0]\n[0 1 1 0 0 0 0 0 0 1 0 1 1 1 0]\n[0 0 0 1 1 0 1 0 0 0 0 0 0 1 1]\n[0 0 0 0 0 1 1 0 1 0 0 0 1 1 1]\n[0 0 0 0 0 0 0 1 1 1 0 0 1 1 0]\n[0 0 0 0 0 0 0 0 0 0 1 1 1 1 1] \n\nMaximalny pocet slov zakodovanych v kode m = 64 \n\nParameter perfektneho kodu p(n,m,d) = 0.236328125000000 \n\nMinimálna vzdialenost v kóde d = 5 \n\nOverenie ci je Lineárny kód validný: True \n\npočet automorfizmov z lineárneho kódu AutGroup(C) = 120 \n\n \n\nOverenie vypoctom: \nMoorové ohraničenie potencionálnej klietky - pocet vrcholov: M(3,5) = 10\nMinimalny rozmer matice H =  10 x 15\nObvod cyklu v incidencnej matici =  10\nMinimalny pocet hran =  15\n"}︡{"done":true}









