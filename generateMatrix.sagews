import numpy;

def main():
    k=6;
    pocetHran = 36;
    m=12;
    print(k)
    generateCageGrafAndAdjacencyMatrix(k,m,pocetHran);

# generovanie nahodneho vektora - prvy riadok incidencnej matice
def generateVector(k,pocetHran):
    ones = [];
    zeros = []
    for i in range(k):
        ones.append(1);
    for i in range(pocetHran - k):
        zeros.append(0);
    resultVector = vector(ones + zeros);
    numpy.random.shuffle(resultVector);
    return resultVector;

# kontrola suctu vahy v stlpci, nesmie presiahnut 2
def checkAllowedSumInColumns(matrixAsList):
    result = 1;
    potentionalAdjacencyMatrix = Matrix(matrixAsList);
    for i in range(len(potentionalAdjacencyMatrix.row(0))):
        if sum(potentionalAdjacencyMatrix.column(i)) > 2:
            result = 0;
        else:
            result = result * 1;
    if result == 1:
        return True;
    else:
        return False;

# vygenerovanie incidencnej matice, ktora obsahuje aj duplicitne hrany
def generateAdjacencyMatrixWithDuplicities(k,m,pocetHran):
    vectorV = generateVector(k,pocetHran);
    matrixAsList = [];
    matrixAsList.append(list(vectorV));
    while len(matrixAsList) < m-2:
        numpy.random.shuffle(vectorV);
        matrixAsList.append(list(vectorV));
        if checkAllowedSumInColumns(matrixAsList) == False and len(matrixAsList) > 0:
            matrixAsList.pop();
    potentionalAdjacencyMatrix = Matrix(matrixAsList);
    vectorV = vector(list(zero_vector(SR, pocetHran)));
    count = 0;
    for i in range(pocetHran):
        if sum(potentionalAdjacencyMatrix.column(i)) == 2:
            vectorV[i] = 0;
        else:
            if sum(potentionalAdjacencyMatrix.column(i)) == 0 and count < k:
                vectorV[i] = 1;
                count += 1;

    for i in range(pocetHran-1, 0, -1):
        if sum(potentionalAdjacencyMatrix.column(i)) == 1 and count < k:
            vectorV[i] = 1;
            count += 1;
    matrixAsList.append(list(vectorV));

    potentionalAdjacencyMatrix = Matrix(matrixAsList);
    vectorV = vector(list(zero_vector(SR, pocetHran)));
    for i in range(pocetHran):
        if sum(potentionalAdjacencyMatrix.column(i)) == 2:
            vectorV[i] = 0;
        else:
            vectorV[i] = 1;
    matrixAsList.append(list(vectorV));
    return Matrix(matrixAsList);

# Odstranenie duplicity pre incidencnu maticu
def getIncompleteAdjacencyMatrixWithoutDuplicity(k,m,pocetHran,graph):
    while len(list(set(graph.edges()))) != pocetHran:
        adjacencyMatrix = generateAdjacencyMatrixWithDuplicities(k,m,pocetHran);
        graph = Graph(adjacencyMatrix);
        if (len(list(set(graph.edges()))) == pocetHran-2):
            break;
    resultEdges = list(set(graph.edges()));
    resultGraph = Graph();
    resultGraph.add_edges(resultEdges);
    return resultGraph.incidence_matrix();

# doplnenie matice dopocitanim chybajucich hran
def fillInIncompleteMatrix(k,matrix):
    listV = [];
    resultMatrixAsList = [];
    times = 0;
    for i in range(len(matrix.column(0))):
        listV = list(matrix[i]);
        if sum(matrix[i]) == k:
            listV.append(0);
            listV.append(0);
        elif sum(matrix[i]) == (k - 2):
            listV.append(1);
            listV.append(1);
        elif sum(matrix[i]) == (k - 1):
            listV.append(times % 2);
            listV.append((times + 1) % 2);
            times += 1;
        resultMatrixAsList.append(listV);
    return Matrix(resultMatrixAsList);

# spracovanie vyslednej incidencnej matice a vyslednych dat
def generateCageGrafAndAdjacencyMatrix(k,m,pocetHran):
    dosiahnutyPocetHran = 0;
    while dosiahnutyPocetHran != pocetHran:
        adjacencyMatrix = generateAdjacencyMatrixWithDuplicities(k,m,pocetHran);
        graph = Graph(adjacencyMatrix);
        matrix = getIncompleteAdjacencyMatrixWithoutDuplicity(k,m,pocetHran,graph);

        adjacencyMatrix = fillInIncompleteMatrix(k,matrix);
        resultGraph = Graph(adjacencyMatrix);
        dosiahnutyPocetHran = len(list(set(resultGraph.edges())));
        if (dosiahnutyPocetHran == pocetHran):
            break;

    print(adjacencyMatrix);
    getAndshowCageInformations(resultGraph);

# ziska vsetky cykly prechadzajúce vrcholom 0
def getCycles(graph):
    listOfGirths = [];
    listsOfGirthVertices = graph.minimum_cycle_basis(by_weight=False);
    for listOfGirthVertices in listsOfGirthVertices:
        cycleGraph = graph.subgraph(listOfGirthVertices);
        listOfGirths.append(cycleGraph.cycle_basis());
    return listOfGirths;

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
    print('Incidencna matica klietky: ');
    print(graph.incidence_matrix());
    print(' \n')
    print('Pocet grup automorfizmov: ');
    print(len(graph.automorphism_group()));
    print(' \n')
    print('Grupy automorfizmov: ');
    print(graph.automorphism_group().list());

main()






