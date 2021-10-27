︠300612bf-45f8-4dde-b3de-bb2749a2e161r︠
import random
import glob
import os

def main():
    filepaths = glob.glob("ParityCheckMatrices/*.txt");
    for i in range(len(filepaths) - 1):
        if os.path.getsize(filepaths[i]) > 0:
            file = open(filepaths[i], "r");
            H = getParityCheckMatrixFromFile(file);
            file.close();
            G = getGeneratorMatrix(H);
            filepaths[i] = filepaths[i].replace("ParityCheckMatrices","GeneratorMatrices");
            filepaths[i] = filepaths[i].replace("H_","G_");
            file = open(filepaths[i], "w");
            file.write(str(G));
            filepaths[i] = filepaths[i].replace("GeneratorMatrices/","");
            print(str(filepaths[i]) +" was created!\n");
            file.close();
        else:
            print("File " + str(filepaths[i]) +" is Empty! I can not create Generator matrix!\n");
            continue;

def getParityCheckMatrixFromFile(file):
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

def getGeneratorMatrix(H):
    # vygeneruje lin kod z kontrolnej matice
    C = codes.from_parity_check_matrix(H);
    return C.systematic_generator_matrix();

main()
︡d29e5c89-b99f-4e26-bd49-9de82bc539be︡{"stdout":"G_cage_3_7.txt was created!\n\nG_cage_7_5.txt was created!\n"}︡{"stdout":"\nFile ParityCheckMatrices/H_cage_3_17.txt is Empty! I can not create Generator matrix\n\nG_cage_3_10.txt was created!\n"}︡{"stdout":"\nG_cage_6_4.txt was created!\n\nG_cage_3_7.txt was created!\n"}︡{"stdout":"\nG_cage_4_5.txt was created!\n"}︡{"stdout":"\nG_cage_3_8.txt was created!\n"}︡{"stdout":"\nG_cage_3_6.txt was created!\n\nG_cage_3_11.txt was created!\n"}









