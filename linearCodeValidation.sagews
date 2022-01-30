import random
import glob
import os

# zoradi textove subory generujucich matic podla velkosti, nacita ich aj subory kont. matic a spravi vypocet
def main():
    filepathsG = glob.glob('GeneratorMatrices/*.txt');
    sortedfilepathsG = sortParityCheckFilesBySize(filepathsG);
    for i in range(len(sortedfilepathsG) - 1):
        filepathH = getFilepathH(sortedfilepathsG[i]);
        if os.path.getsize(sortedfilepathsG[i]) > 0 and os.path.getsize(filepathH) > 0:
            fileG = open(sortedfilepathsG[i], 'r');
            G = getMatrixForm(fileG);
            fileG.close();
            fileH = open(filepathH, 'r');
            H = getMatrixForm(fileH);
            fileH.close();
            cageName = getCageName(sortedfilepathsG[i]);
            if (isLinearCodeValid(G,H)):
                print(cageName+ ' Kód je validný!');
            else:
                print(cageName+ ' Kód nie je validný!');
        else:
            print('Súbor ' + str(sortedfilepathsG[i]) +' alebo ' + str(filepathH) + ' je prázdny! Nemôžem vykonať validáciu matíc!\n');
            continue;

# prevedie obsah suboru do maticovaej formy
def getMatrixForm(file):
    mat = []
    for line in file:
        line = line.replace('\n', '');
        line = line.replace('[', '');
        line = line.replace(']', '');
        stringRow = line.split(' ');
        row = [];
        for numberCharacter in stringRow:
            row.append(int(numberCharacter))
        mat.append(row);
    return matrix(GF(2), mat);

# z nazvu suboru zisti meno matice
def getCageName(filepath):
    filepath = filepath.replace('GeneratorMatrices/G_','');
    filepath = filepath.replace('cage_','Cage(');
    filepath = filepath.replace('_',',');
    filepath = filepath.replace('.txt','):');
    return filepath;

# zisti nazov suboru pre kontrolnu maticu
def getFilepathH(filepath):
    filepath = filepath.replace('GeneratorMatrices/G_','ParityCheckMatrices/H_');
    return filepath;

# ak je sucet vsetkych elementov matice sucinu G a Ht rovny 0 a sucasne plati ze ma tato matica rovnaky pocet riadkov ako G a rovnaky pocet stlpcov ako H^t potom je kod validny
def isLinearCodeValid(G,H):
    Ht = H.transpose();
    validationMatrix = G * Ht;
    elementsSum = sum(sum(validationMatrix));
    if len(G.column(0)) == len(validationMatrix.column(0)) and len(Ht.row(0)) == len(validationMatrix.row(0)) and elementsSum == 0:
        return True;
    else:
        return False;

# zoradi textove subory na zaklade velkosti
def sortParityCheckFilesBySize(filepaths):
    filepaths = sorted( filepaths, key =  lambda x: os.stat(x).st_size);
    return filepaths;
main()





