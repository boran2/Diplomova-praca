︠6a13f954-0995-476d-a384-8161a3d8d2e5︠
# vypocet Moorovho ohranicenia pre uvazovanu klietku
def calculateMooreBound(k,g):
    M = 0;
    if g % 2 == 1:
        exp = (g - 3) / 2;
        for i in range(Integer(exp) + 1):
            M = M + (k * ((k - 1) ^ i));
            print(M);
        M = M + 1;
    else:
        exp = (g - 2)/2;
        for i in range(Integer(exp) + 1):
            M = M + ((k - 1) ^ i);
        M = 2 * M;
    return M;

print("M(3,5) = "+ str(calculateMooreBound(3,5)));
print("M(3,6) = "+ str(calculateMooreBound(3,6)));
print("M(3,7) = "+ str(calculateMooreBound(3,7)));
print("M(3,8) = "+ str(calculateMooreBound(3,8)));
print("M(3,10) = "+ str(calculateMooreBound(3,10)));
print("M(3,11) = "+ str(calculateMooreBound(3,11)));
print("M(3,14) = "+ str(calculateMooreBound(3,14)));
print("M(3,16) = "+ str(calculateMooreBound(3,16)));
print("M(3,17) = "+ str(calculateMooreBound(3,17)));
print("M(3,18) = "+ str(calculateMooreBound(3,18)));
print("M(3,20) = "+ str(calculateMooreBound(3,20)));
print("M(3,23) = "+ str(calculateMooreBound(3,23)));
print("M(3,25) = "+ str(calculateMooreBound(3,25)));
print("M(4,5) = "+ str(calculateMooreBound(4,5)));
print("M(4,7) = "+ str(calculateMooreBound(4,7)));
print("M(4,9) = "+ str(calculateMooreBound(4,9)));
print("M(4,10) = "+ str(calculateMooreBound(4,10)));
print("M(5,10) = "+ str(calculateMooreBound(5,10)));
print("M(6,4) = "+ str(calculateMooreBound(6,4)));
print("M(7,5) = "+ str(calculateMooreBound(7,5)));
print("M(7,7) = "+ str(calculateMooreBound(7,7)));
print("M(7,8) = "+ str(calculateMooreBound(7,8)));
print("M(10,5) = "+ str(calculateMooreBound(10,5)));
print("M(11,5) = "+ str(calculateMooreBound(11,5)));
print("M(12,5) = "+ str(calculateMooreBound(12,5)));
print("M(13,5) = "+ str(calculateMooreBound(13,5)));
︡832d247d-0aaf-455a-8877-be9039e7180b︡{"stdout":"3\n9\nM(3,5) = 10\n"}︡{"stdout":"M(3,6) = 14\n"}︡{"stdout":"3\n9\n21\nM(3,7) = 22\n"}︡{"stdout":"M(3,8) = 30\n"}︡{"stdout":"M(3,10) = 62\n"}︡{"stdout":"3\n9\n21\n45\n93\nM(3,11) = 94\n"}︡{"stdout":"M(3,14) = 254\n"}︡{"stdout":"M(3,16) = 510\n"}︡{"stdout":"3\n9\n21\n45\n93\n189\n381\n765\nM(3,17) = 766\n"}︡{"stdout":"M(3,18) = 1022\n"}︡{"stdout":"M(3,20) = 2046\n"}︡{"stdout":"3\n9\n21\n45\n93\n189\n381\n765\n1533\n3069\n6141\nM(3,23) = 6142\n"}︡{"stdout":"3\n9\n21\n45\n93\n189\n381\n765\n1533\n3069\n6141\n12285\nM(3,25) = 12286\n"}︡{"stdout":"4\n16\nM(4,5) = 17\n"}︡{"stdout":"4\n16\n52\nM(4,7) = 53\n"}︡{"stdout":"4\n16\n52\n160\nM(4,9) = 161\n"}︡{"stdout":"M(4,10) = 242\n"}︡{"stdout":"M(5,10) = 682\n"}︡{"stdout":"M(6,4) = 12\n"}︡{"stdout":"7\n49\nM(7,5) = 50\n"}︡{"stdout":"7\n49\n301\nM(7,7) = 302\n"}︡{"stdout":"M(7,8) = 518\n"}︡{"stdout":"10\n100\nM(10,5) = 101\n"}︡{"stdout":"11\n121\nM(11,5) = 122\n"}︡{"stdout":"12\n144\nM(12,5) = 145\n"}︡{"stdout":"13\n169\nM(13,5) = 170\n"}︡{"done":true}









