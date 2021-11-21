︠5a0d20b0-f177-40e5-8baa-c08e9b3d1e6es︠
import random
import glob
import os
import datetime

def main():
    filepaths = glob.glob("ParityCheckMatrices/*.txt");
    sortedfilepaths = sortParityCheckFilesBySize(filepaths);
    for i in range(len(sortedfilepaths) - 1):
        startTime = datetime.datetime.now();
        if os.path.getsize(sortedfilepaths[i]) > 0:
            file = open(sortedfilepaths[i], "r");
            H = getParityCheckMatrixFromFile(file);
            file.close();
            G = getGeneratorMatrix(H);
            sortedfilepaths[i] = sortedfilepaths[i].replace("ParityCheckMatrices","GeneratorMatrices");
            sortedfilepaths[i] = sortedfilepaths[i].replace("H_","G_");
            file = open(sortedfilepaths[i], "w");
            file.write(str(G));
            sortedfilepaths[i] = sortedfilepaths[i].replace("GeneratorMatrices/","");
            time = datetime.datetime.now() - startTime;
            print(str(sortedfilepaths[i]) +" was created It takes "+str(time.total_seconds()) +" seconds!\n");
            file.close();
        else:
            print("File " + str(sortedfilepaths[i]) +" is Empty! I can not create Generator matrix!\n");
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

def sortParityCheckFilesBySize(filepaths):
    filepaths = sorted( filepaths, key =  lambda x: os.stat(x).st_size);
    return filepaths;
main()
︡dbf1bc1e-4c31-4a82-83c4-129a59b07f47︡{"stdout":"File ParityCheckMatrices/H_cage_5_10.txt is Empty! I can not create Generator matrix!\n\nG_cage_3_5.txt was created It takes 0.138893 seconds!\n"}︡{"stdout":"\nG_cage_3_6.txt was created It takes 0.008094 seconds!\n\nG_cage_6_4.txt was created It takes 0.023425 seconds!\n\nG_cage_4_5.txt was created It takes 0.035214 seconds!\n\nG_cage_3_7.txt was created It takes 0.012612 seconds!\n\nG_cage_3_8.txt was created It takes 0.038965 seconds!\n"}︡{"stdout":"\nG_cage_3_10.txt was created It takes 0.122525 seconds!\n"}︡{"stdout":"\nG_cage_7_5.txt was created It takes 0.313708 seconds!\n"}︡{"stdout":"\nG_cage_4_7.txt was created It takes 0.491547 seconds!\n"}︡{"stdout":"\nG_cage_3_11.txt was created It takes 0.302232 seconds!\n"}︡{"stdout":"\nG_cage_10_5.txt was created It takes 4.301232 seconds!\n"}︡{"stdout":"\nG_cage_11_5.txt was created It takes 7.569623 seconds!\n"}︡{"stdout":"\nG_cage_4_9.txt was created It takes 3.712241 seconds!\n"}︡{"stdout":"\nG_cage_3_14.txt was created It takes 4.374459 seconds!\n"}︡{"stdout":"\nG_cage_12_5.txt was created It takes 16.815769 seconds!\n"}︡{"stdout":"\nG_cage_4_10.txt was created It takes 8.913213 seconds!\n"}︡{"stdout":"\nG_cage_13_5.txt was created It takes 28.722554 seconds!\n"}︡{"stdout":"\nG_cage_3_16.txt was created It takes 28.298541 seconds!\n"}︡{"stdout":"\nG_cage_7_7.txt was created It takes 57.653349 seconds!\n"}︡{"stdout":"\n"}︡{"done":true}︡









