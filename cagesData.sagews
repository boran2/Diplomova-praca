import random
import glob
import os

# zoradi textove subory kontrolnych matic podla velkosti, nacita ich a zobrazi data
def main():
    filepaths = glob.glob('ParityCheckMatrices/*.txt');
    sortedfilepaths = sortParityCheckFilesBySize(filepaths);
    for i in range(len(sortedfilepaths) - 1):
        if os.path.getsize(sortedfilepaths[i]) > 0:
            file = open(sortedfilepaths[i], 'r');
            H = getMatrixFormH(file);
            file.close();
            g = Graph(H);
            ver = len(g.vertices());
            edg = len(g.edges(labels=False));
            print(getCageName(sortedfilepaths[i]));
            print('Pocet vrcholov ver = '+ str(ver));
            print('Pocet hran edg = '+ str(edg));
            print('Rozmer matice H = '+ str(ver) +" x "+str(edg));
            print('Informačny pomer R = '+ str(getRate(ver,edg)));
            print('Počet automorfizmov AutGroup = '+ str(len(g.automorphism_group())));
            print('\n');
        else:
            print('Súbor ' + str(sortedfilepaths[i]) +' je prázdny! Neviem získať kontrolnú maticu H!\n');
            continue;

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
    filepath = filepath.replace('.txt','):');
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




