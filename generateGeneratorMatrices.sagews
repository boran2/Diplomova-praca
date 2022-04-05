︠247f0b27-7fda-48ef-91a9-ce6c023c568es︠
import random
import glob
import os
import datetime

# zoradi textove subory kontrolnych matic podla velkosti, nacita ich a zobrazi data, vygeneruje generujucu maticu, ulozi ju a sleduje cas
def main():
    if not os.path.exists('ParityCheckMatrices'):
        os.makedirs('ParityCheckMatrices')
    if not os.path.exists('GeneratorMatrices'):
        os.makedirs('GeneratorMatrices')
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
            print('Subor ' + str(sortedfilepaths[i]) +' ból úspešne vytvorený! Doba vytvárania súboru: '+str(time.total_seconds()) +'s\n');
            file.close();
        else:
            print('Subor ' + str(sortedfilepaths[i]) +' je prázdny! Nemôžem vytvoriť generujúcu maticu!\n');
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
︡6fd3c192-8954-47a2-8e3b-7357c69b3dbe︡{"stdout":"Subor ParityCheckMatrices/H_cage_3_17.txt je prázdny! Nemôžem vytvoriť generujúcu maticu!\n\nSubor G_cage_3_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.122482s\n"}︡{"stdout":"\nSubor G_cage_3_6.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.005483s\n\nSubor G_cage_6_4.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.009665s\n\nSubor G_cage_4_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.041827s\n\nSubor G_cage_3_7.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.011007s\n\nSubor G_cage_3_8.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.017659s\n\nSubor G_cage_3_10.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.181346s\n"}︡{"stdout":"\nSubor G_cage_7_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.319329s\n"}︡{"stdout":"\nSubor G_cage_4_7.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.205821s\n"}︡{"stdout":"\nSubor G_cage_3_11.txt ból úspešne vytvorený! Doba vytvárania súboru: 0.370944s\n"}︡{"stdout":"\nSubor G_cage_10_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 4.089964s\n"}︡{"stdout":"\nSubor G_cage_11_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 8.212427s\n"}︡{"stdout":"\nSubor G_cage_4_9.txt ból úspešne vytvorený! Doba vytvárania súboru: 4.128978s\n"}︡{"stdout":"\nSubor G_cage_3_14.txt ból úspešne vytvorený! Doba vytvárania súboru: 5.897787s\n"}︡{"stdout":"\nSubor G_cage_12_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 19.464351s\n"}︡{"stdout":"\nSubor G_cage_4_10.txt ból úspešne vytvorený! Doba vytvárania súboru: 8.622942s\n"}︡{"stdout":"\nSubor G_cage_13_5.txt ból úspešne vytvorený! Doba vytvárania súboru: 33.89798s\n"}︡{"stdout":"\nSubor G_cage_3_16.txt ból úspešne vytvorený! Doba vytvárania súboru: 31.072873s\n"}︡{"stdout":"\nSubor G_cage_7_7.txt ból úspešne vytvorený! Doba vytvárania súboru: 60.038207s\n"}︡{"stdout":"\nSubor G_cage_7_8.txt ból úspešne vytvorený! Doba vytvárania súboru: 68.971787s\n"}︡{"stdout":"\n"}︡{"done":true}









