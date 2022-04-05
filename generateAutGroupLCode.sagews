︠cd6012d9-f940-4182-90c1-7924ba9bf63er︠
import random
import glob
import os
import datetime

# zoradi textove subory kontrolnych matic podla velkosti, nacita ich a zobrazi data
def main():
    filepaths = glob.glob('ParityCheckMatrices/*.txt');
    sortedfilepaths = sortParityCheckFilesBySize(filepaths);
    for i in range(len(sortedfilepaths) - 1):
        if os.path.getsize(sortedfilepaths[i]) > 0:
            file = open(sortedfilepaths[i], 'r');
            H = matrix(GF(2), getMatrixFormH(file));
            file.close();
            permutations = getPermutationsOfAutomorphisms(H)
            C = codes.from_parity_check_matrix(H)
            Gr = C.permutation_automorphism_group(algorithm = "partition");
            autGroupC = Gr.order()
            if not os.path.exists('AutomorphismGroups'):
                os.makedirs('AutomorphismGroups')
            startTime = datetime.datetime.now()
            file = open('AutomorphismGroups/AutGroup_Cage_'+getCageName(sortedfilepaths[i])+'_LINEARCODE.txt', 'w')
            file.write("[\n")
            for j in range(len(permutations)):
                file.write("\t" + str(permutations[j]))
                if j < len(permutations) - 1:
                    file.write(",")
                file.write("\n")
            file.write("]")
            file.close()
            time = datetime.datetime.now() - startTime
            print('\t  '+'Subor AutGroup_Cage'+getCageName(sortedfilepaths[i])+'_LINEARCODE.txt '+'bol uspesne vytvoreny! Doba trvania: '+str(time.total_seconds()) +'s\n')
        else:
            print('Súbor ' + str(sortedfilepaths[i]) +' je prázdny! Neviem získať kontrolnú maticu H!\n');
            continue;

# ziska grupu automorfizmov lin kodu
def getPermutationsOfAutomorphisms(H):
    C = codes.from_parity_check_matrix(H)
    automorphismGroup = C.permutation_automorphism_group().list()
    permutations = []

    graph = Graph(H)
    graph = setDefaultVertices(graph)
    graph = setDefaultEdges(graph)

    edges=graph.edges()
    automorphism = ""
    for i in range(len(automorphismGroup)):
        if i > 0:
            for group in automorphismGroup[i]:
                automorphism += "("
                for edgesInGroup in group:
                    for edgeInGroup in parseEdges(edgesInGroup):
                        for edge in edges:
                            if str(edge[2]) == str(edgeInGroup):
                                automorphism +=  str(edge)
                                continue
                automorphism += ")"
                for edge in edges:
                    if str(edge) not in automorphism:
                        automorphism += '(' + str(edge) + ')'
                permutations.append(str(automorphism))
                automorphism = ""
    return permutations

# nastavi hrany
def parseEdges(group):
    return str(group).replace('(', '').replace(')', '').split(",")

# nastavi vrcholy od 1 po pocet vrcholov pre dany graf
def setDefaultVertices(graph):
    vertices = []
    for vertex in range(len(graph.vertices(sort=False))):
        vertices.append(vertex + 1)
    graph.relabel(vertices)
    return graph

# nastavi lable pre hrany od 1 po pocet hran pre dany graf
def setDefaultEdges(graph):
    edgeId = 0
    for u,v in graph.edge_iterator(labels=None):
        edgeId += 1
        graph.set_edge_label(u, v, str(edgeId))
    return graph

# prevedie obsah suboru do maticovaej formy
def getMatrixFormH(file):
    H = []
    for line in file:
        line = line.replace('\n', '');
        line = line.replace('[', '');
        line = line.replace(']', '');
        stringRow = line.split(" ");
        row = [];
        for numberCharacter in stringRow:
            row.append(int(numberCharacter))
        H.append(row);
    return matrix(H);

# z nazvu suboru zisti meno matice
def getCageName(filepath):
    filepath = filepath.replace('ParityCheckMatrices/H_','');
    filepath = filepath.replace('cage_','Cage(');
    filepath = filepath.replace('_',',');
    filepath = filepath.replace('.txt',')');
    return filepath;

# zisti informacny pomer
def getRate(nRows, nCols):
    return (nCols - nRows) / nCols;

# zisti pocet vrcholov
def getNumberOfVertices(H):
    return len(H.column(0));

# zisti pocet hran
def getNumberOfEdges(H):
    return len(H.row(0));

# zoradi textove subory na zaklade velkosti
def sortParityCheckFilesBySize(filepaths):
    filepaths = sorted( filepaths, key =  lambda x: os.stat(x).st_size);
    return filepaths;
main()
︡e7ec2d45-f445-4066-ba75-f0efb037c657︡{"stdout":"Súbor ParityCheckMatrices/H_cage_3_17.txt je prázdny! Neviem získať kontrolnú maticu H!\n\n\t  Subor AutGroup_CageCage(3,5)_LINEARCODE.txt bol uspesne vytvoreny! Doba trvania: 0.001859s\n"}︡{"stdout":"\n\t  Subor AutGroup_CageCage(3,6)_LINEARCODE.txt bol uspesne vytvoreny! Doba trvania: 0.007829s\n"}









