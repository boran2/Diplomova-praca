import random
import glob
import os

# zoradi textove subory generujucich matic podla velkosti, nacita ich a zobrazi data
def main():
    filepaths = glob.glob('GeneratorMatrices/*.txt');
    sortedfilepaths = sortParityCheckFilesBySize(filepaths);
    for i in range(len(sortedfilepaths) - 1):
        if os.path.getsize(sortedfilepaths[i]) > 0:
            file = open(sortedfilepaths[i], 'r');
            G = getMatrixFormG(file);
            file.close();
            m = getMaxNumberOfCodewords(G);
            print(getCageName(sortedfilepaths[i]));
            print('Maximalny pocet kodovych slov m = '+ str(m));
            print('\n');
        else:
            print('Súbor ' + str(sortedfilepaths[i]) +' je prázdny! Neviem získať generujúcu maticu!\n');
            continue;

# prevedie obsah suboru do maticovaej formy
def getMatrixFormG(file):
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
    return matrix(GF(2),H);

# z nazvu suboru zisti meno matice
def getCageName(filepath):
    filepath = filepath.replace('GeneratorMatrices/G_','');
    filepath = filepath.replace('cage_','Cage(');
    filepath = filepath.replace('_',',');
    filepath = filepath.replace('.txt','):');
    return filepath;

# zisti pocet kodovych slov
def getMaxNumberOfCodewords(G):
    return 2^G.nrows();

# zoradi textove subory na zaklade velkosti
def sortParityCheckFilesBySize(filepaths):
    filepaths = sorted( filepaths, key =  lambda x: os.stat(x).st_size);
    return filepaths;
main()





