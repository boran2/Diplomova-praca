︠ddd6b450-df28-4d6a-94d1-600a82bd533ar︠
import random
import glob
import os

# zoradi textove subory generujucich matic podla velkosti, nacita ich a zobrazi data
def main():
    if not os.path.exists('GeneratorMatrices'):
            os.makedirs('GeneratorMatrices')
    filepaths = glob.glob('GeneratorMatrices/*.txt');
    sortedfilepaths = sortParityCheckFilesBySize(filepaths);
    for i in range(len(sortedfilepaths) - 1):
        if os.path.getsize(sortedfilepaths[i]) > 0:
            file = open(sortedfilepaths[i], 'r');
            G = getMatrixFormG(file);
            file.close();
            C = LinearCode(G);
            print(getCageName(sortedfilepaths[i]));
            print('Počet automorfizmov AutGroup(C) = '+ str(getNumberOfAut(C)));
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

# zisti pocet automorfizmov
def getNumberOfAut(C):
    return C.permutation_automorphism_group().order();

# zoradi textove subory na zaklade velkosti
def sortParityCheckFilesBySize(filepaths):
    filepaths = sorted( filepaths, key =  lambda x: os.stat(x).st_size);
    return filepaths;
main()
︡b0962a1e-33c5-4cc8-90dd-557be1da6ca6︡{"stdout":"Cage(3,5):\nPočet automorfizmov AutGroup(C) = 120"}︡{"stdout":"\n\n\nCage(3,6):\nPočet automorfizmov AutGroup(C) = 336\n\n\nCage(3,7):\nPočet automorfizmov AutGroup(C) = 32"}︡{"stdout":"\n\n\nCage(3,8):\nPočet automorfizmov AutGroup(C) = 1440"}︡{"stdout":"\n\n\nCage(4,5):\nPočet automorfizmov AutGroup(C) = 24"}︡{"stdout":"\n\n\nCage(6,4):\nPočet automorfizmov AutGroup(C) = 1036800"}









