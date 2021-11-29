import random
import glob
import os
import datetime

def main():
    filepaths = glob.glob('ParityCheckMatrices/*.txt');
    sortedfilepaths = sortParityCheckFilesBySize(filepaths);
    for i in range(len(sortedfilepaths) - 1):
        startTime = datetime.datetime.now();
        if os.path.getsize(sortedfilepaths[i]) > 0:
            file = open(sortedfilepaths[i], 'r');
            H = getParityCheckMatrixFromFile(file);
            file.close();
            G = getGeneratorMatrix(H);
            sortedfilepaths[i] = sortedfilepaths[i].replace('ParityCheckMatrices','GeneratorMatrices');
            sortedfilepaths[i] = sortedfilepaths[i].replace('H_','G_');
            file = open(sortedfilepaths[i], 'w');
            file.write(str(G));
            sortedfilepaths[i] = sortedfilepaths[i].replace('GeneratorMatrices/','');
            time = datetime.datetime.now() - startTime;
            print('Súbor ' + str(sortedfilepaths[i]) +' ból úspešne vytvorený! Doba vytvárania súboru: '+str(time.total_seconds()) +'s\n');
            file.close();
        else:
            print('Súbor ' + str(sortedfilepaths[i]) +' je prázdny! Nemôžem vytvoriť generujúcu maticu!\n');
            continue;

def getParityCheckMatrixFromFile(file):
    H = []
    for line in file:
        line = line.replace('\n', '');
        line = line.replace('[', '');
        line = line.replace(']', '');
        stringRow = line.split(' ');
        row = [];
        for numberCharacter in stringRow:
            row.append(int(numberCharacter))
        H.append(row);
    return matrix(GF(2),H);

def getGeneratorMatrix(H):
    # vygeneruje lin kod z kontrolnej matice
    C = codes.from_parity_check_matrix(H);
    return C.systematic_generator_matrix();

def sortParityCheckFilesBySize(filepaths):
    filepaths = sorted( filepaths, key =  lambda x: os.stat(x).st_size);
    return filepaths;
main()








