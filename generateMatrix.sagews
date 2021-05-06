import numpy;

def main():
    k=6;
    pocetHran = 36;
    m=12;
    print(k)
    generateCageGrafAndAdjancyMatrix(k,m,pocetHran);

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

# no more than 2 HW in column
def checkAllowedSumInColumns(matrixAsList):
    result = 1;
    potentionalAdjancyMatrix = Matrix(matrixAsList);
    for i in range(len(potentionalAdjancyMatrix.row(0))):
        if sum(potentionalAdjancyMatrix.column(i)) > 2:
            result = 0;
        else:
            result = result * 1;
    if result == 1:
        return True;
    else:
        return False;

def generateAdjancyMatrixWithDuplicities(k,m,pocetHran):
    vectorV = generateVector(k,pocetHran);
    matrixAsList = [];
    matrixAsList.append(list(vectorV));
    while len(matrixAsList) < m-2:
        numpy.random.shuffle(vectorV);
        matrixAsList.append(list(vectorV));
        if checkAllowedSumInColumns(matrixAsList) == False and len(matrixAsList) > 0:
            matrixAsList.pop();
    potentionalAdjancyMatrix = Matrix(matrixAsList);
    vectorV = vector(list(zero_vector(SR, pocetHran)));
    count = 0;
    for i in range(pocetHran):
        if sum(potentionalAdjancyMatrix.column(i)) == 2:
            vectorV[i] = 0;
        else:
            if sum(potentionalAdjancyMatrix.column(i)) == 0 and count < k:
                vectorV[i] = 1;
                count += 1;

    for i in range(pocetHran-1, 0, -1):
        if sum(potentionalAdjancyMatrix.column(i)) == 1 and count < k:
            vectorV[i] = 1;
            count += 1;
    matrixAsList.append(list(vectorV));

    potentionalAdjancyMatrix = Matrix(matrixAsList);
    vectorV = vector(list(zero_vector(SR, pocetHran)));
    for i in range(pocetHran):
        if sum(potentionalAdjancyMatrix.column(i)) == 2:
            vectorV[i] = 0;
        else:
            vectorV[i] = 1;
    matrixAsList.append(list(vectorV));
    return Matrix(matrixAsList);

# generate adjancy matrix without last 2 edges
def getIncompleteAdjancyMatrixWithoutDuplicity(k,m,pocetHran,graph):
    while len(list(set(graph.edges()))) != pocetHran:
        adjancyMatrix = generateAdjancyMatrixWithDuplicities(k,m,pocetHran);
        graph = Graph(adjancyMatrix);
        if (len(list(set(graph.edges()))) == pocetHran-2):
            break;
    resultEdges = list(set(graph.edges()));
    resultGraph = Graph();
    resultGraph.add_edges(resultEdges);
    return resultGraph.incidence_matrix();

# fill last 2 edges
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

def generateCageGrafAndAdjancyMatrix(k,m,pocetHran):
    dosiahnutyPocetHran = 0;
    while dosiahnutyPocetHran != pocetHran:
        adjancyMatrix = generateAdjancyMatrixWithDuplicities(k,m,pocetHran);
        graph = Graph(adjancyMatrix);
        matrix = getIncompleteAdjancyMatrixWithoutDuplicity(k,m,pocetHran,graph);

        adjacencyMatrix = fillInIncompleteMatrix(k,matrix);
        resultGraph = Graph(adjacencyMatrix);
        dosiahnutyPocetHran = len(list(set(resultGraph.edges())));
        if (dosiahnutyPocetHran == pocetHran):
            break;

    print(adjacencyMatrix);
    show(resultGraph);
    print(dosiahnutyPocetHran);

main()







