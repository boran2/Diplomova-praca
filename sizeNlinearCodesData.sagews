︠a3135739-d4ba-4c6b-b621-5a93e74a472e︠
import random
import glob
import os


def main():
    filepaths = glob.glob('GeneratorMatrices/*.txt');
    sortedfilepaths = sortParityCheckFilesBySize(filepaths);
    for i in range(len(sortedfilepaths) - 1):
        if os.path.getsize(sortedfilepaths[i]) > 0:
            file = open(sortedfilepaths[i], 'r');
            G = getMatrixFormG(file);
            file.close();
            C = LinearCode(G);
            n = G.ncols();
            print(getCageName(sortedfilepaths[i]));
            print('Dlžka lineárneho kódu n = '+ str(n));
            print('Rozmer matice G = '+ str(G.nrows()) +" x "+str(n));
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
︡0bf69b49-a2bc-471f-9cc0-a77b1080a883︡{"stdout":"Cage(3,5):"}︡{"stdout":"\nDlžka lineárneho kódu n = 15\nRozmer matice G = 6 x 15\n\n\nCage(3,6):\nDlžka lineárneho kódu n = 21\nRozmer matice G = 8 x 21\n\n\nCage(3,7):\nDlžka lineárneho kódu n = 36\nRozmer matice G = 13 x 36\n\n\nCage(3,8):\nDlžka lineárneho kódu n = 45\nRozmer matice G = 16 x 45\n\n\nCage(4,5):\nDlžka lineárneho kódu n = 38\nRozmer matice G = 20 x 38\n\n\nCage(6,4):\nDlžka lineárneho kódu n = 36\nRozmer matice G = 25 x 36\n\n\nCage(3,10):\nDlžka lineárneho kódu n = 105\nRozmer matice G = 36 x 105\n\n\nCage(4,7):"}︡{"stdout":"\nDlžka lineárneho kódu n = 134\nRozmer matice G = 68 x 134\n\n\nCage(3,11):\nDlžka lineárneho kódu n = 168\nRozmer matice G = 57 x 168\n\n\nCage(7,5):"}︡{"stdout":"\nDlžka lineárneho kódu n = 175\nRozmer matice G = 126 x 175\n\n\nCage(3,14):"}︡{"stdout":"\nDlžka lineárneho kódu n = 576\nRozmer matice G = 193 x 576\n\n\nCage(4,9):"}︡{"stdout":"\nDlžka lineárneho kódu n = 540\nRozmer matice G = 271 x 540\n\n\nCage(4,10):"}︡{"stdout":"\nDlžka lineárneho kódu n = 768\nRozmer matice G = 385 x 768\n\n\nCage(10,5):"}︡{"stdout":"\nDlžka lineárneho kódu n = 620\nRozmer matice G = 497 x 620\n\n\nCage(11,5):"}︡{"stdout":"\nDlžka lineárneho kódu n = 847\nRozmer matice G = 694 x 847\n\n\nCage(3,16):"}︡{"stdout":"\nDlžka lineárneho kódu n = 1440\nRozmer matice G = 481 x 1440\n\n\nCage(12,5):"}︡{"stdout":"\nDlžka lineárneho kódu n = 1218\nRozmer matice G = 1016 x 1218\n\n\nCage(13,5):"}︡{"stdout":"\nDlžka lineárneho kódu n = 1495\nRozmer matice G = 1266 x 1495\n\n\n"}︡{"done":true}









