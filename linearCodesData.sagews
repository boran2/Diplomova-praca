︠9d8ce885-9926-4ae0-a35b-418f9d675be1r︠
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
            n = G.ncols();
            m = getMaxNumberOfCodewords(G)
            d = C.minimum_distance();
            print(getCageName(sortedfilepaths[i]));
            print('Minimalna vzdialenost v kode d = '+ str(d));
            print('Maximalny pocet kodovych slov m = '+ str(m));
            print('Dlžka lineárneho kódu n = '+ str(n));
            print('Rozmer matice G = '+ str(G.nrows()) +" x "+str(n));
            print('Parameter perfektneho kodu p(n,m,d) = '+ str(perfectCodeParameter(n,m,d)));
            print('Počet automorfizmov AutGroup(C) = '+ str(getNumberOfAut(C)));
            print('\n');
        else:
            print('Súbor ' + str(sortedfilepaths[i]) +' je prázdny! Neviem získať generujúcu maticu!\n');
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

# vypocet faktorialu
def factorial(n):
    fact = 1;
    for i in range(1,n+1):
        fact = fact * i
    return fact;

# vypocet kombinacneho cisla
def combinationNumber(n,k):
    return factorial(n)/(factorial(k)*factorial(n-k));

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

# zisti pocet kodovych slov
def getMaxNumberOfCodewords(G):
    return 2^G.nrows();

# zisti pocet automorfizmov
def getNumberOfAut(C):
    return C.permutation_automorphism_group().order();

# zoradi textove subory na zaklade velkosti
def sortParityCheckFilesBySize(filepaths):
    filepaths = sorted( filepaths, key =  lambda x: os.stat(x).st_size);
    return filepaths;
main()
︡ccc109b0-46ba-4617-95c7-6f1e6f721600︡{"stdout":"Cage(3,5):"}︡{"stdout":"\nMinimalna vzdialenost v kode d = 5\nMaximalny pocet kodovych slov m = 64\nDlžka lineárneho kódu n = 15\nRozmer matice G = 6 x 15\nParameter perfektneho kodu p(n,m,d) = 0.236328125000000\nPočet automorfizmov AutGroup(C) = 120"}︡{"stdout":"\n\n\n** Gap crashed or quit executing 'Read(\"/home/user/.sage/temp/project-376af7c8-9ff4-41d1-b610-f8b2428e9ab4/4189/interface/tmp4509\");' **\nRestarting Gap and trying again\n"}









