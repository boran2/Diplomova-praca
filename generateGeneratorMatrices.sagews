︠247f0b27-7fda-48ef-91a9-ce6c023c568e︠
import random
import glob
import os
import datetime

# zoradi textove subory kontrolnych matic podla velkosti, nacita ich a zobrazi data, vygeneruje generujucu maticu, ulozi ju a sleduje cas
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

# zoradi textove subory na zaklade velkosti
def sortParityCheckFilesBySize(filepaths):
    filepaths = sorted( filepaths, key =  lambda x: os.stat(x).st_size);
    return filepaths;

# prevedie obsah suboru do maticovaej formy
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

# ziska generujucu maticu z kontrolnej
def getGeneratorMatrix(H):
    # vygeneruje lin kod z kontrolnej matice
    C = codes.from_parity_check_matrix(H);
    return C.systematic_generator_matrix();

main()
︡b25c4152-0ed8-48ef-b4cf-caada2dfc2c8︡{"stdout":"Súbor ParityCheckMatrices/H_cage_5_10.txt je prázdny! Nemôžem vytvoriť generujúcu maticu!\n\nSúbor G_cage_3_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.291546s\n"}︡{"stdout":"\nSúbor G_cage_3_6.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.006657s\n\nSúbor G_cage_6_4.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.088613s\n\nSúbor G_cage_4_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.091255s\n"}︡{"stdout":"\nSúbor G_cage_3_7.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.01621s\n\nSúbor G_cage_3_8.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.183295s\n"}︡{"stdout":"\nSúbor G_cage_3_10.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.397507s\n"}︡{"stdout":"\nSúbor G_cage_7_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.813764s\n"}︡{"stdout":"\nSúbor G_cage_4_7.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.403556s\n"}︡{"stdout":"\nSúbor G_cage_3_11.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.790816s\n"}︡{"stdout":"\nSúbor G_cage_10_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 9.702839s\n"}︡{"stdout":"\nSúbor G_cage_11_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 17.288196s\n"}︡{"stdout":"\nSúbor G_cage_4_9.txt ból úspešne vytvorený! Doba vytvárania súboru: 8.212577s\n"}︡{"stdout":"\nSúbor G_cage_3_14.txt ból úspešne vytvorený! Doba vytvárania súboru: 9.906763s\n"}︡{"stdout":"\nSúbor G_cage_12_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 39.779141s\n"}︡{"stdout":"\nSúbor G_cage_4_10.txt ból úspešne vytvorený! Doba vytvárania súboru: 16.521656s\n"}︡{"stdout":"\nSúbor G_cage_13_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 56.091509s\n"}︡{"stdout":"\nSúbor G_cage_3_16.txt ból úspešne vytvorený! Doba vytvárania súboru: 61.491279s\n"}︡{"stdout":"\nSúbor G_cage_7_7.txt ból úspešne vytvorený! Doba vytvárania súboru: 130.502766s\n"}︡{"stdout":"\n"}︡{"done":true}









