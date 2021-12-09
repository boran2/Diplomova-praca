︠2f96f74b-3139-4b04-a156-e2d48877cbf7︠
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
            m = getMaxNumberOfCodewords(G);
            print(getCageName(sortedfilepaths[i]));
            print('Maximalny pocet kodovych slov m = '+ str(m));
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

# zisti pocet kodovych slov
def getMaxNumberOfCodewords(G):
    return 2^G.nrows();

# zoradi textove subory na zaklade velkosti
def sortParityCheckFilesBySize(filepaths):
    filepaths = sorted( filepaths, key =  lambda x: os.stat(x).st_size);
    return filepaths;
main()
︡7c1eb39c-f351-495f-b8ab-d0bd0de40e9d︡{"stdout":"Cage(3,5):\nMaximalny pocet kodovych slov m = 64\n\n\nCage(3,6):\nMaximalny pocet kodovych slov m = 256\n\n\nCage(3,7):\nMaximalny pocet kodovych slov m = 8192\n\n\nCage(3,8):\nMaximalny pocet kodovych slov m = 65536\n\n\nCage(4,5):\nMaximalny pocet kodovych slov m = 1048576\n\n\nCage(6,4):\nMaximalny pocet kodovych slov m = 33554432\n\n\nCage(3,10):\nMaximalny pocet kodovych slov m = 68719476736\n\n\nCage(4,7):\nMaximalny pocet kodovych slov m = 295147905179352825856\n\n\nCage(3,11):\nMaximalny pocet kodovych slov m = 144115188075855872\n\n\nCage(7,5):"}︡{"stdout":"\nMaximalny pocet kodovych slov m = 85070591730234615865843651857942052864\n\n\nCage(3,14):"}︡{"stdout":"\nMaximalny pocet kodovych slov m = 12554203470773361527671578846415332832204710888928069025792\n\n\nCage(4,9):"}︡{"stdout":"\nMaximalny pocet kodovych slov m = 3794275180128377091639574036764685364535950857523710002444946112771297432041422848\n\n\nCage(4,10):"}︡{"stdout":"\nMaximalny pocet kodovych slov m = 78804012392788958424558080200287227610159478540930893335896586808491443542994421222828532509769831281613255980613632\n\n\nCage(10,5):"}︡{"stdout":"\nMaximalny pocet kodovych slov m = 409173825987017733751648712103449894027080255755383098685411421012016724550584319360408761540738019643860835515945008876152157068235674131666065948672\n\n\nCage(11,5):"}︡{"stdout":"\nMaximalny pocet kodovych slov m = 82189623461693336050640466920002010399224059419112091554660639110448939910891887845526039629337319550421608888377784651765928628909121935361372105791435638280550369861381946846744746216942542457363957058371584\n\n\nCage(3,16):"}︡{"stdout":"\nMaximalny pocet kodovych slov m = 6243497100631984462763194459586332611497196285329942301718313919250743477639531240240612206126983942319653862242813245790895951358576570612580352\n\n\nCage(12,5):"}︡{"stdout":"\nMaximalny pocet kodovych slov m = 702223880805592151456759840151962786569522257399338504974336254522393264865238137237142489540654437582500444843247630303354647534431314931612685275935445798350655833690880801860555545317367555154113605281582053784524026102900245630757473088050106395169337932361665227499793929447186391815763110662594625536\n\n\nCage(13,5):"}︡{"stdout":"\nMaximalny pocet kodovych slov m = 1270499535481494028555327188398936222975495879793298926430555706836377936971845739503447197477090354595022169672153443333909126739297297962419422193075844819692886903001613811739890545612986273251093679266075416407677450823675351424189758469780061070768108994788960062077443430789581982991482523424184424053597195093156801883141898863370722415634527694059593127528652430487756734464\n\n\n"}︡{"done":true}









