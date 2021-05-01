import random
import re

def main():
#     k = input("Zadajte stupen vrchola k pre klietku ");
#     g = input("Zadajte obvod g pre klietku ");
    k = 4;
    g = 7;

    print(' \n')
    print("Cage("+str(k)+","+str(g)+")\n");

    constructCage(k,g);

# sledujeme 3 mnoziny uvazovanych klietok s ktorymi porovnavame parametre, pre kazdu skupinu sa grafy generuju inym sposobom
def constructCage(k,g):
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

    computeCageMinInformations(k,g);
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
        cage = generateGraphandCageFromExoosAdjencylist("ExoosCages/cage_"+str(k)+"_"+str(g)+".txt");
    elif cageInput in myConstructedCages:
        if k == 6 and g == 4:
            cage = generate_6_4CageGraph();
    getAndshowCageInformations(cage);

# vypocita minimalny pocet vrcholov klietky (odhad)
def minNumberOfVertices(k,g):
    minM = 0;
    if g % 2 == 1:
        exp = (g - 3)/2;
        for i in range(exp + 1):
            minM = minM + (k * ((k - 1)^i));
        minM = minM + 1;
    else:
        exp = (g - 2)/2;
        for i in range(exp + 1):
            minM = minM + ((k - 1)^i);
        minM = 2*minM;
    return minM;

# vypocita velkost kodu na zaklade minimalneho poctu vrcholov (odhad)
def codeSize(m,k):
    row = m;
    column = numberOfEdges(m,k);
    size = str(row) + " x " + str(column);
    return size;

# vypocita pocet hran na zaklade minimalneho poctu vrcholov (odhad)
def numberOfEdges(m,k):
    return m * k / 2;

# get cycles of permutation order g
# def getAllgirthPermutations(m,g):
#     cycles = []
#     CN = CyclicPermutationGroup(m)
#     for permutation in CN:
#         if permutation.order() == g:
#             perm = str(permutation)
#             perm = perm.replace('(', '')
#             arr = perm.split(')');
#             cycle = []
#             for i in range(len(arr) - 1):
#                 cycle = arr[i].split(",");
#                 cycles.append(cycle);
#     return convertStringVerticesinGirthToInt(cycles);

# def convertStringVerticesinGirthToInt(cycles):
#     Intcycles = [];
#     for cycle in cycles:
#         intcycle = []
#         for i in range(len(cycle)):
#             intcycle.append(int(cycle[i]) -1);
#         Intcycles.append(intcycle);
#     return Intcycles;

# vygeneruje 64 klietku z bipartitneho grafu
def generate_6_4CageGraph():
    m = minNumberOfVertices(6,4);
    s =[]
    for i in range(m/2):
        s.append(6);
    graph = graphs.DegreeSequenceBipartite(s,s);
    for i in range (m):
        graph.set_vertex(i, str(i))
    graph.name("Cage (6,4)");
    return graph;


# def addCycleEdgesToGraph(obvod, graph):
#     for i in range(len(obvod)-1):
#         graph.add_edge((obvod[i],obvod[i+1]))
#     graph.add_edge((obvod[0],obvod[len(obvod)-1]))
#     return graph;

# ziska udaje na zaklade grafu (presne udaje)
def getAndshowCageInformations(graph):
    show(graph);
    graph.show3d(spin=True);
    allCycles = graph.cycle_basis();
    print(' \n')
    print('cykly: ');
    print(len(allCycles));
    print(allCycles);
    print(' \n')
    print('hrany: ');
    print(len(graph.edges()));
    print(graph.edges());
    print(' \n')
    print('Matica kodu: ');
    print(graph.incidence_matrix());
    print(' \n')
    print('pocet automorfizmov: ');
    print(len(graph.automorphism_group()));
    print(' \n')
    print('grupy automorfizmov: ');
    print(graph.automorphism_group().list());

# odhad na zaklade poctu vrcholov
def computeCageMinInformations(k,g):
    minimalnyPocetVrcholov = minNumberOfVertices(k,g);
    print('minimalny pocet vrcholov: ', minimalnyPocetVrcholov);
    rozmerMaticeKodu = codeSize(minimalnyPocetVrcholov,k);
    print('rozmer minimalnej matice Kodu: ', rozmerMaticeKodu);
    matrixGirth = 2*g;
    print('obvod cyklu v matici: ', matrixGirth);
    pocetHran = numberOfEdges(minimalnyPocetVrcholov,k);
    print('minimalny pocet hran: ', pocetHran);

def remove_values_from_list(the_list, val):
    return [value for value in the_list if value != val]

# parsovanie Exoo dokumentov so susednymi vrcholmi pre generovanie grafu
def generateGraphandCageFromExoosAdjencylist(filePath):
    file = open(filePath, "r");
    graph = graphs.EmptyGraph();
    mainVertex = 0;
    for line in file:
        line = line.replace('\n', '');
        adjencyVerticies = line.split(" ");
        adjencyVerticies = remove_values_from_list(adjencyVerticies, '');
        for adjencyVertex in adjencyVerticies:
            graph.add_edge(mainVertex, int(adjencyVertex));
        mainVertex += 1;
    file.close();
    return graph;

main()