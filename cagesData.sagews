︠0c96b034-0378-4f4c-b68d-fddecc31228cs︠
import random
import glob
import os

def main():
    filepaths = glob.glob("ParityCheckMatrices/*.txt");
    sortedfilepaths = sortParityCheckFilesBySize(filepaths);
    for i in range(len(sortedfilepaths) - 1):
        if os.path.getsize(sortedfilepaths[i]) > 0:
            file = open(sortedfilepaths[i], "r");
            H = getMatrixFormH(file);
            file.close();
            g = Graph(H);
            v = len(g.vertices());
            e = len(g.edges(labels=False));
            print(getCageName(sortedfilepaths[i]));
            print("Pocet vrcholov: "+ str(v));
            print("Pocet hran: "+ str(e));
            print("Rozmer matice H: "+ str(v) +" x "+str(e));
            print("Počet automorfizmov: "+ str(len(g.automorphism_group())));
            print("\n");
        else:
            print("File " + str(sortedfilepaths[i]) +" is Empty! I can not get Parity check matrix!\n");
            continue;

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

def getCageName(filepath):
    filepath = filepath.replace("ParityCheckMatrices/H_","");
    filepath = filepath.replace("cage_","Cage(");
    filepath = filepath.replace("_",",");
    filepath = filepath.replace(".txt","):");
    return filepath;

def getNumberOfVertices(H):
    return len(H.column(0));

def getNumberOfEdges(H):
    return len(H.row(0));

def sortParityCheckFilesBySize(filepaths):
    filepaths = sorted( filepaths, key =  lambda x: os.stat(x).st_size);
    return filepaths;
main()
︡d0533e0b-4f36-48fb-910d-4d213453d185︡{"stdout":"File ParityCheckMatrices/H_cage_7_8.txt is Empty! I can not get Parity check matrix!\n\nCage(3,5):\nPocet vrcholov: 10\nPocet hran: 15\nRozmer matice H: 10 x 15\nPočet automorfizmov: 120"}︡{"stdout":"\n\n\nCage(3,6):\nPocet vrcholov: 14\nPocet hran: 21\nRozmer matice H: 14 x 21\nPočet automorfizmov: 336\n\n\nCage(6,4):\nPocet vrcholov: 12\nPocet hran: 36\nRozmer matice H: 12 x 36\nPočet automorfizmov: 1036800\n\n\nCage(4,5):\nPocet vrcholov: 19\nPocet hran: 38\nRozmer matice H: 19 x 38\nPočet automorfizmov: 24\n\n\nCage(3,7):\nPocet vrcholov: 24\nPocet hran: 36\nRozmer matice H: 24 x 36\nPočet automorfizmov: 32\n\n\nCage(3,8):\nPocet vrcholov: 30\nPocet hran: 45\nRozmer matice H: 30 x 45\nPočet automorfizmov: 1440\n\n\nCage(3,10):\nPocet vrcholov: 70\nPocet hran: 105\nRozmer matice H: 70 x 105\nPočet automorfizmov: 80\n\n\nCage(7,5):\nPocet vrcholov: 50\nPocet hran: 175\nRozmer matice H: 50 x 175\nPočet automorfizmov: 252000\n\n\nCage(4,7):\nPocet vrcholov: 67\nPocet hran: 134\nRozmer matice H: 67 x 134\nPočet automorfizmov: 4\n\n\nCage(3,11):\nPocet vrcholov: 112\nPocet hran: 168\nRozmer matice H: 112 x 168\nPočet automorfizmov: 64"}︡{"stdout":"\n\n\nCage(10,5):"}︡{"stdout":"\nPocet vrcholov: 124\nPocet hran: 620\nRozmer matice H: 124 x 620\nPočet automorfizmov: 1\n\n\nCage(11,5):"}︡{"stdout":"\nPocet vrcholov: 154\nPocet hran: 847\nRozmer matice H: 154 x 847\nPočet automorfizmov: 1\n\n\nCage(4,9):"}︡{"stdout":"\nPocet vrcholov: 270\nPocet hran: 540\nRozmer matice H: 270 x 540\nPočet automorfizmov: 90\n\n\nCage(3,14):"}︡{"stdout":"\nPocet vrcholov: 384\nPocet hran: 576\nRozmer matice H: 384 x 576\nPočet automorfizmov: 96\n\n\nCage(12,5):"}︡{"stdout":"\nPocet vrcholov: 203\nPocet hran: 1218\nRozmer matice H: 203 x 1218\nPočet automorfizmov: 203\n\n\nCage(4,10):"}︡{"stdout":"\nPocet vrcholov: 384\nPocet hran: 768\nRozmer matice H: 384 x 768\nPočet automorfizmov: 768\n\n\nCage(13,5):"}︡{"stdout":"\nPocet vrcholov: 230\nPocet hran: 1495\nRozmer matice H: 230 x 1495\nPočet automorfizmov: 1\n\n\nCage(3,16):"}︡{"stdout":"\nPocet vrcholov: 960\nPocet hran: 1440\nRozmer matice H: 960 x 1440\nPočet automorfizmov: 96\n\n\n"}︡{"done":true}









