# Diplomova-praca
téma: Grupy automorfizmov lineárnych kódov a lineárne kódy s predpísanou grupou automorfizmov

## Popis projektu
Lineárne kódy sú podpriestory konečnorozmerných vektrorových priestorov nad konečnými poľami. Majú preto bohaté grupy automorfizmov, ktoré zároveň obsahujú množstvo informácií o uvažovanom kóde. Určenie úplnej grupy automorfizmov kódu je výpočtovo náročná úloha. Namiesto určenia grupy automorfizmov pre daný kód sa preto uvažuje obrátená úloha zostrojenia kódu s predpísanou grupou automorfizmov. Cieľom práce je preskúmať oba smery tejto interakcie.

Jedným zo spôsobov ako je možné vygenerovať lineárny LDPC kód je pomocou klietky (pravidelný k-regulárny graf s obvodom g). Z klietok je možné zistiť incidenčnú maticu ako aj grupy automorfizmov.

## Ukážka čiastkových riešení
Prostredie: CoCalc (http://cocalc.com/) - online aplikácia na spúšťanie Sage projektov
1. je potrebné vyplniť jednoduchú registráciu
2. Po úspešnom registrovaní je potrebné zadať token: tEym4xMQrcpX5Gs5 (vpravo hore v projektoch je input "project invite token") a stlačiť enter
3. Mal by sa Vám zobraziť projekt s 3 sage súbormi, tie pude potrebné otvoriť a spustiť pomocou tlačidla run nasledovným spôsobom:

### 1. Generovanie incidenčných matíc, grúp automorfizmov zo zadaných klietok 
otvoriť findAutoGroupsfromKnownCagesAnd64CageConstruction.sagew - potrebné meniť k,g parametre
podľa nasledovného zoznamu klietok: [[3,5], [3,6], [3,7], [3,8], [3,10], [4,5], [7,5]]

### 2. Generovanie incidenčných matíc, grúp automorfizmov zo zadaného zoznamu susedností
otvoriť findAutoGroupsfromKnownCagesAnd64CageConstruction.sagew - potrebné meniť k,g parametre
podľa nasledovného zoznamu klietok: [[3,14], [3,16], [3,17], [3,18], [3,20], [3,23], [3,25], [4,7], [4,9], [4,10], [5,10], [7,7], [7,8], [10,5], [11,5], [12,5], [13,5]]

### 3. Generovanie klietky a následne incidenčných matíc, grúp automorfizmov
otvoriť findAutoGroupsfromKnownCagesAnd64CageConstruction.sagew - potrebné nastaviť parametre  k=6, g=4

### 4. Experimentálne Generovanie incidenčných matíc
otvoriť generateMatrix.sagew (parametre sú už nastavené, uvažujeme iba existenciu k=6, g=4 klietky)

### 5. Výpočet samostatného Moorového ohraničenia
otvoriť MooreBounds.sagew (parametre sú už nastavené)

### 6. Generovanie kontrolných matíc lineárneho kódu a ukladanie v textovych súboroch
otvoriť findAutoGroupsfromKnownCagesAnd64CageConstruction.sagew  - vygeneruje pre parametre k a g, ktoré je potrebné nastaviť podľa ľubovôle zo zoznamu klietok, ktoré sme uvažovali v bodoch 1, 2 a 3


otvoriť generateParityCheckMatricesFromCages a sledovať ako skript vytvára kontrolné matice v priečinku ParityCheckMatrices vo forme textových súborov

### 7. Vytváranie Generujúcich matíc lineárneho kódu z kontrolných matíc a ukladanie v textovych suboroch
otvoriť findAutoGroupsfromKnownCagesAnd64CageConstruction.sagew  - vygeneruje pre parametre k a g, ktoré je potrebné nastaviť podľa ľubovôle zo zoznamu klietok, ktoré sme uvažovali v bodoch 1, 2 a 3; z uvažovanej matice incidencie dostaneme lineárny kód a generujúcu maticu lin. kódu


otvoriť generateGeneratorMatricesFromParityCheckMatrices a sledovať ako skript vytvára kontrolné matice v priečinku GeneratorMatrices vo forme textových súborov zo získaných kontrolných matíc, ktoré sme uvažovali v bode 6

## PDF- verzia:
LaTex_Diplomova_Praca.pdf

## testovanie:
findAutoGroupsfromKnownCagesAnd64CageConstruction.sagew - vrámci konštrukcie - validácia
Moorove ohraničenie (MooreBounds.sagew)

## vízie do budúcna:
preskúmať možnosti generovania Incidenčných matíc a z nich by sme chceli dostat klietky

preskúmat vzťah medzi incidenčnými maticami, grupami automorfizmov a lineárnych kódov LDPC, dostať sa priamo k LDPC kódom

##  linky na publikácie:
https://www.combinatorics.org/ojs/index.php/eljc/article/view/DS16
https://digital.library.adelaide.edu.au/dspace/bitstream/2440/45525/8/02whole.pdf
https://doc.sagemath.org/html/en/reference/graphs/sage/graphs/generic_graph.html
http://assets.cambridge.org/97805217/82807/sample/9780521782807ws.pdf
https://eprint.iacr.org/2012/409.pdf

##  link na prácu v LATEX:
overleaf: https://www.overleaf.com/read/fdkwtgxntwjs


