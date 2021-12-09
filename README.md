# Diplomova-praca
téma: Grupy automorfizmov lineárnych kódov a lineárne kódy s predpísanou grupou automorfizmov

## Popis projektu
Lineárne kódy sú podpriestory konečnorozmerných vektrorových priestorov nad konečnými poľami. Majú preto bohaté grupy automorfizmov, ktoré zároveň obsahujú množstvo informácií o uvažovanom kóde. Určenie úplnej grupy automorfizmov kódu je výpočtovo náročná úloha. Namiesto určenia grupy automorfizmov pre daný kód sa preto uvažuje obrátená úloha zostrojenia kódu s predpísanou grupou automorfizmov. Cieľom práce je preskúmať oba smery tejto interakcie.

Jedným zo spôsobov ako je možné vygenerovať lineárny LDPC kód je pomocou klietky (pravidelný k-regulárny graf s obvodom g). Z klietok je možné zistiť incidenčnú maticu ako aj grupy automorfizmov.

## Ukážka riešenia č.1
Prostredie: CoCalc (http://cocalc.com/) - online aplikácia na spúšťanie Sage projektov
1. je potrebné vyplniť jednoduchú registráciu
2. Po úspešnom registrovaní je potrebné zadať token: tEym4xMQrcpX5Gs5 (vpravo hore v projektoch je input "project invite token") a stlačiť enter
3. Mal by sa Vám zobraziť projekt s viacerými súbormi a 3 adresármi

### 1. Generovanie klietok a rekordných grafov

#### 1. Sage grafy ako vstupné dáta
otvoriť a spustiť generateCageAndLinearCodeByParameters.sagew - potrebné meniť k,g parametre
podľa nasledovného zoznamu klietok: [[3,5], [3,6], [3,7], [3,8], [3,10], [4,5], [7,5]]

#### 2. Zoznam susedností ako vstupné dáta
otvoriť a spustiť generateCageAndLinearCodeByParameters.sagew - potrebné meniť k,g parametre
podľa nasledovného zoznamu klietok: [[3,14], [3,16], [3,17], [3,18], [3,20], [3,23], [3,25], [4,7], [4,9], [4,10], [5,10], [7,7], [7,8], [10,5], [11,5], [12,5], [13,5]]

#### 3. Vlastný návrh generovania Cage(6,4)
otvoriť a spustiť generateCageAndLinearCodeByParameters.sagew - potrebné nastaviť parametre  k=6, g=4

#### 4. Zistenie Moorovho ohraničenia
otvoriť a spustiť MooreBoundsCageValidation.sagew

### 2. Získavanie údajov z klietok alebo rekordných grafov
otvoriť a spustiť generateCageAndLinearCodeByParameters.sagew - potrebné meniť k,g parametre alebo
otvoriť a spustiť cagesData.sagew - funguje pre všetky uložené klietky a rekordné grafy

### 3. Lineárny kód a generujúca matica
otvoriť a spustiť generateCageAndLinearCodeByParameters.sagew - potrebné meniť k,g parametre alebo 
otvoriť a spustiť generateGeneratorMatrices.sagew - funguje pre takmer všetky uložené kontrolné matice
#### 1. Ukladanie kontrolných matíc
otvoriť a spustiť generateParityCheckMatrices.sagew - funguje pre takmer všetky klietky alebo otvoriť generateParityCheckMatricesFromCages a sledovať ako skript vytvára/updejtuje kontrolné matice v priečinku ParityCheckMatrices vo forme textových súborov

#### 2. Ukladanie generujúcich matíc
otvoriť a spustiť generateGeneratorMatrices.sagew - funguje pre takmer všetky uložené kontrolné matice alebo otvoriť generateGeneratorMatricesFromParityCheckMatrices a sledovať ako skript vytvára/updejtuje kontrolné matice v priečinku GeneratorMatrices vo forme textových súborov zo získaných kontrolných matíc, ktoré sme uvažovali v bode 6

#### 3. Minimálna kódová vzdialenosť
otvoriť a spustiť generateCageAndLinearCodeByParameters.sagew - potrebné meniť k,g parametre (funguje pre g <= 8) alebo 
otvoriť a spustiť minDistanceLinearCodes.sagew - funguje pre niektore uložené generujúce matice (g <= 8) alebo
otvoriť a spustiť linearCodesData.sagew - funguje pre niektore generujúce matice (g <= 8) 

#### 4. Počet slov v kóde
otvoriť a spustiť generateCageAndLinearCodeByParameters.sagew - potrebné meniť k,g parametre alebo
otvoriť a spustiť maxnWordsLinearCodes.sagew - funguje pre všetky uložené generujúce matice alebo
otvoriť a spustiť linearCodesData.sagew - funguje pre všetky uložené generujúce matice 

#### 5. Počet automorfizmov
otvoriť a spustiť generateCageAndLinearCodeByParameters.sagew - potrebné meniť k,g parametre alebo
otvoriť a spustiť autLinearCodesData.sagew - funguje pre všetky uložené generujúce matice alebo
otvoriť a spustiť linearCodesData.sagew - funguje pre všetky uložené generujúce matice 

#### 6. Rozmer generujúcej matice a dĺžka lin. kódu
otvoriť a spustiť generateCageAndLinearCodeByParameters.sagew - potrebné meniť k,g parametre alebo
otvoriť a spustiť sizeNLinearCodesData.sagew - funguje pre všetky uložené generujúce matice alebo
otvoriť a spustiť linearCodesData.sagew - funguje pre všetky uložené generujúce matice 

#### 7. Porovnanie s perfektnými kódmi
otvoriť a spustiť generateCageAndLinearCodeByParameters.sagew - potrebné meniť k,g parametre, funguje keď poznáme minimálnu vzdialenosť alebo
otvoriť a spustiť perfectLinearCodesParameter.sagew - funguje pre všetky uložené generujúce matice, kde poznáme minimálnu vzdialenosť alebo
otvoriť a spustiť linearCodesData.sagew - funguje pre všetky uložené generujúce matice, kde poznáme minimálnu vzdialenosť

## Ukážka riešenia č.2 (optimalizácia softvérového riešenia)
Prostredie: SageMath príkazový riadok (https://www.sagemath.org/)
1. je potrebné stiahnúť inštalačný súbor a spustiť ho
2. vytvoria sa 3 súbory, Sage príkazový riadok, Sage notebook a Sage shell
3. V Sage príkazovom riadku je potrebné sa dostať do priečinka s projektom a spustiť pomocou load("main.py")

Konzolová aplikácia consoleAppCages: https://github.com/boran2/consoleAppCages.
Zahŕňa vyššie zmieňenú optimalizovanú funkcionalitu vrámci jedného projektu. Požívateľ sa naviguje na základe čísel v menu.

## PDF- verzia:
LaTex_Diplomova_Praca.pdf

## testovanie:
### 1. Testovanie získaných klietok a rekordných grafov
otvoriť a spustiť generateCageAndLinearCodeByParameters.sagew - potrebné meniť k,g parametre, otestuje počet vrcholov a hran ako aj ci moze klietka existovat

### 2. Testovanie lineárneho kódu
otvoriť a spustiť generateCageAndLinearCodeByParameters.sagew - potrebné meniť k,g parametre - otestuje ci kod existuje 
otvoriť a spustiť linearCodeValidation.sagew - funguje pre existujúce uložené dvojice kontrolných a generujúcich matíc vzniknutých z rovnakej klietky - otestuje ci kod existuje 

### 3. Testovanie textových súborov
otvoriť a spustiť generateGeneratorMatrices.sagew - otestuje ci nahodou subor s kontrolnou maticou nie je prazdny

## vízie do budúcna:
zostrojiť lineárne kódy priamo z klietkovej grupy automorfizmov.
Koľko existuje kódov s touto grupou automorfizmov?

##  linky na publikácie:
https://www.combinatorics.org/ojs/index.php/eljc/article/view/DS16
https://digital.library.adelaide.edu.au/dspace/bitstream/2440/45525/8/02whole.pdf
https://doc.sagemath.org/html/en/reference/graphs/sage/graphs/generic_graph.html
http://assets.cambridge.org/97805217/82807/sample/9780521782807ws.pdf
https://eprint.iacr.org/2012/409.pdf
http://dspace.hebron.edu/jspui/bitstream/123456789/788/1/On%20the%20automorphism%20groups%20of%20some%20linear%20codes.pdf
https://doc.sagemath.org/pdf/en/reference/coding/coding.pdf
https://books.google.sk/books?hl=sk&lr=&id=UTxjBX9lKoMC&oi=fnd&pg=PP13&dq=a+first+course+in+coding+theory+hill&ots=5FjjAq0uTG&sig=j5rDG7eAUBlrzGbZ38VT34DSoH0&redir_esc=y#v=onepage&q=a%20first%20course%20in%20coding%20theory%20hill&f=false
https://publications.waset.org/12279/low-complexity-high-performance-ldpc-codes-based-on-defected-fullerene-graphs
https://www.win.tue.nl/~aeb/codes/binary-1.html
http://cs.indstate.edu/ge/CAGES/index.html
http://opac.crzp.sk/?fn=detailBiblioForm&sid=65CF89236B0A7E124DD17CE040F7&seo=CRZP-detail-kniha

##  link na prácu v LATEX:
overleaf: https://www.overleaf.com/read/fdkwtgxntwjs


