#### Telerilevamento geo-ecologico in R, 2026
###### Luca Barilaro, Scienze e Gestione della Natura


# La gestione della fauna come strumento di biologia della conservazione: eradicazione del muflone ($`Ovis`$ $`aries`$) e analisi preliminare del recupero della vegetazione nell'Isola del Giglio

<img width="2560" height="1702" alt="mufloni_A _Marchese-e15-scaled" src="https://github.com/user-attachments/assets/2115a710-b03b-4413-907a-716cdf5ad9a4" />

> Mufloni nel Parco Nazionale dell'Arcipelago Toscano, Isola del Giglio. [Foto di A. Marchese](https://www.islepark.it/2022/09/02/studiosi-di-chiara-fama-confermano-l-opportunita-di-eradicare-il-muflone-all-isola-del-giglio/)

---

## 1. Introduzione e area di studio 🗺️

Il progetto ***LIFE LETSGO GIGLIO "Less alien species in the Tuscan Archipelago: new actions to protect Giglio Island habitats"***  (LIFE18 NAT/IT/000828) ha previsto delle attività di prelievo finalizzate all'eradicazione del **muflone** (*Ovis aries*) presso l'Isola del Giglio. Il muflone, **specie aliena invasiva** introdotta nell'isola toscana per scopi venatori negli anni '60-'70 del secolo scorso, ha determinato un **sovrasfruttamento degli ecosistemi** di macchia mediterranea, portando a un **degrado della vegetazione**. Complessivamente, in 3 anni di progetto (Febbraio 2021- Marzo 2024) sono stati rimossi 120 mufloni (ulteriori 10 individui sono stati abbattuti nel 2020 in attività di controllo della specie). 

I dati rilevati sui mufloni dell’Isola del Giglio hanno riscontrato una popolazione al **limite della capacità portante**, probabilmente a causa della **scarsità di risorse trofiche** disponibili. Inoltre, è necessario considerare l’**elevata densità** di bovidi riscontrata in alcune zone dell’isola, vista la tendenza alla filopatria e al comportamento spaziale della specie (*Nicoloso S. et al., 2024*). In particolare, quasi tutti gli individui prelevati sono stati registrati nella zona del **Promontorio del Franco**, corrispondente all'area dove erano stati introdotti per la prima volta (*La Russa L., com. pers*). Pertanto, l'analisi spaziale si concentrerà sulla suddetta area. 

<img width="1600" height="1131" alt="Isola_Giglio_Mufloni" src="https://github.com/user-attachments/assets/ced4c933-6cfd-4f4a-aed6-b19c98b6e720" />

> Isola del Giglio. Nel riquadro arancione è indicata l'area di intervento. Mappa del Dott. Lorenzo La Russa


## 2. Obiettivo del progetto in R 🎯

Il presente lavoro ha l'obiettivo di valutare l'impatto degradativo che le specie aliene invasive – nello specifico ungulati introdotti nel contesto insulare – esercitano sulle comunità vegetali autoctone, utilizzando il telerilevamento come strumento di verifica oggettiva. In particolare, il progetto mira a:

- evidenziare l'efficacia e la necessità di interventi di *wildlife management* come strumento fondamentale per la biologia della conservazione, la quale insegna che le specie aliene invasive rappresentano una delle maggiori minacce per la diversità biologica;
- osservare all'interno dell'area di studio quale fosse lo stato della vegetazione prima dell'intervento di eradicazione e valutare se le attività di pascolo e calpestio effettuate dal muflone possano aver peggiorato lo stato della vegetazione. Pertanto, occorre valutare se il piano di rimozione della specie possa aver contribuito, durante e dopo le operazioni, a un miglioramento della biomassa della macchia mediterranea nel sito di presenza.

Pertanto, l'analisi parte dall'ipotesi basata sull'efficacia dell'intervento di eradicazione del muflone valutando lo stato della vegetazione attraverso immagini satellitari Sentinel-2 prelevate in tre momenti temporali:

- **pre-controllo**, aprile/giugno-2020;
- **eradicazione**, aprile/giugno-2023;
- **post-eradicazione**, aprile/giugno-2026.

