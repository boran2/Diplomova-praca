︠87c05031-e81e-4bef-badc-c44b45115032s︠
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
︡d52bfd75-ccb0-460c-abb0-07c15edce337︡{"stdout":"Súbor ParityCheckMatrices/H_cage_3_17.txt je prázdny! Neviem získať kontrolnú maticu H!\n\nCage(3,5):\nPocet vrcholov ver = 10\nPocet hran edg = 15\nRozmer matice H = 10 x 15\nInformačny pomer R = 0.3333333333333333\nPočet automorfizmov AutGroup = 120"}︡{"stdout":"\n\n\nCage(3,6):\nPocet vrcholov ver = 14\nPocet hran edg = 21\nRozmer matice H = 14 x 21\nInformačny pomer R = 0.3333333333333333\nPočet automorfizmov AutGroup = 336\n\n\nCage(6,4):\nPocet vrcholov ver = 12\nPocet hran edg = 36\nRozmer matice H = 12 x 36\nInformačny pomer R = 0.6666666666666666\nPočet automorfizmov AutGroup = 1036800\n\n\nCage(4,5):\nPocet vrcholov ver = 19\nPocet hran edg = 38\nRozmer matice H = 19 x 38\nInformačny pomer R = 0.5\nPočet automorfizmov AutGroup = 24\n\n\nCage(3,7):\nPocet vrcholov ver = 24\nPocet hran edg = 36\nRozmer matice H = 24 x 36\nInformačny pomer R = 0.3333333333333333\nPočet automorfizmov AutGroup = 32\n\n\nCage(3,8):\nPocet vrcholov ver = 30\nPocet hran edg = 45\nRozmer matice H = 30 x 45\nInformačny pomer R = 0.3333333333333333\nPočet automorfizmov AutGroup = 1440\n\n\nCage(3,10):"}︡{"stdout":"\nPocet vrcholov ver = 70\nPocet hran edg = 105\nRozmer matice H = 70 x 105\nInformačny pomer R = 0.3333333333333333\nPočet automorfizmov AutGroup = 80\n\n\nCage(7,5):\nPocet vrcholov ver = 50\nPocet hran edg = 175\nRozmer matice H = 50 x 175\nInformačny pomer R = 0.7142857142857143\nPočet automorfizmov AutGroup = 252000\n\n\nCage(4,7):"}︡{"stdout":"\nPocet vrcholov ver = 67\nPocet hran edg = 134\nRozmer matice H = 67 x 134\nInformačny pomer R = 0.5\nPočet automorfizmov AutGroup = 4\n\n\nCage(3,11):\nPocet vrcholov ver = 112\nPocet hran edg = 168\nRozmer matice H = 112 x 168\nInformačny pomer R = 0.3333333333333333\nPočet automorfizmov AutGroup = 64"}︡{"stdout":"\n\n\nCage(10,5):"}︡{"stdout":"\nPocet vrcholov ver = 124\nPocet hran edg = 620\nRozmer matice H = 124 x 620\nInformačny pomer R = 0.8\nPočet automorfizmov AutGroup = 1\n\n\nCage(11,5):"}︡{"stdout":"\nPocet vrcholov ver = 154\nPocet hran edg = 847\nRozmer matice H = 154 x 847\nInformačny pomer R = 0.8181818181818182\nPočet automorfizmov AutGroup = 1\n\n\nCage(4,9):"}︡{"stdout":"\nPocet vrcholov ver = 270\nPocet hran edg = 540\nRozmer matice H = 270 x 540\nInformačny pomer R = 0.5\nPočet automorfizmov AutGroup = 90\n\n\nCage(3,14):"}︡{"stdout":"\nPocet vrcholov ver = 384\nPocet hran edg = 576\nRozmer matice H = 384 x 576\nInformačny pomer R = 0.3333333333333333\nPočet automorfizmov AutGroup = 96\n\n\nCage(12,5):"}︡{"stdout":"\nPocet vrcholov ver = 203\nPocet hran edg = 1218\nRozmer matice H = 203 x 1218\nInformačny pomer R = 0.8333333333333334\nPočet automorfizmov AutGroup = 203\n\n\nCage(4,10):"}︡{"stdout":"\nPocet vrcholov ver = 384\nPocet hran edg = 768\nRozmer matice H = 384 x 768\nInformačny pomer R = 0.5\nPočet automorfizmov AutGroup = 768\n\n\nCage(13,5):"}︡{"stdout":"\nPocet vrcholov ver = 230\nPocet hran edg = 1495\nRozmer matice H = 230 x 1495\nInformačny pomer R = 0.8461538461538461\nPočet automorfizmov AutGroup = 1\n\n\nCage(3,16):"}︡{"stdout":"\nPocet vrcholov ver = 960\nPocet hran edg = 1440\nRozmer matice H = 960 x 1440\nInformačny pomer R = 0.3333333333333333\nPočet automorfizmov AutGroup = 96\n\n\nCage(7,7):"}︡{"stdout":"\nPocet vrcholov ver = 640\nPocet hran edg = 2240\nRozmer matice H = 640 x 2240\nInformačny pomer R = 0.7142857142857143\nPočet automorfizmov AutGroup = 320\n\n\nCage(7,8):"}︡{"stdout":"\nPocet vrcholov ver = 672\nPocet hran edg = 2352\nRozmer matice H = 672 x 2352\nInformačny pomer R = 0.7142857142857143\nPočet automorfizmov AutGroup = 14112"}︡{"stdout":"\n\n\n"}︡{"done":true}









