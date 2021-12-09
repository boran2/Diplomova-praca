︠92f38638-6bb9-48ed-9c3e-ea099b717defr︠
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
            C = LinearCode(G);
            d = C.minimum_distance();
            print('G_'+getCageName(sortedfilepaths[i]));
            print('Minimalna vzdialenost v kode d = '+ str(d));
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

# zoradi textove subory na zaklade velkosti
def sortParityCheckFilesBySize(filepaths):
    filepaths = sorted( filepaths, key =  lambda x: os.stat(x).st_size);
    return filepaths;
main()
︡82394580-c007-4913-92c4-ec6b0ca9c789︡{"stdout":"G_Cage(3,5):"}︡{"stdout":"\nMinimalna vzdialenost v kode d = 5\n\n\nG_Cage(3,6):"}︡{"stdout":"\nMinimalna vzdialenost v kode d = 6\n\n\nG_Cage(3,7):"}︡{"stdout":"\nMinimalna vzdialenost v kode d = 7\n\n\nG_Cage(3,8):"}︡{"stdout":"\nMinimalna vzdialenost v kode d = 8\n\n\nG_Cage(4,5):"}︡{"stdout":"\nMinimalna vzdialenost v kode d = 5\n\n\nG_Cage(6,4):"}









