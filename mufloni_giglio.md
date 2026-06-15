#### Telerilevamento geo-ecologico in R, 2026
###### Luca Barilaro, Scienze e Gestione della Natura


# La gestione della fauna come strumento di biologia della conservazione: eradicazione del muflone ($`Ovis`$ $`aries`$) e analisi preliminare del recupero della vegetazione nell'Isola del Giglio

<img width="2560" height="1702" alt="mufloni_A _Marchese-e15-scaled" src="https://github.com/user-attachments/assets/2115a710-b03b-4413-907a-716cdf5ad9a4" />

> Mufloni nel Parco Nazionale dell'Arcipelago Toscano, Isola del Giglio. [Foto di A. Marchese](https://www.islepark.it/2022/09/02/studiosi-di-chiara-fama-confermano-l-opportunita-di-eradicare-il-muflone-all-isola-del-giglio/)

---

## 1. Introduzione e area di studio 🗺️

Il progetto ***LIFE LETSGO GIGLIO "Less alien species in the Tuscan Archipelago: new actions to protect Giglio Island habitats"***  (LIFE18 NAT/IT/000828) ha previsto delle attività di prelievo finalizzate all'eradicazione del **muflone** (*Ovis aries*) presso l'Isola del Giglio. Il muflone, **specie aliena invasiva** introdotta nell'isola toscana per scopi venatori negli anni '60-'70 del secolo scorso, ha determinato un **sovrasfruttamento degli ecosistemi** di macchia mediterranea, portando a un **degrado della vegetazione**. Complessivamente, in 3 anni di progetto (Febbraio 2021- Marzo 2024) sono stati rimossi 130 mufloni.

I dati rilevati sui mufloni dell’Isola del Giglio hanno riscontrato una popolazione al **limite della capacità portante**, probabilmente a causa della **scarsità di risorse trofiche** disponibili. Inoltre, è necessario considerare l’**elevata densità** di bovidi riscontrata in alcune zone dell’isola, vista la tendenza alla filopatria e al comportamento spaziale della specie. In particolare, quasi tutti gli individui prelevati sono stati registrati nella zona del **promontorio del Franco**, corrispondente all'area dove erano stati introdotti per la prima volta (*La Russa L., com. pers*). Pertanto, l'analisi spaziale si concentrerà sulla suddetta area. 

<img width="1600" height="1131" alt="Isola_Giglio_Mufloni" src="https://github.com/user-attachments/assets/ced4c933-6cfd-4f4a-aed6-b19c98b6e720" />

> Isola del Giglio. Nel riquadro arancione è indicata l'area di intervento. Mappa del Dott. Lorenzo La Russa


## 2. Obiettivo del progetto in R 🎯

Il presente lavoro ha l'obiettivo di dimostrare l'impatto degradativo che le specie aliene invasive – nello specifico ungulati introdotti nel contesto insulare – esercitano sulle comunità vegetali autoctone, utilizzando il telerilevamento satellitare come strumento di verifica oggettiva. In particolare, il progetto mira a:

- Evidenziare l'efficacia e la necessità di interventi di *wildlife management* come strumento fondamentale per la biologia della conservazione, la quale insegna che le specie aliene invasive rappresentano una delle maggiori minacce per la diversità biologica;
- Dimostrare come le attività di pascolo e calpestio effettuate dal muflone abbiano alterato la biomassa della macchia mediterranea in determinate aree dell'Isola, compromettendo il naturale rinnovamento forestale.

L'analisi si concentra sull'efficacia dell'intervento di eradicazione del muflone valutando lo stato della vegetazione attraverso immagini satellitari Sentinel-2 prelevate in tre momenti temporali:

- **pre-controllo**, 04/06-2018;
- **eradicazione**, 04/06-2022;
- **post-eradicazione**, 04/06-2026.

< [!NOTE]
< La scelta della date è basata su un intervallo di tempo standardizzato di 4 anni tra un periodo e l'altro. Inoltre, nel 2018 erano trascorsi 8 anni dall'inizio delle attività di controllo della specie sull'Isola, avviate a partire dal 2009 (**Citare fonte report**).

Gli indici vegetazionali impiegati per le analisi sono:

- **NDVI** (*Normalized Difference Vegetation Index*), per misurare lo stato di salute della vegetazione;
- **DVI** (*Difference Vegetation Index*), per misurare la quantità assoluta di vegetazione;
- **Rao's Q**, per misurare la complessità e la biodiversità dell'intero ecosistema.



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
library(reshape2)   # Riorganizzazioni dei dati tabellari
**AGGIUNGERE**
````

