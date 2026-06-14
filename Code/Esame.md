#### Telerilevamento geo-ecologico in R, 2026
###### Luca Barilaro, Scienze e Gestione della Natura


# La gestione della fauna come strumento di biologia della conservazione: eradicazione del muflone ($`Ovis`$ $`aries`$) e analisi preliminare del recupero della vegetazione nell'Isola del Giglio



<img width="2560" height="1702" alt="mufloni_A _Marchese-e15-scaled" src="https://github.com/user-attachments/assets/2115a710-b03b-4413-907a-716cdf5ad9a4" />

> Mufloni nel Parco Nazionale dell'Arcipelago Toscano, Isola del Giglio. [Foto di A. Marchese](https://www.islepark.it/2022/09/02/studiosi-di-chiara-fama-confermano-l-opportunita-di-eradicare-il-muflone-all-isola-del-giglio/)

---

## 1. Introduzione e area di studio 🗺️

Il progetto ***LIFE LETSGO GIGLIO "Less alien species in the Tuscan Archipelago: new actions to protect Giglio Island habitats"***  (LIFE18 NAT/IT/000828) ha previsto delle attività di prelievo finalizzate all'eradicazione del **muflone** (*Ovis aries*) presso l'Isola del Giglio. Il muflone, **specie aliena invasiva** introdotta sull'isola toscana per scopi venatori negli anni '60-'70 del secolo scorso, ha determinato un **sovrasfruttamento degli ecosistemi** di macchia mediterranea, portando a un **degrado della vegetazione**. 
Complessivamente, in 3 anni di progetto (Febbraio 2021- Marzo 2024) sono stati rimossi 130 mufloni.

I dati rilevati sui mufloni dell’Isola del Giglio hanno riscontrato una popolazione al **limite della capacità portante**, probabilmente a causa della **scarsità di risorse trofiche** disponibili. Inoltre, è necessario considerare l’**elevata densità** di bovidi riscontrata in alcune zone dell’isola, vista la tendenza alla filopatria e al comportamento spaziale della specie. In particolare, quasi tutti gli individui prelevati sono stati registrati nella zona del **promontorio del Franco**, corrispondente all'area dove erano stati introdotti per la prima volta.

<img width="1600" height="1131" alt="Isola_Giglio_Mufloni" src="https://github.com/user-attachments/assets/ced4c933-6cfd-4f4a-aed6-b19c98b6e720" />

> Isola del Giglio. Nel riquadro arancione è indicata l'area di intervento. Mappa del Dott. Lorenzo La Russa



## 2. Obiettivo del progetto in R 🎯

Il presente lavoro ha l'obiettivo di dimostrare l'impatto degradativo che le specie aliene invasive – nello specifico ungulati introdotti nel contesto insulare – esercitano sulle comunità vegetali autoctone, utilizzando il telerilevamento satellitare come strumento di verifica oggettiva. In particolare, il progetto mira a:

- Evidenziare l'efficacia e la necessità di interventi di *wildlife management* come strumento fondamentale per la biologia della conservazione, la quale insegna che le specie aliene invasive rappresentano una delle maggiori minacce per la diversità biologica;
- Dimostrare come le attività di pascolo e calpestio effettuate dal muflone abbiano alterato la biomassa della macchia mediterranea in determinate aree dell'Isola, compromettendo il naturale rinnovamento forestale.

L'analisi si concentra sull'efficacia dell'intervento di eradicazione del muflone valutando lo stato della vegetazione attraverso immagini satellitari Sentinel-2 prelevate in tre momenti temporali:

- **pre-controllo**, **INSERIRE DATA (MESE E ANNO) E CONTESTO**;
- **eradicazione**;
- **post-eradicazione**.

Gli indici vegetazionali impiegati per le analisi sono:

- **NDVI** (*Normalized Difference Vegetation Index*), per misurare lo stato di salute della vegetazione;
- **DVI** (*Difference Vegetation Index*), per misurare la quantità assoluta di vegetazione;
- **Rao's Q**, per misurare la complessità e la biodiversità dell'intero ecosistema.



## 3. Metodologia 🛰️

### 3.1. Acquisizione immagini

