︠f0f317c9-bd0f-4f91-bdec-6a9a4a51084er︠
import random
import glob
import os

def main():
    filepaths = glob.glob("GeneratorMatrices/*.txt");
    sortedfilepaths = sortParityCheckFilesBySize(filepaths);
    for i in range(len(sortedfilepaths) - 1):
        if os.path.getsize(sortedfilepaths[i]) > 0:
            file = open(sortedfilepaths[i], "r");
            G = getMatrixFormG(file);
            file.close();
            C = LinearCode(G);
            n = G.ncols();
            m = getMaxNumberOfCodewords(G)
            d = C.minimum_distance();
            print(getCageName(sortedfilepaths[i]));
            print("Minimalna vzdialenost v kode: "+ str(d));
            print("Maximalny pocet kodovych slov: "+ str(m));
            print("Rozmer matice G: "+ str(G.nrows()) +" x "+str(n));
            print("Ukazovatel perfektneho kodu: "+ str(perfectCodeParameter(n,m,d)));
            print("Počet automorfizmov: "+ str(getNumberOfAut(C)));
            print("\n");
        else:
            print("File " + str(sortedfilepaths[i]) +" is Empty! I can not get Generator matrix!\n");
            continue;

# udava vzdialenost nasho kodu od perfektneho v intervale 0 - 1, kedy 1 je perfektny kod 23,2^12,7 7,2^4,3
def perfectCodeParameter(n,M,d):
    if d % 2 == 1:
        t = (d-1)/2;     # t=(d-1)/2 pre neparne
    else:
        t = (d-2)/2;     # parne (d-1)/2 dostavam desatinne cislo, uvazujem len cele, preto d-2
    sum = 0.0;
    for i in range(0,t+1):
        sum = sum + combinationNumber(n,i);
    parameter = (M*sum)/(2^n)
    return parameter;

def factorial(n):
    fact = 1;
    for i in range(1,n+1):
        fact = fact * i
    return fact;

def combinationNumber(n,k):
    return factorial(n)/(factorial(k)*factorial(n-k));

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

def getCageName(filepath):
    filepath = filepath.replace("GeneratorMatrices/G_","");
    filepath = filepath.replace("cage_","Cage(");
    filepath = filepath.replace("_",",");
    filepath = filepath.replace(".txt","):");
    return filepath;

def getCageGirth(filepath):
    filepath = filepath.replace("GeneratorMatrices/G_cage_","");
    filepath = filepath.replace("_"," ");
    filepath = filepath.replace(".txt","");
    numbers = filepath.split();
    return int(numbers[1]);

def getMaxNumberOfCodewords(G):
    return 2^G.nrows();

def getNumberOfAut(C):
    return C.permutation_automorphism_group().order();

def sortParityCheckFilesBySize(filepaths):
    filepaths = sorted( filepaths, key =  lambda x: os.stat(x).st_size);
    return filepaths;
main()
︡6fbbe016-f6d7-4203-bf66-aacc4e391694︡









