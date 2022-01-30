︠import random

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
    cage = setNonZeroVerticesLabels(cage)
    getAndshowCageInformations(cage,g);

# nastavi vrcholy od 1 po pocet vrcholov pre danu klietku
def setNonZeroVerticesLabels(cage):
    vertices = []
    for vertex in range(len(cage.vertices(sort=False))):
        vertices.append(vertex + 1)
    cage.relabel(vertices)
    return cage

# vrati zoznam automorfizmov z klietky vo forme permutacii
def getPermutationsOfAutomorphisms(cage):
    vertices = cage.vertices()
    automorphismGroup = cage.automorphism_group().list()
    permutations = []
    for i in range(len(automorphismGroup)):
        if i > 0:
            automorphism = str(automorphismGroup[i])
            for vertex in vertices:
                if str(vertex) not in automorphism:
                    automorphism += '(' + str(vertex) + ')';
            permutations.append(str(automorphism))
    return permutations

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
    graph.show(figsize=10);
    autGroup = len(graph.automorphism_group())
    permutations = getPermutationsOfAutomorphisms(graph)
    print('************************************************************************************************************************************************************************\n');
    print('Grupy automorfizmov: ');
    print('Počet automorfizmov z klietky autGroup = ' + str(autGroup) + ' \n');
    print(' \n')
    Gchecker = [];
    for i in range(len(permutations)):
        p = Permutation(permutations[i]);
        graph.relabel(p);
        Hnew = getParityCheckMatrix(graph);
        Gnew = getGeneratorMatrix(Hnew)
        if Gnew not in Gchecker:
            Gchecker.append(Gnew);
        print(str(i+1) +'. Automorfizmus ' + str(permutations[i]) + ' \n');
        graph.show(figsize=10);
        print('Kontrolna matica H:  \n' + str(Hnew) + ' \n');
        print('Generujúca matica lineárneho kódu G: \n' + str(Gnew) + ' \n');
    if len(Gchecker) == 1:
        print('Vsetky generujuce matice su identicke \n');
    else:
        print(Gchecker);
        print('\n');
    print('************************************************************************************************************************************************************************\n');

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

main()