Le immagini satellitari provengono da [**Google Earth Engine**](https://earthengine.google.com/), attraverso cui è stata selezionata l'area di intervento per le fasi e le relative date precedentemente indicate.
> [!NOTE]
> Il codice JavaScript utilizzato è quello fornito durante il corso ed è disponibile nel file Codice.js

### 3.2. Importazione e visualizzazione immagini
Una volta ottenute le immagini satellitari, vengono caricate in R. 
Per prima cosa, chiamo i pacchetti necessari:

````r
library(terra)      # Per lavorare con raster e immagini satellitari
library(imageRy)    # Funzioni di visualizzazione rapide
library(viridis)    # Palette di colori
library(ggplot2)    # Pacchetto per la creazione di grafici
library(reshape2)   # Riorganizzazioni dei dati tabellari
**AGGIUNGERE**
````

In seguito, imposto la working directory:

````r
setwd("C:/Users/lucab/Desktop/progetto_giglio/data")
````

Ora è possibile importare i raster Sentinel-2 acquisiti:

````r
pre_2016 = rast("pre_2016.tif")  # importato e nominato il primo .tif
plot(pre_2016)                   # visualizzato il primo .tif 
````

<img width="1280" height="709" alt="pre_2016" src="https://github.com/user-attachments/assets/4a84e702-1dec-442b-99f5-ee7b68b5fbde" />

> Immagine satellitare nelle 4 bande riguardante il periodo antecedente all'intervento di eradicazione

````r
eradicazione_2022 = rast("eradicazione_2022.tif")  # importato e nominato il secondo .tif
plot(eradicazione_2022)                            # visualizzato il secondo .tif
````

<img width="1280" height="709" alt="eradicazione_2022" src="https://github.com/user-attachments/assets/711c3ca4-b85f-4d74-9eeb-b945e0f53130" />

> Immagine satellitare nelle 4 bande a un anno dall'inizio dell'intervento di eradicazione

````r
post_2026 = rast("post_2026.tif")  # importato e nominato il terzo .tif
plot(post_2026)                    # visualizzato il terzo .tif
````

<img width="1280" height="709" alt="post_2026" src="https://github.com/user-attachments/assets/353ef06e-6843-4cbe-8d14-e7b18f9e3c4f" />

> Immagine satellitare nelle 4 bande a due anni dalla fine dell'intervento di eradicazione


### 3.3. Visualizzazione immagini in RGB 

````r
im.multiframe(1, 3)  # preparo pannello grafico con 1 riga e 3 colonne usando la funzione di imageRy
im.plotRGB(pre_2016, r = 3, g = 2, b = 1, title = "Pre-eradicazione")  # visualizzo immagini in RGB con funzione di ImageRy
im.plotRGB(eradicazione_2022, r = 3, g = 2, b = 1, title = "Eradicazione") 
im.plotRGB(post_2026, r = 3, g = 2, b = 1, title = "Post-eradicazione")
dev.off() # chiudo il pannello di visualizzazione delle immagini
````
<img width="1280" height="709" alt="rgb" src="https://github.com/user-attachments/assets/449524b3-738e-482d-9730-c45927637798" />

> Confronto tra le immagini in RGB delle diverse fasi analizzate

### 3.4. Visualizzazione NIR in Blue

````r
im.multiframe(1, 3) # preparo pannello grafico con 1 riga e 3 colonne usando la funzione di imageRy
# r = 3 (Red), g = 2 (Green), b = 4 (NIR) # imposto NIR nel canale blu
plotRGB(pre_2016, r = 3, g = 2, b = 4, stretch = "lin", main = "Pre-eradicazione (2016)")  # utilizzo funzione pacchetto terra
plotRGB(eradicazione_2022, r = 3, g = 2, b = 4, stretch = "lin", main = "Eradicazione (2022)")      
plotRGB(post_2026, r = 3, g = 2, b = 4, stretch = "lin", main = "Post-eradicazione (2026)")
dev.off() # chiudo il pannello di visualizzazione delle immagini
````
<p align="center">
<img width="664" height="664" alt="nir_in_blue" src="https://github.com/user-attachments/assets/ab66c37f-35c4-4ac9-b08e-b73185327ae0" />

> Confronto eseguito con il NIR nel canale del blu nei diversi anni presi in analisi

> [!NOTE]
> Sostituendo il **NIR** al posto della banda del blu (r=3, g=2, b=4), si evidenziano in **blu** le zone di **vegetazione fitta** (alta riflettanza del NIR) e in giallo/rosso tutto ciò che non è vegetazione, come suolo nudo e roccia esposta. In particolare, il colore **rosso** indica suolo esposto in cui, probabilmente, la **vegetazione** è stata **consumata** da elevata attività di **calpestio e pascolamento** effettuata dai mufloni.

### 3.5. Visualizzazione 4 bande separate per le 3 immagini (RGB + NIR)

````r
im.multiframe(3, 4) # visualizzo pannello grafico con 3 righe (anni) e 4 colonne (bande)
plot(pre_2016[[1]], col = viridis(100), range = c(0, 0.5), main = "2016 - Blue")
plot(pre_2016[[2]], col = viridis(100), range = c(0, 0.5), main = "2016 - Green")
plot(pre_2016[[3]], col = viridis(100), range = c(0, 0.5), main = "2016 - Red")
plot(pre_2016[[4]], col = viridis(100), range = c(0, 0.6), main = "2016 - NIR")

plot(eradicazione_2022[[1]], col = viridis(100), range = c(0, 0.5), main = "2022 - Blue")
plot(eradicazione_2022[[2]], col = viridis(100), range = c(0, 0.5), main = "2022 - Green")
plot(eradicazione_2022[[3]], col = viridis(100), range = c(0, 0.5), main = "2022 - Red")
plot(eradicazione_2022[[4]], col = viridis(100), range = c(0, 0.6), main = "2022 - NIR")

plot(post_2026[[1]], col = viridis(100), range = c(0, 0.5), main = "2026 - Blue")
plot(post_2026[[2]], col = viridis(100), range = c(0, 0.5), main = "2026 - Green")
plot(post_2026[[3]], col = viridis(100), range = c(0, 0.5), main = "2026 - Red")
plot(post_2026[[4]], col = viridis(100), range = c(0, 0.6), main = "2026 - NIR")
dev.off() # chiudo il pannello di visualizzazione delle immagini
````
<img width="1280" height="709" alt="rgb_nir" src="https://github.com/user-attachments/assets/9d4ce8bf-a504-4421-9711-0326be702a5d" />

> Confronto tra le 4 bande (colonne) nei diversi anni (righe) presi in analisi

> [!TIP]
> Le bande RGB (B4, B3, B2) mostrano lo spettro visibile, dove i pigmenti fogliari assorbono gran parte della luce. Al contrario, la banda NIR (B8) evidenzia lo stato di salute e la densità della vegetazione strutturale, poiché il mesofillo  delle foglie sane riflette fortemente questa lunghezza d'onda.


## 4. Calcolo degli indici vegetazionali 🌳

Gli indici vegetazionali impiegati per le analisi sono:

- DVI (Difference Vegetation Index), per misurare la quantità assoluta di vegetazione;
- NDVI (Normalized Difference Vegetation Index), per misurare lo stato di salute della vegetazione;
- Rao's Q, per misurare la complessità e la biodiversità dell'intero ecosistema.


### 4.1. Analisi DVI (Difference Vegetation Index)

Il DVI è uno dei più semplici indici spettrali utilizzati per valutare la presenza e la vitalità della vegetazione. Si calcola sottraendo la riflettanza nel rosso (Red, B4) da quella nel vicino infrarosso (NIR, B8):

$$
DVI = NIR - RED
$$

Le piante sane riflettono molto nel NIR e poco nel rosso; quindi, valori alti di DVI indicano vegetazione vigorosa, mentre valori vicini allo zero o negativi indicano suolo nudo o roccia. Sebbene fornisca un'indicazione diretta della biomassa verde, il DVI è un indice non normalizzato. Questo lo rende utile per analisi comparative rapide quando le condizioni di acquisizione sono simili, ma risente degli effetti topografici e delle ombre, motivo per cui spesso gli si preferisce l'NDVI.

````r
dvi_2016 <- im.dvi(pre_2016, 4, 3)   # utilizzo funzione im.dvi() del pacchetto imageRy 
dvi_2022 <- im.dvi(eradicazione_2022, 4, 3)  # 4 è la banda NIR, 3 è la banda Red
dvi_2026 <- im.dvi(post_2026, 4, 3)  

im.multiframe(1, 3)  # preparo pannello grafico con 1 riga e 3 colonne usando la funzione di imageRy
plot(dvi_2016, col = viridis(100), main = "DVI 2016")   # visualizzo DVI prima dell'eradicazione
plot(dvi_2022, col = viridis(100), main = "DVI 2022")   # visualizzo DVI durante il primo anno di eradicazione
plot(dvi_2026, col = viridis(100), main = "DVI 2026")   # visualizzo DVI dopo l'eradicazione
````
<img width="1280" height="709" alt="dvi_new" src="https://github.com/user-attachments/assets/8bb4a1c5-8d19-49f4-97bc-137d66a0acc3" />

> DVI dei tre periodi presi in analisi

Calcolo la differenza tra il DVI del 2016 e quello del 2022 al fine di vedere l'impatto tra il periodo di raggiungimento della capacità portante della specie (già sottoposta dal 2009 a interventi di controllo) e il primo anno di intervento di eradicazione; inoltre, calcolo la differenza tra il DVI del 2016 e quello del 2026, anno corrente.

````r
dvi_diff_fase1  <- dvi_2022 - dvi_2016
dvi_diff_totale <- dvi_2026 - dvi_2016

im.multiframe(1, 2)
plot(dvi_diff_fase1, col = magma(100), range = c(-0.20, 0.30), main = "ΔDVI (2022 - 2016)")
plot(dvi_diff_totale, col = magma(100), range = c(-0.20, 0.30), main = "ΔDVI (2026 - 2016)")
````
<img width="1280" height="709" alt="delta_dvi" src="https://github.com/user-attachments/assets/4509df5e-8253-4d16-911d-f0db6e03f19b" />

> Confronto dei ΔDVI

> [!NOTE]
> In particolare, il confronto mette in evidente risalto una differenza nel Promontorio del Franco, area N-O dell'Isola a elevata densità della specie (*La Russa L., com. pers.*). Si passa da valori negativi, indicanti una diminuzione del valore di DVI e, quindi, una perdita di vegetazione, a valori positivi (rosso-arancio), indicanti una progressiva ricolonizzazione della vegetazione su suolo precedentemente degradato.


### 4.2. Analisi NDVI (Normalized Difference Vegetation Index)

L'NDVI è uno degli indici di vegetazione più diffusi in telerilevamento grazie alla sua capacità di normalizzare le differenze tra immagini acquisite in tempi o condizioni diverse, riducendo gli effetti di disturbo causati dalle ombre e dalla topografia del terreno. Si calcola come il rapporto tra la differenza e la somma delle riflettanze nel vicino infrarosso (NIR) e nel rosso (Red):

$$NDVI = \frac{NIR - Red}{NIR + Red}$$

I valori ottenuti variano strettamente tra $-1$ e $+1$: valori vicini a $+1$ indicano vegetazione densa, strutturata e sana, mentre valori prossimi a $0$ o negativi indicano la totale assenza di fotosintesi, identificando suolo nudo, rocce o acqua. L'NDVI è particolarmente utile per monitorare variazioni nella copertura vegetale nel tempo e valutare stress idrici, dinamiche ecologiche o impatti antropici e faunistici, come nel caso del sovrapascolamento.

````r
ndvi_2016 <- im.ndvi(pre_2016, 4, 3)  
ndvi_2022 <- im.ndvi(eradicazione_2022, 4, 3)  
ndvi_2026 <- im.ndvi(post_2026, 4, 3)  

im.multiframe(1, 3)
plot(ndvi_2016, col = viridis(100), main = "NDVI 2016")  
plot(ndvi_2022, col = viridis(100), main = "NDVI 2022")
plot(ndvi_2026, col = viridis(100), main = "NDVI 2026")
````
<img width="1280" height="709" alt="ndvi" src="https://github.com/user-attachments/assets/673fb7e0-7d92-4b04-8c10-23590dad23bd" />

> NDVI dei tre periodi presi in analisi

Procedo con il calcolo della differenza tra l'NDVI del 2016 e quello del 2022 e il calcolo della differenza tra l'NDVI del 2016 e quello del 2026, anno corrente.

````r
ndvi_diff_fase1  <- ndvi_2022 - ndvi_2016
ndvi_diff_totale <- ndvi_2026 - ndvi_2016

im.multiframe(1, 2) # configuro il pannello grafico con 1 riga e 2 colonne
plot(ndvi_diff_fase1, col = magma(100), range = c(-0.6, 0.6), main = "ΔNDVI (2022 - 2016)")
plot(ndvi_diff_totale, col = magma(100), range = c(-0.6, 0.6), main = "ΔNDVI (2026 - 2016)")
````
<img width="1280" height="709" alt="delta_ndvi_new" src="https://github.com/user-attachments/assets/c6a07380-ecd5-40df-9a7d-735809a49927" />

>  Confronto dei ΔNDVI