In seguito, imposto la working directory:

````r
setwd("C:/Users/lucab/Desktop/progetto_giglio/data")
````

Ora è possibile importare i raster Sentinel-2 acquisiti:

````r
franco_2018 = rast("franco_2018.tif")  # importato e nominato il primo .tif
plot(franco_2018)                      # visualizzato il primo .tif
dev.off()                              # chiudo il pannello di visualizzazione delle immagini
````

<p align="center">
<img width="664" height="664" alt="franco_2018" src="https://github.com/user-attachments/assets/0545e671-79e8-4542-a960-5b30ee468bc3" />

> Immagine satellitare nelle 4 bande riguardante il periodo antecedente all'intervento di eradicazione

> [!NOTE]
> B2 = Blue; B3 = Green; B4 = Red; B8 = NIR 

````r
franco_2022 = rast("franco_2022.tif")  # importato e nominato il secondo .tif
plot(franco_2022)                      # visualizzato il secondo .tif
dev.off()                              # chiudo il pannello di visualizzazione delle immagini
````

<img width="1280" height="709" alt="franco_2022" src="https://github.com/user-attachments/assets/7951af80-9d16-4ae5-92a8-b20ff4176aeb" />

> Immagine satellitare nelle 4 bande a un anno dall'inizio dell'intervento di eradicazione

````r
franco_2026 = rast("franco_2026.tif")  # importato e nominato il terzo .tif
plot(franco_2026)                      # visualizzato il terzo .tif
dev.off()                              # chiudo il pannello di visualizzazione delle immagini
````

<img width="1280" height="709" alt="franco_2026" src="https://github.com/user-attachments/assets/d187b5f4-e505-4043-8c06-10c684ce3be9" />

> Immagine satellitare nelle 4 bande a due anni dalla fine dell'intervento di eradicazione


### 3.3. Visualizzazione immagini in RGB 

````r
im.multiframe(1, 3)  # preparo pannello grafico con 1 riga e 3 colonne usando la funzione di imageRy
im.plotRGB(franco_2018, r = 3, g = 2, b = 1, title = "Pre-eradicazione")  # visualizzo immagini in RGB con funzione di imageRy
im.plotRGB(franco_2022, r = 3, g = 2, b = 1, title = "Eradicazione") 
im.plotRGB(franco_2026, r = 3, g = 2, b = 1, title = "Post-eradicazione")
dev.off() # chiudo il pannello di visualizzazione delle immagini
````
<img width="1280" height="709" alt="franco_rgb" src="https://github.com/user-attachments/assets/2574679e-e8f4-42bb-8966-dcba38afe362" />

> Confronto tra le immagini in RGB delle diverse fasi analizzate


### 3.4. Visualizzazione NIR in Blue

````r
im.multiframe(1, 3) # preparo pannello grafico con 1 riga e 3 colonne usando la funzione di imageRy
# r = 3 (Red), g = 2 (Green), b = 4 (NIR)  # imposto NIR nel canale blu
plotRGB(franco_2018, r = 3, g = 2, b = 4, stretch = "lin", main = "Pre-eradicazione (2018)")  # utilizzo funzione pacchetto terra
plotRGB(franco_2022, r = 3, g = 2, b = 4, stretch = "lin", main = "Eradicazione (2022)")      
plotRGB(franco_2026, r = 3, g = 2, b = 4, stretch = "lin", main = "Post-eradicazione (2026)")
dev.off()  # chiudo il pannello di visualizzazione delle immagini
````
<img width="1280" height="709" alt="franco_nir_blue" src="https://github.com/user-attachments/assets/f3a441c7-2bea-4529-8da1-72f547749d2e" />

> Confronto eseguito con il NIR nel canale del blu nei diversi anni presi in analisi

> [!NOTE]
> Sostituendo il **NIR** al posto della banda del blu (r=3, g=2, b=4), si evidenziano in **blu** le zone di **vegetazione** (alta riflettanza del NIR) e in giallo tutto ciò che non è vegetazione, come suolo nudo e roccia esposta.


### 3.5. Visualizzazione 4 bande separate per le 3 immagini (RGB + NIR)

````r
im.multiframe(3, 4) # visualizzo pannello grafico con 3 righe (anni) e 4 colonne (bande)
plot(franco_2018[[1]], col = viridis(100), range = c(0, 0.5), main = "2018 - Blue")
plot(franco_2018[[2]], col = viridis(100), range = c(0, 0.5), main = "2018 - Green")
plot(franco_2018[[3]], col = viridis(100), range = c(0, 0.5), main = "2018 - Red")
plot(franco_2018[[4]], col = viridis(100), range = c(0, 0.6), main = "2018 - NIR")