> [!NOTE]
> La scelta della date è basata su un intervallo di tempo standardizzato di 3 anni tra un periodo e l'altro. Nel dettaglio, il **2020** rappresenta l'anno prima dell'inizio delle attività di eradicazione, mentre il **2023** è l'anno in cui termina la maggior parte delle attività di abbattimento e traslocazione di mufloni dall'Isola (da maggio 2021 a marzo 2023 sono stati abbattuti 38 mufloni e traslocati 52; *Nicoloso S. et al., 2024*). Infine, il **2026**, anno corrente, rappresenta il riferimento per valutare, a due anni dalla conclusione ufficiale delle operazioni di eradicazione, l'eventuale ripresa della vegetazione di macchia mediterranea dell'Isola, con particolare focus sul Promontorio del Franco. 


Gli indici vegetazionali impiegati per le analisi sono:

- **DVI** (*Difference Vegetation Index*), per misurare la quantità assoluta di vegetazione;
- **NDVI** (*Normalized Difference Vegetation Index*), per misurare lo stato di salute della vegetazione;


## 3. Metodologia 🛰️

### 3.1. Acquisizione immagini

Le immagini satellitari provengono da [**Google Earth Engine**](https://earthengine.google.com/), attraverso cui è stata selezionata l'area di intervento per le fasi e le relative date precedentemente indicate.


### 3.2. Importazione e visualizzazione immagini
Una volta ottenute le immagini satellitari, vengono caricate in R. 
Per prima cosa, chiamo i pacchetti necessari:

````r
library(terra)      # Per lavorare con raster e immagini satellitari
library(imageRy)    # Funzioni di visualizzazione rapide
library(viridis)    # Palette di colori
library(ggplot2)    # Pacchetto per la creazione di grafici
library(patchwork)   # 
**AGGIUNGERE**
````

In seguito, imposto la working directory:

````r
setwd("C:/Users/lucab/Desktop/progetto_giglio/data")
````

Ora è possibile importare i raster Sentinel-2 acquisiti:

````r
franco_2020 = rast("franco_2020.tif")  # importato e nominato il primo .tif
plot(franco_2020)                      # visualizzato il primo .tif
dev.off()                              # chiudo il pannello di visualizzazione delle immagini
````
<img width="1280" height="709" alt="franco_2020" src="https://github.com/user-attachments/assets/572aa3c3-ae68-4edb-a325-7327ae2b0e2a" />

> Immagine satellitare nelle 4 bande riguardante l'anno precedente all'intervento di eradicazione

> [!NOTE]
> B2 = Blue; B3 = Green; B4 = Red; B8 = NIR 

````r
franco_2023 = rast("franco_2023.tif")  # importato e nominato il secondo .tif
plot(franco_2023)                      # visualizzato il secondo .tif
dev.off()                              # chiudo il pannello di visualizzazione delle immagini
````
<img width="1280" height="709" alt="franco_2023" src="https://github.com/user-attachments/assets/128aba5e-d9d5-4841-9f4c-2dfabe2e2a5b" />

> Immagine satellitare nelle 4 bande a due anni dall'inizio dell'intervento di eradicazione

````r
franco_2026 = rast("franco_2026.tif")  # importato e nominato il terzo .tif
plot(franco_2026)                      # visualizzato il terzo .tif
dev.off()                              # chiudo il pannello di visualizzazione delle immagini
````
<img width="1280" height="709" alt="franco_2026" src="https://github.com/user-attachments/assets/c489e80f-4093-417e-a66d-1362e0722dc0" />

> Immagine satellitare nelle 4 bande a due anni dalla fine dell'intervento di eradicazione


### 3.3. Visualizzazione immagini in RGB 

````r
im.multiframe(1, 3)  # preparo pannello grafico con 1 riga e 3 colonne usando la funzione di imageRy
im.plotRGB(franco_2020, r = 3, g = 2, b = 1, title = "Pre-eradicazione")  # visualizzo immagini in RGB con funzione di ImageRy
im.plotRGB(franco_2023, r = 3, g = 2, b = 1, title = "Eradicazione") 
im.plotRGB(franco_2026, r = 3, g = 2, b = 1, title = "Post-eradicazione")
dev.off() # chiudo il pannello di visualizzazione delle immagini
````
<img width="1280" height="709" alt="franco_rgb" src="https://github.com/user-attachments/assets/796a24c0-f358-4548-94a4-4773be155ee2" />

> Confronto tra le immagini in RGB delle diverse fasi analizzate


### 3.4. Visualizzazione NIR in Blue

````r
im.multiframe(1, 3) # preparo pannello grafico con 1 riga e 3 colonne usando la funzione di imageRy
# r = 3 (Red), g = 2 (Green), b = 4 (NIR) # imposto NIR nel canale blu
plotRGB(franco_2020, r = 3, g = 2, b = 4, stretch = "lin", main = "Pre-eradicazione (2020)")  # utilizzo funzione pacchetto terra
plotRGB(franco_2023, r = 3, g = 2, b = 4, stretch = "lin", main = "Eradicazione (2023)")      
plotRGB(franco_2026, r = 3, g = 2, b = 4, stretch = "lin", main = "Post-eradicazione (2026)")
dev.off() # chiudo il pannello di visualizzazione delle immagini
````

<img width="1280" height="709" alt="franco_nir_blue" src="https://github.com/user-attachments/assets/f66c5727-1061-45c1-b732-227f58abe1b0" />

> Confronto eseguito con il NIR nel canale del blu nei diversi anni presi in analisi

> [!NOTE]
> Sostituendo il **NIR** al posto della banda del blu (r=3, g=2, b=4), si evidenziano in **blu** le zone di **vegetazione** (alta riflettanza del NIR) e in giallo tutto ciò che non è vegetazione, come suolo nudo e roccia esposta.


### 3.5. Visualizzazione 4 bande separate per le 3 immagini (RGB + NIR)

````r
im.multiframe(3, 4) # visualizzo pannello grafico con 3 righe (anni) e 4 colonne (bande)
plot(franco_2020[[1]], col = viridis(100), main = "2020 - Blue")
plot(franco_2020[[2]], col = viridis(100), main = "2020 - Green")
plot(franco_2020[[3]], col = viridis(100), main = "2020 - Red")
plot(franco_2020[[4]], col = viridis(100), main = "2020 - NIR")

plot(franco_2023[[1]], col = viridis(100), main = "2023 - Blue")
plot(franco_2023[[2]], col = viridis(100), main = "2023 - Green")
plot(franco_2023[[3]], col = viridis(100), main = "2023 - Red")
plot(franco_2023[[4]], col = viridis(100), main = "2023 - NIR")

plot(franco_2026[[1]], col = viridis(100), main = "2026 - Blue")
plot(franco_2026[[2]], col = viridis(100), main = "2026 - Green")
plot(franco_2026[[3]], col = viridis(100), main = "2026 - Red")
plot(franco_2026[[4]], col = viridis(100), main = "2026 - NIR")
dev.off() # chiudo il pannello di visualizzazione delle immagini
````
<img width="1280" height="709" alt="franco_rgb_nir" src="https://github.com/user-attachments/assets/f5061362-a3c6-4b8e-aa9a-94805a41c94f" />

> Confronto tra le 4 bande (colonne) nei diversi anni (righe) presi in analisi

> [!TIP]
> Le bande RGB (B4, B3, B2) mostrano lo spettro visibile, dove i pigmenti fogliari assorbono gran parte della luce. Al contrario, la banda NIR (B8) evidenzia lo stato di salute e la densità della vegetazione strutturale, poiché il mesofillo  delle foglie sane riflette fortemente questa lunghezza d'onda.


## 4. Calcolo degli indici vegetazionali 🌳

Gli indici vegetazionali impiegati per le analisi sono:

- DVI (Difference Vegetation Index), per misurare la quantità assoluta di vegetazione;
- NDVI (Normalized Difference Vegetation Index), per misurare lo stato di salute della vegetazione;


### 4.1. Analisi DVI (Difference Vegetation Index)

Il DVI è uno dei più semplici indici spettrali utilizzati per valutare la presenza e la vitalità della vegetazione. Si calcola sottraendo la riflettanza nel rosso (Red, B4) da quella nel vicino infrarosso (NIR, B8):

$$
DVI = NIR - RED
$$

Le piante sane riflettono molto nel NIR e poco nel rosso; quindi, valori alti di DVI indicano vegetazione vigorosa, mentre valori vicini allo zero o negativi indicano suolo nudo o roccia. Sebbene fornisca un'indicazione diretta della biomassa verde, il DVI è un indice non normalizzato. Questo lo rende utile per analisi comparative rapide quando le condizioni di acquisizione sono simili, ma risente degli effetti topografici e delle ombre, motivo per cui spesso gli si preferisce l'NDVI.

````r
dvi_2020 <- im.dvi(franco_2020, 4, 3)  # utilizzo funzione im.dvi() del pacchetto imageRy 
dvi_2023 <- im.dvi(franco_2023, 4, 3)  # 4 è la banda NIR, 3 è la banda Red
dvi_2026 <- im.dvi(franco_2026, 4, 3)  

im.multiframe(1, 3)  # configuro pannello grafico con 1 riga e 3 colonne usando la funzione di imageRy
plot(dvi_2020, col = viridis(100), range = c(-0.15, 0.45), main = "DVI 2020")   # visualizzo DVI prima dell'eradicazione
plot(dvi_2023, col = viridis(100), range = c(-0.15, 0.45), main = "DVI 2023")   # visualizzo DVI durante il primo anno di eradicazione
plot(dvi_2026, col = viridis(100), range = c(-0.15, 0.45), main = "DVI 2026")   # visualizzo DVI dopo l'eradicazione
dev.off()
````

<img width="1280" height="709" alt="franco_dvi" src="https://github.com/user-attachments/assets/2d3590a7-26be-4007-80c2-8d7d96136507" />

> DVI dei tre periodi presi in analisi


Calcolo la differenza tra il DVI del 2023 e quello del 2020, tra il DVI del 2026 e quello del 2023 e, infine, tra il DVI del 2026 e quello del 2020. 

````r
dvi_diff_fase1  <- dvi_2023 - dvi_2020
dvi_diff_fase2  <- dvi_2026 - dvi_2023
dvi_diff_totale <- dvi_2026 - dvi_2020

im.multiframe(1, 3)  # configuro pannello grafico con 1 riga e 3 colonne usando la funzione di imageRy
plot(dvi_diff_fase1, col = magma(100), range = c(-0.25, 0.25), main = "ΔDVI (2023 - 2020)")
plot(dvi_diff_fase2, col = magma(100), range = c(-0.25, 0.25), main = "ΔDVI (2026 - 2023)")
plot(dvi_diff_totale, col = magma(100), range = c(-0.25, 0.25), main = "ΔDVI (2026 - 2020)")
dev.off()
````

<img width="1280" height="709" alt="franco_deltaDVI" src="https://github.com/user-attachments/assets/7828af1b-9df2-46c0-9d45-e45821919bc8" />

> Confronto dei ΔDVI

> [!NOTE]
> Il confronto mette in risalto una differenza nel Promontorio del Franco, area N-O dell'Isola a elevata densità della specie (*La Russa L., com. pers.*). Gradualmente, si passa da valori più bassi di DVI, indicanti, in termini assoluti, una più bassa quantità di vegetazione, a valori più alti, i quali suggeriscono un progressivo aumento della vegetazione.


### 4.2. Analisi NDVI (Normalized Difference Vegetation Index)

L'NDVI è uno degli indici di vegetazione più diffusi in telerilevamento grazie alla sua capacità di normalizzare le differenze tra immagini acquisite in tempi o condizioni diverse, riducendo gli effetti di disturbo causati dalle ombre e dalla topografia del terreno. Si calcola come il rapporto tra la differenza e la somma delle riflettanze nel vicino infrarosso (NIR) e nel rosso (Red):

$$NDVI = \frac{NIR - Red}{NIR + Red}$$

I valori ottenuti variano strettamente tra $-1$ e $+1$: valori vicini a $+1$ indicano vegetazione densa, strutturata e sana, mentre valori prossimi a $0$ o negativi indicano la totale assenza di fotosintesi, identificando suolo nudo, rocce o acqua. L'NDVI è particolarmente utile per monitorare variazioni nella copertura vegetale nel tempo e valutare stress idrici, dinamiche ecologiche o impatti antropici e faunistici, come nel caso del sovrapascolamento.

````r
ndvi_2020 <- im.ndvi(franco_2020, 4, 3)  
ndvi_2023 <- im.ndvi(franco_2023, 4, 3)  
ndvi_2026 <- im.ndvi(franco_2026, 4, 3)  

im.multiframe(1, 3)  # configuro pannello grafico con 1 riga e 3 colonne usando la funzione di imageRy
plot(ndvi_2020, col = viridis(100), main = "NDVI 2020")  
plot(ndvi_2023, col = viridis(100), main = "NDVI 2023")
plot(ndvi_2026, col = viridis(100), main = "NDVI 2026")
dev.off()
````

<img width="1280" height="709" alt="franco_ndvi" src="https://github.com/user-attachments/assets/ab612930-fabb-45f3-b5d7-e05ac6059b47" />

> NDVI dei tre periodi presi in analisi

Procedo con il calcolo della differenza tra l'NDVI del 2023 e quello del 2020, tra l'NDVI del 2026 e quello del 2023 e, infine, tra l'NDVI del 2026 e quello del 2020.

````r
ndvi_diff_fase1  <- ndvi_2023 - ndvi_2020
ndvi_diff_fase2 <- ndvi_2026 - ndvi_2023
ndvi_diff_totale <- ndvi_2026 - ndvi_2020

im.multiframe(1, 3)  # configuro pannello grafico con 1 riga e 3 colonne usando la funzione di imageRy
plot(ndvi_diff_fase1, col = magma(100), range = c(-0.6, 0.6), main = "ΔNDVI (2023 - 2020)")
plot(ndvi_diff_fase2, col = magma(100), range = c(-0.6, 0.6), main = "ΔNDVI (2026 - 2023)")
plot(ndvi_diff_totale, col = magma(100), range = c(-0.6, 0.6), main = "ΔNDVI (2026 - 2020)")
dev.off()
````

<img width="1280" height="709" alt="franco_deltaNDVI" src="https://github.com/user-attachments/assets/bd7d690c-50a7-4466-a7c0-6fcb8b7b8492" />

>  Confronto dei ΔNDVI

> [!NOTE]
> Il confronto mostra differenze graduali e continue, passando da valori prossimi allo 0 a valori più elevati, i quali suggeriscono un incremento strutturale della biomassa fogliare.


## 5. Visualizzazione dei dati 

### 5.1. Ridgeline Plot

Il Ridgeline Plot dei singoli NDVI consente di confrontare visivamente la distribuzione dell’indice NDVI tra il 2020, il 2023 e il 2026, evidenziando eventuali variazioni nel tempo dei valori assoluti di vegetazione.

````r
franco_ridg <- c(ndvi_2020, ndvi_2023, ndvi_2026)  
# nomino punti sull'asse verticale
names(franco_ridg) <- c("NDVI 2020 (Pre-eradicazione)", "NDVI 2023 (Eradicazione)", "NDVI 2026 (Post-eradicazione)")
im.ridgeline(franco_ridg, scale = 1.2, palette = "viridis") # creo grafico ridgeline con funzione di imageRy
dev.off()
````
<img width="1280" height="709" alt="franco_ridgeline" src="https://github.com/user-attachments/assets/10bd6325-efb6-4899-b764-3ad1378825e4" />

> Ridgeline Plot per confrontare la distribuzione dell'NDVI nei tre anni presi in analisi

> [!IMPORTANT]
> Il Ridgeline Plot dei singoli NDVI offre una conferma statistica al trend osservato da immagini satellitari. Anzitutto, la distribuzione riflette la netta separazione tra le aree fotosinteticamente non attive (background marino, suolo roccioso, etc.), con picco stabile poco inferiore allo 0, e la biomassa insulare. Tra il 2020 e il 2023 le due curve sono quasi sovrapposte, indicando che, a due anni dall'inizio dell'intervento di eradicazione, la vegetazione non mostrava ancora una risposta visibile. Nella curva NDVI del 2026 il picco della vegetazione si sposta verso destra (> 0.75), divenendo più alto. Questo shift della densità di frequenza verso valori più alti dell'indice suggerisce l'incremento globale di vigore vegetativo nell'area analizzata.

Inoltre, sempre tramite Ridgeline Plot, procedo con un confronto tra ΔNDVI 2023-2020, ΔNDVI 2026-2023 e ΔNDVI 2026-2020 al fine di osservare eventuali cambiamenti rispetto alla prima fase di eradicazione, alla seconda fase e alla differenza totale tra un anno prima dell'inizio e due anni dopo la fine del progetto LIFE.

````r
ndvi_diff_fase1 <- ndvi_2023 - ndvi_2020
ndvi_diff_fase2 <- ndvi_2026 - ndvi_2023
ndvi_diff_totale <- ndvi_2026 - ndvi_2020

delta_ridg <- c(ndvi_diff_fase1, ndvi_diff_fase2, ndvi_diff_totale)
names(delta_ridg) <- c("ΔNDVI 2023-2020", "ΔNDVI 2026-2023", "ΔNDVI 2026-2020")
im.ridgeline(delta_ridg, scale = 1.2, palette = "magma")
dev.off()
````

<img width="1280" height="709" alt="franco_ridgeline_delta" src="https://github.com/user-attachments/assets/f9070526-ca3c-49cc-af44-ba2f29715a94" />

> Ridgeline Plot per confrontare la distribuzione dei ΔNDVI

> [!IMPORTANT]
> La distribuzione del ΔNDVI 2023–2020 risulta pressochè centrata attorno allo zero, indicando un cambiamento vegetazionale complessivamente limitato. La distribuzione del ΔNDVI 2026–2023 mostra un progressivo spostamento verso valori positivi, suggerendo un incremento generalizzato dell'attività vegetativa rispetto alle condizioni iniziali antecedenti all'intervento. Infine, ΔNDVI 2026–2023...**TERMINARE**. Questo andamento suggerisce un possibile processo di recupero della vegetazione nel periodo successivo all'intervento di eradicazione, con un aumento dei valori NDVI rispetto alla situazione di riferimento del 2018.


### 5.2. Classificazione per classi NDVI di copertura del suolo

Scelgo il range di valori adatto alla classificazione facendo riferimento agli istogrammi della distribuzione dell'NDVI.

````r
im.multiframe(1, 3)  # configuro il pannello grafico con 1 riga e 3 colonne per gli istogrammi
# genero gli istogrammi per i tre anni del progetto
hist(ndvi_2020, main = "Distribuzione NDVI 2020", xlab = "Valori NDVI")   
hist(ndvi_2023, main = "Distribuzione NDVI 2023", xlab = "Valori NDVI")
hist(ndvi_2026, main = "Distribuzione NDVI 2026", xlab = "Valori NDVI")

# istogramma NDVI 2020
hist(ndvi_2020, 
     xlim = c(-0.6, 0.9), 
     ylim = c(0, 12000), 
     main = "Distribuzione NDVI 2020", 
     col = "lightgray", 
     xlab = "Valori NDVI")

# istogramma NDVI 2023
hist(ndvi_2023, 
     xlim = c(-0.6, 0.9), 
     ylim = c(0, 12000), 
     main = "Distribuzione NDVI 2023", 
     col = "lightgray", 
     xlab = "Valori NDVI")

# istogramma NDVI 2026
hist(ndvi_2026, 
     xlim = c(-0.6, 0.9), 
     ylim = c(0, 12000), 
     main = "Distribuzione NDVI 2026", 
     col = "lightgray", 
     xlab = "Valori NDVI")
dev.off()
````
<details>
<summary>Istogrammi (cliccare qui)</summary> 
  
<img width="1280" height="709" alt="franco_hist" src="https://github.com/user-attachments/assets/cc358c5b-225e-461a-a33d-2c318779603e" />

</details>

Procedo con la classificazione per classi NDVI di copertura del suolo basata sugli istogrammi precedentemente ottenuti.

````r
class_matrix <- matrix(c(
  -Inf,  0.25, 1,   # se NDVI < 0.25: classe 1 (mare / roccia / suolo)
  0.25,  0.65, 2,   # se 0.25 <= NDVI < 0.65: classe 2 (vegetazione rada / macchia degradata)
  0.65,  Inf, 3     # se NDVI >= 0.65: classe 3 (vegetazione densa / macchia in recupero)
), ncol = 3, byrow = TRUE)

class_matrix  # stampa la matrice per controllo grafico

# classificazione dei singoli anni con la funzione classify del pacchetto terra
ndvi_2020_cl <- classify(ndvi_2020, class_matrix)  
ndvi_2023_cl <- classify(ndvi_2023, class_matrix)  
ndvi_2026_cl <- classify(ndvi_2026, class_matrix)  


im.multiframe(1, 3)  # creo un multiframe con 1 riga e 3 colonne per vedere l'evoluzione
# visualizzazione delle mappe classificate
plot(ndvi_2020_cl, col = c("darkblue", "gold", "darkgreen"), main = "NDVI class. 2020", colNA = "black")  
plot(ndvi_2023_cl, col = c("darkblue", "gold", "darkgreen"), main = "NDVI class. 2023", colNA = "black")   
plot(ndvi_2026_cl, col = c("darkblue", "gold", "darkgreen"), main = "NDVI class. 2026", colNA = "black")
dev.off()
````

<img width="1280" height="709" alt="franco_ndvi_class" src="https://github.com/user-attachments/assets/0648181d-28d6-4d3e-9e6f-9f3cdef58622" />

> Classificazione per classi NDVI di copertura del suolo nei tre anni presi in analisi


### 5.3. Calcolo delle frequenze delle classi NDVI di copertura del suolo 

Dalla classificazione precedentemente effettuata ricavo le frequenze delle diverse classi, riportandole in una tabella e, infine, visualizzandole in un diagramma a barre.

````r
freq_2020 <- freq(ndvi_2020_cl)
freq_2023 <- freq(ndvi_2023_cl)
freq_2026 <- freq(ndvi_2026_cl)

# calcolo percentuali moltiplicando il conteggio dei pixel per 100 diviso il totale dei pixel
perc_2020 <- freq_2020$count * 100 / ncell(ndvi_2020_cl)
perc_2023 <- freq_2023$count * 100 / ncell(ndvi_2023_cl)
perc_2026 <- freq_2026$count * 100 / ncell(ndvi_2026_cl)

# creo dataframe
tabella_franco <- data.frame(
  Classi = c("1: mare / roccia", "2: macchia rada", "3: macchia densa"),
  a2020 = round(perc_2020, 2),
  a2023 = round(perc_2023, 2),
  a2026 = round(perc_2026, 2)
)

print(tabella_franco) # visualizzo tabella
````

<div align="center">

| Classi | 2020 | 2023 | 2026
|--- |--- |--- |--- |
|   **1**: mare / roccia | 41.08% | 41.29%  | 40.83% |  
|   **2**: macchia rada | 23.28% | 23.38% | 16.20% | 
|   **3**: macchia densa | 35.64% | 35.33% | 42.98% | 

</div>

     
#### Visualizzazione 

````r
# creo grafico percentuali NDVI 2020
p1 <- ggplot(tabella_franco, aes(x = Classi, y = a2020, fill = Classi)) +    
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c("darkblue", "gold", "darkgreen")) +
  ylim(0, 100) +
  labs(title = "Classi NDVI 2020", y = "% Copertura", x = NULL) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
  legend.position = "none"  # nascondo la legenda per non duplicarla 3 volte
  )

