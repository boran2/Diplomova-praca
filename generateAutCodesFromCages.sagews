︠fe7f27ac-7812-48c0-9e10-5855e8a65743r︠
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
        permutations = getPermutationsOfAutomorphisms(getCageGraph(k,g))
        if not os.path.exists('AutomorphismGroups'):
            os.makedirs('AutomorphismGroups')
        startTime = datetime.datetime.now()
        file = open('AutomorphismGroups/AutGroup_Cage_'+str(k)+'_'+str(g)+'.txt', 'w')
        file.write("[\n")
        for i in range(len(permutations)):
            file.write("\t" +str(permutations[i]))
            if i < len(permutations) - 1:
                file.write(",")
            file.write("\n")
        file.write("]")
        file.close()
        time = datetime.datetime.now() - startTime
        print('\t  '+'Subor AutGroup_Cage'+'('+str(k)+','+str(g)+') '+'bol uspesne vytvoreny! Doba trvania: '+str(time.total_seconds()) +'s\n')

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
def getCageGraph(k,g):

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
    return setNonZeroVerticesLabels(cage);

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
main();
︡c2fc3b90-88e1-4c99-bfe2-e55d6a91ff69︡{"stdout":"\t  Súbor AutGroup_Cage(3,5) bol uspesne vytvoreny! Doba trvania: 0.000542s\n\n\t  Súbor AutGroup_Cage(6,4) bol uspesne vytvoreny! Doba trvania: 4.579863s\n"}︡{"stdout":"\n\t  Súbor AutGroup_Cage(3,6) bol uspesne vytvoreny! Doba trvania: 0.001023s\n"}︡{"stdout":"\n\t  Súbor AutGroup_Cage(4,5) bol uspesne vytvoreny! Doba trvania: 0.00026s\n"}︡{"stdout":"\n\t  Súbor AutGroup_Cage(3,7) bol uspesne vytvoreny! Doba trvania: 0.000193s\n\n\t  Súbor AutGroup_Cage(3,8) bol uspesne vytvoreny! Doba trvania: 0.003195s\n"}︡{"stdout":"\n\t  Súbor AutGroup_Cage(7,5) bol uspesne vytvoreny! Doba trvania: 1.013412s\n"}︡{"stdout":"\n\t  Súbor AutGroup_Cage(4,7) bol uspesne vytvoreny! Doba trvania: 0.058499s\n\n\t  Súbor AutGroup_Cage(3,10) bol uspesne vytvoreny! Doba trvania: 0.00039s\n"}︡{"stdout":"\n\t  Súbor AutGroup_Cage(3,11) bol uspesne vytvoreny! Doba trvania: 0.00043s\n\n\t  Súbor AutGroup_Cage(10,5) bol uspesne vytvoreny! Doba trvania: 0.00034s\n\n\t  Súbor AutGroup_Cage(11,5) bol uspesne vytvoreny! Doba trvania: 0.000318s\n"}︡{"stdout":"\n\t  Súbor AutGroup_Cage(12,5) bol uspesne vytvoreny! Doba trvania: 0.001401s\n"}︡{"stdout":"\n\t  Súbor AutGroup_Cage(4,9) bol uspesne vytvoreny! Doba trvania: 0.000816s\n"}︡{"stdout":"\n\t  Súbor AutGroup_Cage(13,5) bol uspesne vytvoreny! Doba trvania: 0.000273s\n\n\t  Súbor AutGroup_Cage(4,10) bol uspesne vytvoreny! Doba trvania: 0.003989s\n"}︡{"stdout":"\n\t  Súbor AutGroup_Cage(3,14) bol uspesne vytvoreny! Doba trvania: 0.000569s\n"}︡{"stdout":"\n\t  Súbor AutGroup_Cage(7,7) bol uspesne vytvoreny! Doba trvania: 0.001561s\n"}︡{"stdout":"\n\t  Súbor AutGroup_Cage(3,16) bol uspesne vytvoreny! Doba trvania: 0.000951s\n"}︡{"stdout":"\n\t  Súbor AutGroup_Cage(7,8) bol uspesne vytvoreny! Doba trvania: 0.11255s\n"}︡{"stdout":"\n\t  Súbor AutGroup_Cage(5,10) bol uspesne vytvoreny! Doba trvania: 0.027394s\n"}︡{"stdout":"\n\t  Súbor AutGroup_Cage(3,17) bol uspesne vytvoreny! Doba trvania: 0.011742s\n"}︡{"stdout":"\n\t  Súbor AutGroup_Cage(3,18) bol uspesne vytvoreny! Doba trvania: 0.057579s\n"}