plot(franco_2022[[1]], col = viridis(100), range = c(0, 0.5), main = "2022 - Blue")
plot(franco_2022[[2]], col = viridis(100), range = c(0, 0.5), main = "2022 - Green")
plot(franco_2022[[3]], col = viridis(100), range = c(0, 0.5), main = "2022 - Red")
plot(franco_2022[[4]], col = viridis(100), range = c(0, 0.6), main = "2022 - NIR")

plot(franco_2026[[1]], col = viridis(100), range = c(0, 0.5), main = "2026 - Blue")
plot(franco_2026[[2]], col = viridis(100), range = c(0, 0.5), main = "2026 - Green")
plot(franco_2026[[3]], col = viridis(100), range = c(0, 0.5), main = "2026 - Red")
plot(franco_2026[[4]], col = viridis(100), range = c(0, 0.6), main = "2026 - NIR")
dev.off() # chiudo il pannello di visualizzazione delle immagini
````
<img width="1280" height="709" alt="franco_rgb_nir" src="https://github.com/user-attachments/assets/c668b726-eb88-42d8-90ac-251fb9256ab6" />

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
dvi_2018 <- im.dvi(franco_2018, 4, 3)   # utilizzo funzione im.dvi() del pacchetto imageRy 
dvi_2022 <- im.dvi(franco_2022, 4, 3)   # 4 indica la banda NIR, 3 indica la banda Red
dvi_2026 <- im.dvi(franco_2026, 4, 3)  

im.multiframe(1, 3)  # preparo pannello grafico con 1 riga e 3 colonne usando la funzione di imageRy
plot(dvi_2018, col = viridis(100), main = "DVI 2018")   # visualizzo DVI prima dell'eradicazione
plot(dvi_2022, col = viridis(100), main = "DVI 2022")   # visualizzo DVI durante il primo anno di eradicazione
plot(dvi_2026, col = viridis(100), main = "DVI 2026")   # visualizzo DVI dopo l'eradicazione
dev.off()
````

<img width="1280" height="709" alt="franco_dvi_new" src="https://github.com/user-attachments/assets/aa95b156-b9a9-4577-9e54-a75904a119cf" />

> DVI dei tre periodi presi in analisi


Calcolo la differenza tra il DVI del 2018 e quello del 2022 e la differenza tra il DVI del 2018 e quello del 2026.

````r
dvi_diff_fase1  <- dvi_2022 - dvi_2018
dvi_diff_totale <- dvi_2026 - dvi_2018

im.multiframe(1, 2)
plot(dvi_diff_fase1, col = magma(100), range = c(-0.30, 0.30), main = "ΔDVI (2022 - 2018)")
plot(dvi_diff_totale, col = magma(100), range = c(-0.30, 0.30), main = "ΔDVI (2026 - 2018)")
dev.off()
````
<img width="1280" height="709" alt="delta_dvi_franco_new" src="https://github.com/user-attachments/assets/94840aba-bd87-4c2a-a345-652fbef2f0be" />

> Confronto dei ΔDVI

> [!NOTE]
> Il confronto mette in evidente risalto una differenza nel Promontorio del Franco, area N-O dell'Isola a elevata densità della specie (*La Russa L., com. pers.*). Si passa da valori negativi, indicanti una diminuzione del valore di DVI e, quindi, una perdita di vegetazione, a valori positivi (rosso-arancio), indicanti una progressiva ricolonizzazione della vegetazione su suolo precedentemente degradato.


### 4.2. Analisi NDVI (Normalized Difference Vegetation Index)

L'NDVI è uno degli indici di vegetazione più diffusi in telerilevamento grazie alla sua capacità di normalizzare le differenze tra immagini acquisite in tempi o condizioni diverse, riducendo gli effetti di disturbo causati dalle ombre e dalla topografia del terreno. Si calcola come il rapporto tra la differenza e la somma delle riflettanze nel vicino infrarosso (NIR) e nel rosso (Red):

$$NDVI = \frac{NIR - Red}{NIR + Red}$$

I valori ottenuti variano strettamente tra $-1$ e $+1$: valori vicini a $+1$ indicano vegetazione densa, strutturata e sana, mentre valori prossimi a $0$ o negativi indicano la totale assenza di fotosintesi, identificando suolo nudo, rocce o acqua. L'NDVI è particolarmente utile per monitorare variazioni nella copertura vegetale nel tempo e valutare stress idrici, dinamiche ecologiche o impatti antropici e faunistici, come nel caso del sovrapascolamento.