# creo grafico percentuali NDVI 2023
p2 <- ggplot(tabella_franco, aes(x = Classi, y = a2023, fill = Classi)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c("darkblue", "gold", "darkgreen")) +
  ylim(0, 100) +
  labs(title = "Classi NDVI 2023", y = NULL, x = NULL) +  # tolgo asse y per ridondanza
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    legend.position = "none"  # nascondo la legenda per non duplicarla 3 volte
  )

# creo grafico percentuali NDVI 2026
p3 <- ggplot(tabella_franco, aes(x = Classi, y = a2026, fill = Classi)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c("darkblue", "gold", "darkgreen")) +
  ylim(0, 100) +
  labs(title = "Classi NDVI 2026", y = NULL, x = NULL) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    legend.position = "right"
  )

p1 + p2 + p3 # affianco i tre grafici in un'unica riga
dev.off()
````
<img width="1280" height="709" alt="franco_diag_barre_class" src="https://github.com/user-attachments/assets/f2674c0e-b163-4b7b-8830-b21c269e7a98" />

> Diagramma a barre delle classi NDVI di copertura del suolo


## 6. Analisi multitemporale 📈

L'analisi multitemporale è stata applicata per valutare l'evoluzione della risposta vegetazionale prima, durante e dopo l'intervento di eradicazione del muflone dall'Isola del Giglio. Il confronto del ΔNDVI consente di quantificare la variazione del vigore vegetativo rispetto alla condizione iniziale (risposta vegetativa quantitativa), mentre l'analisi delle differenze nella banda del vicino infrarosso (NIR), ovvero la variazione della riflettanza legata alla struttura vegetale, fornisce un'ulteriore indicazione della variazione della struttura e della biomassa vegetale. L'integrazione delle informazioni spettrali e spaziali consente quindi di individuare non solo l'entità del cambiamento, ma anche la sua distribuzione all'interno dell'area di studio.

