︠b2e00e31-d3a7-469b-bfcc-1257017a5e28r︠
import random
import datetime

# ***************vstupne data*****************
sageCages = [[3,5], [3,6], [3,7], [3,8], [3,10], [3,11], [4,5], [7,5]];
exoosCages = [[3,14], [3,16], [3,17], [3,18], [3,20], [3,23], [3,25], [4,7], [4,9], [4,10], [5,10], [7,7], [7,8], [10,5], [11,5], [12,5], [13,5]];
myConstructedCages = [[6,4]];
# ********************************************

# vygeneruje Kontrolnu maticu, ulozi ju a sleduje cas
def main():
    cages = getSortedCagesByMooreBound();
    for cage in cages:
        k = cage[0];
        g = cage[1];
        startTime = datetime.datetime.now();
        H = getParityCheckMatrixFromCage(k,g);
        file = open('ParityCheckMatrices/H_cage_'+str(k)+'_'+str(g)+'.txt', 'w');
        file.write(str(H));
        time = datetime.datetime.now() - startTime;
        print('Súbor H_Cage('+str(k)+','+str(g)+') ból úspešne vytvorený! Doba trvania: '+str(time.total_seconds()) +'s\n');
        file.close();

# zoradi klietky podla Moorovho ohranicenia
def getSortedCagesByMooreBound():
    cages = sageCages + myConstructedCages + exoosCages;
    sortedCages = [];
    for cage in cages:
        k = cage[0];
        g = cage[1];
        cage.append(calculateMooreBound(k,g))
        sortedCages.append(cage);
    sortedCages.sort(key=takeThird);
    for i in range(len(sortedCages)):
        del sortedCages[i][2];
    return sortedCages;

# element podla ktoreho sa sortuje
def takeThird(elem):
    return elem[2]

# sledujeme 3 zoznamy uvazovanych klietok s ktorymi porovnavame parametre, pre kazdy zoznam sa grafy generuju inym sposobom
def getParityCheckMatrixFromCage(k,g):

    cageInput =[];
    cageInput.append(k);
    cageInput.append(g);

    if ((cageInput in sageCages) == false and (cageInput in exoosCages) == false and (cageInput in myConstructedCages) == false):
        print('\n');
        print('Klietka nie je medzi uvazovanymi alebo neexistuje\n');
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
        cage = generateGraphandCageFromExoosAdjacencylist('ExoosCages/cage_'+str(k)+'_'+str(g)+'.txt');
    elif cageInput in myConstructedCages:
        if k == 6 and g == 4:
            cage = generate_6_4CageGraph();
    if (cageVerification(cage,k,g) == False):
        print('Klietka Cage(' +str(k) +','+str(g) +') neexistuje\n');
        return;
    return getParityCheckMatrix(cage);

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
    graph.name('Cage (6,4)');
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

# odstranenie hodnot zo zoznamu na zaklade hodnoty
def remove_values_from_list(the_list, val):
    return [value for value in the_list if value != val]

# parsovanie Exoo dokumentov so zoznamami susednych vrcholov na generovanie grafu
def generateGraphandCageFromExoosAdjacencylist(filePath):
    file = open(filePath, 'r');
    graph = graphs.EmptyGraph();
    mainVertex = 0;
    for line in file:
        line = line.replace('\n', '');
        adjacencyVerticies = line.split(' ');
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
︡232639b6-1509-4d41-b97f-0f543a068727︡{"stdout":"Súbor H_Cage(3,5) ból úspešne vytvorený! Doba trvania: 0.404025s!\n"}︡{"stdout":"\nSúbor H_Cage(6,4) ból úspešne vytvorený! Doba trvania: 0.119815s!\n"}︡{"stdout":"\nSúbor H_Cage(3,6) ból úspešne vytvorený! Doba trvania: 0.005411s!\n\nSúbor H_Cage(4,5) ból úspešne vytvorený! Doba trvania: 4.387481s!\n"}︡{"stdout":"\nSúbor H_Cage(3,7) ból úspešne vytvorený! Doba trvania: 0.00731s!\n\nSúbor H_Cage(3,8) ból úspešne vytvorený! Doba trvania: 0.084694s!\n\nSúbor H_Cage(7,5) ból úspešne vytvorený! Doba trvania: 0.393734s!\n"}︡{"stdout":"\nSúbor H_Cage(4,7) ból úspešne vytvorený! Doba trvania: 0.215183s!\n"}︡{"stdout":"\nSúbor H_Cage(3,10) ból úspešne vytvorený! Doba trvania: 0.103195s!\n"}︡{"stdout":"\nSúbor H_Cage(3,11) ból úspešne vytvorený! Doba trvania: 0.300632s!\n"}︡{"stdout":"\nSúbor H_Cage(10,5) ból úspešne vytvorený! Doba trvania: 1.885721s!\n"}︡{"stdout":"\nSúbor H_Cage(11,5) ból úspešne vytvorený! Doba trvania: 3.107229s!\n"}︡{"stdout":"\nSúbor H_Cage(12,5) ból úspešne vytvorený! Doba trvania: 6.28572s!\n"}︡{"stdout":"\nSúbor H_Cage(4,9) ból úspešne vytvorený! Doba trvania: 2.815235s!\n"}︡{"stdout":"\nSúbor H_Cage(13,5) ból úspešne vytvorený! Doba trvania: 8.292532s!\n"}︡{"stdout":"\nSúbor H_Cage(4,10) ból úspešne vytvorený! Doba trvania: 6.115313s!\n"}︡{"stdout":"\nSúbor H_Cage(3,14) ból úspešne vytvorený! Doba trvania: 6.781635s!\n"}︡{"stdout":"\nSúbor H_Cage(7,7) ból úspešne vytvorený! Doba trvania: 30.691218s!\n"}︡{"stdout":"\nSúbor H_Cage(3,16) ból úspešne vytvorený! Doba trvania: 29.904034s!\n"}︡{"stdout":"\nSúbor H_Cage(7,8) ból úspešne vytvorený! Doba trvania: 31.619011s!\n"}