````r
ndvi_2018 <- im.ndvi(franco_2018, 4, 3)  
ndvi_2022 <- im.ndvi(franco_2022, 4, 3)  
ndvi_2026 <- im.ndvi(franco_2026, 4, 3)  

im.multiframe(1, 3)
plot(ndvi_2018, col = viridis(100), main = "NDVI 2018")  
plot(ndvi_2022, col = viridis(100), main = "NDVI 2022")
plot(ndvi_2026, col = viridis(100), main = "NDVI 2026")
dev.off()
````

<img width="1280" height="709" alt="franco_ndvi" src="https://github.com/user-attachments/assets/084060e1-96bb-475b-b95f-221b50db4149" />

> NDVI dei tre periodi presi in analisi

Procedo con il calcolo della differenza tra l'NDVI del 2018 e quello del 2022 e il calcolo della differenza tra l'NDVI del 2018 e quello del 2026.

````r
ndvi_diff_fase1  <- ndvi_2022 - ndvi_2018
ndvi_diff_totale <- ndvi_2026 - ndvi_2018

im.multiframe(1, 2) # configuro il pannello grafico con 1 riga e 2 colonne
plot(ndvi_diff_fase1, col = magma(100), range = c(-0.6, 0.6), main = "ΔNDVI (2022 - 2018)")
plot(ndvi_diff_totale, col = magma(100), range = c(-0.6, 0.6), main = "ΔNDVI (2026 - 2018)")
dev.off()
````

<img width="1280" height="709" alt="delta_ndvi_franco" src="https://github.com/user-attachments/assets/5a9934e6-5c45-42b3-ab8c-22b4659eea1b" />

>  Confronto dei ΔNDVI

> [!NOTE]
> Di nuovo, il confronto mette in evidenza una differenza ben marcata nell'area del Promontorio del Franco (N-O). In particolare, si notano differenze diffuse e continue, passando da valori prossimi allo 0 a diffusi valori positivi (arancione-giallo), i quali testimoniano un effettivo incremento strutturale della biomassa fogliare su un suolo precedentemente degradato.


### 4.2.1. Visualizzazione dei dati 

#### Ridgeline Plot

Il Ridgeline Plot dei singoli NDVI consente di confrontare visivamente la distribuzione dell’indice NDVI tra il 2018, il 2022 e il 2026, evidenziando eventuali variazioni nel tempo dei valori assoluti di vegetazione.

````r
franco_ridg <- c(ndvi_2018, ndvi_2022, ndvi_2026)  
# nomino punti sull'asse verticale
names(franco_ridg) <- c("NDVI 2018 (Pre-eradicazione)", "NDVI 2022 (Eradicazione)", "NDVI 2026 (Post-eradicazione)")
im.ridgeline(eradicazione_ridg, scale = 1.2, palette = "viridis")  # creo grafico ridgeline con funzione di imageRy
dev.off()
````
<img width="1280" height="709" alt="ridgeline_franco" src="https://github.com/user-attachments/assets/b3ab676c-b185-44ba-a026-aaf5b51b793c" />

> Ridgeline Plot per confrontare la distribuzione dell'NDVI nei tre anni presi in analisi

> [!IMPORTANT]
> Il Ridgeline Plot dei singoli NDVI offre una conferma statistica al trend osservato da immagini satellitari. Anzitutto, la distribuzione riflette la netta separazione tra le aree fotosinteticamente non attive (background marino, scogliere, etc.), con picco stabile poco inferiore allo 0, e la biomassa insulare (picco > = 0.6). Tra il 2018 (pre-eradicazione) e il 2022 (primo anno di eradicazione) le due curve sono quasi sovrapposte, indicando che nelle prime fasi di intervento la vegetazione non mostrava ancora una risposta visibile. Nella curva NDVI del 2026 il picco della vegetazione si sposta nettamente verso destra (> 0.75), divenendo sensibilmente più alto. Questo shift della densità di frequenza verso valori più alti dell'indice documenta matematicamente l'incremento globale di vigore vegetativo nell'area analizzata.

Inoltre, sempre tramite Ridgeline Plot, procedo con un confronto tra ΔNDVI 2022-2018 e  ΔNDVI 2026-2018 al fine di osservare eventuali cambiamenti rispetto alla situazione iniziale durante l'eradicazione (ΔNDVI 2022-2018) e dopo (ΔNDVI 2026-2018). Pertanto, in tal modo, è possibile evidenziare l'effetto dell'intervento di eradicazione. 