````r
nir_dif_fase1 <- franco_2023[[4]] - franco_2020[[4]]  # calcolo differenza NIR durante eradicazione
nir_dif_fase2 <- franco_2026[[4]] - franco_2023[[4]]  # calcolo differenza NIR dopo eradicazione
nir_dif_totale <- franco_2026[[4]] - franco_2020[[4]]  # calcolo differenza NIR tra inizio e fine eradicazione
ndvi_dif_fase1 <- ndvi_2023 - ndvi_2020  # calcolo differenza NDVI durante eradicazione
ndvi_dif_fase2 <- ndvi_2026 - ndvi_2023  # calcolo differenza NDVI dopo eradicazione
ndvi_dif_totale <- ndvi_2026 - ndvi_2020  # calcolo differenza NDVI tra inizio e fine eradicazione


im.multiframe(2, 3)  # preparo pannello grafico con 2 righe e 3 colonne
plot(nir_dif_fase1, col = magma(100), range = c(-0.25, 0.25), main = "NIR (2023 - 2020)")
plot(nir_dif_fase2, col = magma(100), range = c(-0.25, 0.25), main = "NIR (2026 - 2023)")
plot(nir_dif_totale, col = magma(100), range = c(-0.25, 0.25), main = "NIR (2026 - 2020)")
plot(ndvi_dif_fase1, col = magma(100), range = c(-0.6, 0.6), main = "NDVI (2023 - 2020)")
plot(ndvi_dif_fase2, col = magma(100), range = c(-0.6, 0.6), main = "NDVI (2026 - 2023)")
plot(ndvi_dif_totale, col = magma(100), range = c(-0.6, 0.6), main = "NDVI (2026 - 2020)")
dev.off()
````

<img width="1280" height="709" alt="franco_multitemp" src="https://github.com/user-attachments/assets/11f7c921-36aa-4466-b1f2-294e939c5cbd" />

> Confronto NIR e NDVI nei periodi presi in analisi

> [!NOTE]
> **MODIFICARE** Nel periodo 2022-2018, il NIR mostra una situazione abbastanza vicina allo 0 nella maggior parte dell'area, con alcune zone più scure e alcune aree più positive. Non emerge una trasformazione generalizzata della struttura vegetale. L'NDVI mostra che nel periodo durante l'intervento non si osserva ancora un segnale netto di recupero vegetazionale su tutta l'area. Questo è coerente con una dinamica ecologica reale: la rimozione della specie target non implica un aumento immediato dell'NDVI. Nel periodo 2026-2018, il NIR evidenzia un aumento più evidente di aree positive rispetto al confronto 2022–2018 e, quindi, maggiore riflettanza nel vicino infrarosso, un possibile aumento della struttura fogliare e maggiore biomassa o copertura vegetale. L'NDVI mostra una risposta più omogenea verso valori positivi, con una quota maggiore di area che presenta un incremento del vigore vegetativo. Pertanto, i risultati suggeriscono un possibile processo di recupero successivo all'intervento di eradicazione.