````r
delta_ridg <- c(ndvi_diff_fase1, ndvi_diff_totale) 
names(delta_ridg) <- c( "ΔNDVI 2022-2018","ΔNDVI 2026-2018") # nomino punti sull'asse verticale
im.ridgeline(delta_ridg,scale = 1.2,palette = "magma")  # creo grafico ridgeline con funzione di imageRy
dev.off()
````
<img width="1280" height="709" alt="delta_ridgeline_franco" src="https://github.com/user-attachments/assets/6b84d2a7-5eb2-43d4-b243-802a565a74b8" />

> Ridgeline Plot per confrontare la distribuzione dei ΔNDVI

> [!IMPORTANT]
> La distribuzione del ΔNDVI 2022–2018 risulta centrata attorno allo zero, indicando un cambiamento vegetazionale complessivamente limitato rispetto alla condizione pre-intervento. Al contrario, la distribuzione del ΔNDVI 2026–2018 mostra uno spostamento verso valori positivi, suggerendo un incremento generalizzato dell'attività vegetativa rispetto alle condizioni iniziali antecedenti all'intervento. Questo andamento suggerisce un possibile processo di recupero della vegetazione nel periodo successivo all'intervento di eradicazione, con un aumento dei valori NDVI rispetto alla situazione di riferimento del 2018.


#### Classificazione per classi di vegetazione

Scelgo il range di valori adatto alla classificazione facendo riferimento agli istogrammi della distribuzione dell'NDVI.

````r
# configuro il pannello grafico con 1 riga e 3 colonne
im.multiframe(1, 3)

# istogramma NDVI 2018 
hist(ndvi_2018, 
     xlim = c(-0.6, 0.9), 
     ylim = c(0, 12000), 
     main = "Distribuzione NDVI 2018", 
     col = "lightgray", 
     xlab = "Valori NDVI")

# istogramma NDVI 2022
hist(ndvi_2022, 
     xlim = c(-0.6, 0.9), 
     ylim = c(0, 12000), 
     main = "Distribuzione NDVI 2022", 
     col = "lightgray", 
     xlab = "Valori NDVI")

# istogramma NDVI 2026
hist(ndvi_2026, 
     xlim = c(-0.6, 0.9), 
     ylim = c(0, 12000), 
     main = "Distribuzione NDVI 2026", 
     col = "lightgray", 
     xlab = "Valori NDVI")
````
<details>
<summary>Istogrammi (cliccare qui)</summary> 
  
<img width="1280" height="709" alt="franco_ndvi_hist" src="https://github.com/user-attachments/assets/853ccb08-04b5-42a2-9a82-a6d089a70f3b" />

</details>

Procedo con la classificazione per classi di vegetazione basata sugli istogrammi precedentemente ottenuti.

````r
class_matrix <- matrix(c(
  -Inf,  0.25, 1,   # se NDVI < 0.2: classe 1 (mare / roccia / suolo spoglio)
  0.25,  0.65, 2,   # se 0.2 <= NDVI < 0.4: classe 2 (vegetazione rada / gariga / zone degradate)
  0.65,  Inf, 3     # se NDVI >= 0.4: classe 3 (vegetazione fitta / macchia in recupero)
), ncol = 3, byrow = TRUE)

class_matrix  # stampa la matrice per controllo grafico

# classificazione dei singoli anni con la funzione classify del pacchetto terra
ndvi_2018_cl <- classify(ndvi_2018, class_matrix)  
ndvi_2022_cl <- classify(ndvi_2022, class_matrix)  
ndvi_2026_cl <- classify(ndvi_2026, class_matrix)  


im.multiframe(1, 3)  # creo un multiframe con 1 riga e 3 colonne per vedere l'evoluzione
# visualizzazione delle mappe classificate
plot(ndvi_2018_cl, col = c("darkblue", "gold", "darkgreen"), main = "NDVI class. 2018", colNA = "black")  
plot(ndvi_2022_cl, col = c("darkblue", "gold", "darkgreen"), main = "NDVI class. 2022", colNA = "black")   
plot(ndvi_2026_cl, col = c("darkblue", "gold", "darkgreen"), main = "NDVI class. 2026", colNA = "black")
````

<img width="1280" height="709" alt="franco_class_veg" src="https://github.com/user-attachments/assets/0aa8ea06-8724-40f2-917a-574c6d1d0501" />

> Classificazione per classi di vegetazione negli NDVI dei tre anni presi in analisi

> [!NOTE]
> 
>  AGGIUNGERE COMMENTO
  
