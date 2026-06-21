#### Telerilevamento geo-ecologico in R, 2026
###### Luca Barilaro, Scienze e Gestione della Natura (Università di Bologna)


# La gestione della fauna come strumento di biologia della conservazione: eradicazione del muflone ($`Ovis`$ $`aries`$) e analisi preliminare del recupero della vegetazione nell'Isola del Giglio

<img width="2560" height="1702" alt="mufloni_A _Marchese-e15-scaled" src="https://github.com/user-attachments/assets/2115a710-b03b-4413-907a-716cdf5ad9a4" />

> Mufloni nel Parco Nazionale dell'Arcipelago Toscano, Isola del Giglio. [Foto di A. Marchese](https://www.islepark.it/2022/09/02/studiosi-di-chiara-fama-confermano-l-opportunita-di-eradicare-il-muflone-all-isola-del-giglio/)

---

## 1. Introduzione e area di studio 🗺️

Il progetto ***Life LETSGO Giglio "Less alien species in the Tuscan Archipelago: new actions to protect Giglio Island habitats"***  (LIFE18 NAT/IT/000828) ha previsto delle attività di prelievo finalizzate all'eradicazione del **muflone** (*Ovis aries*) presso l'Isola del Giglio. Il muflone, **specie alloctona** introdotta nell'isola toscana per scopi venatori negli anni '60-'70 del secolo scorso, ha determinato un **sovrasfruttamento degli ecosistemi** di macchia mediterranea, portando a un **degrado della vegetazione**. Complessivamente, in 4 anni di progetto (fase operativa dal 2021 al 2023 e monitoraggio post-intervento nel 2024), sono stati rimossi 120 mufloni (ulteriori 10 individui sono stati abbattuti nel 2020 in attività di controllo della specie). 

I dati rilevati sui mufloni dell’Isola del Giglio hanno riscontrato una popolazione al **limite della capacità portante**, probabilmente a causa della **scarsità di risorse trofiche** disponibili. Inoltre, è necessario considerare l’**elevata densità** di bovidi riscontrata in alcune zone dell’Isola, vista la tendenza alla filopatria e al comportamento spaziale della specie (*Nicoloso S. et al., 2024*). In particolare, molti degli individui catturati e traslocati o abbattuti sono stati registrati nella zona del **Promontorio del Franco**, corrispondente all'area dove sono stati introdotti per la prima volta (*La Russa L., com. pers*). Pertanto, a scopo didattico, l'analisi spaziale si concentrerà esclusivamente sulla suddetta area. 

<img width="1600" height="1131" alt="Isola_Giglio_Mufloni" src="https://github.com/user-attachments/assets/ced4c933-6cfd-4f4a-aed6-b19c98b6e720" />

> Isola del Giglio. Nel riquadro arancione è indicata l'area di intervento del progetto di eradicazione. Mappa gentilmente concessa dal Dott. Lorenzo La Russa


## 2. Obiettivo del progetto in R 🎯

Il presente lavoro ha l'obiettivo di valutare l'impatto degradativo che le specie aliene invasive – nello specifico ungulati introdotti nel contesto insulare – esercitano sulle comunità vegetali autoctone, utilizzando il **telerilevamento** come strumento di verifica oggettiva. In particolare, il progetto mira a:

- promuovere l'importanza e la necessità di interventi di *wildlife management* come strumento fondamentale per la biologia della conservazione, la quale insegna che le specie aliene invasive rappresentano una delle maggiori minacce per la diversità biologica;
- osservare all'interno dell'area di studio quale fosse lo stato della vegetazione prima dell'intervento di eradicazione e valutare se il piano di rimozione della specie target possa aver contribuito in poco tempo a un aumento della quantità di biomassa della macchia mediterranea nel sito di indagine.

Pertanto, l'analisi valuta lo stato della vegetazione attraverso immagini satellitari Sentinel-2 prelevate in tre fasi temporali:

- **pre-controllo**, aprile/giugno-2020;
- **eradicazione**, aprile/giugno-2023;
- **post-eradicazione**, aprile/giugno-2026.

> [!NOTE]
> La scelta delle date è basata su un intervallo di tempo di 3 anni tra un periodo e l'altro. Nel dettaglio, il **2020** <sup>[*](#nota)</sup> rappresenta l'anno prima dell'inizio del piano di eradicazione, mentre il **2023** è l'anno in cui termina la maggior parte delle attività di abbattimento e traslocazione di mufloni dall'Isola (da maggio 2021 a marzo 2023 sono stati abbattuti 38 mufloni e traslocati 52; *Nicoloso S. et al., 2024*). Infine, il **2026**, anno corrente, rappresenta il riferimento per valutare, a due anni dalla conclusione ufficiale delle operazioni di eradicazione, l'eventuale ripresa della vegetazione nel Promontorio del Franco. 

<a name="nota"></a>\* *Dal 2009 al 2020 sono stati condotti interventi di controllo della specie sull'Isola, effettuati dal PNAT e dalla Polizia Provinciale di Grosseto, determinando un numero complessivo di 97 individui abbattuti (*Nicoloso S. et al., 2021*).*

Gli indici vegetazionali impiegati per le analisi sono:

- **DVI** (*Difference Vegetation Index*), per misurare la quantità assoluta di vegetazione;
- **NDVI** (*Normalized Difference Vegetation Index*), per misurare lo stato di vigoria della vegetazione;


## 3. Metodologia 🛰️

### 3.1. Acquisizione immagini

Le immagini satellitari provengono da [**Google Earth Engine**](https://earthengine.google.com/), attraverso cui è stata selezionata l'area di intervento per le fasi e le relative date precedentemente indicate. Al fine di evitare distorsioni nelle analisi spaziali, è stato rimosso il background marino dalla visualizzazione attraverso un apposito JavaScript consultabile al seguente [link GitHub](https://github.com/lucabarilaro/Telerilevamento_2026_/blob/main/javascript_mufloni_giglio.js)


### 3.2. Importazione e visualizzazione immagini
Una volta ottenute le immagini satellitari, vengono caricate in **R**. 
Per prima cosa, chiamo i pacchetti necessari:

````r
library(terra)      # per analisi spaziali con raster e immagini satellitari
library(imageRy)    # per visualizzare, classificare e manipolare immagini satellitari
library(viridis)    # per visualizzare dati con palette di colori viridis
library(ggplot2)    # per visualizzare dati con la creazione di grafici
library(ggridges)   # per visualizzare distribuzioni con ridgeline plots
library(patchwork)  # per combinare e organizzare grafici molteplici
````

In seguito, imposto la **working directory**:

````r
setwd("C:/Users/lucab/Desktop/progetto_giglio/data")  # funzione per impostare working directory
getwd()  # controllo se è stata impostata la giusta working directory
list.files()  # osservo l'elenco dei files all'interno di essa
````

Ora è possibile **importare i raster** Sentinel-2 acquisiti:

````r
franco_2020 <- rast("franco_2020.tif")  # importo e nomino il primo .tif
plot(franco_2020)                       # visualizzo il primo .tif
dev.off()                               # chiudo il pannello di visualizzazione delle immagini
````

<img width="1280" height="709" alt="franco_2020_" src="https://github.com/user-attachments/assets/895d5fa4-82ac-4854-8c0f-d83e81f775d0" />

> Immagine satellitare nelle 4 bande riguardante l'anno precedente all'intervento di eradicazione

> [!NOTE]
> **B2** = Blue; **B3** = Green; **B4** = Red; **B8** = NIR 

````r
franco_2023 <- rast("franco_2023.tif")  # importo e nomino il secondo .tif
plot(franco_2023)                       # visualizzo il secondo .tif
dev.off()                               # chiudo il pannello di visualizzazione delle immagini
````

<img width="1280" height="709" alt="franco_2023_" src="https://github.com/user-attachments/assets/1c0383a4-d70f-4bcb-a695-f8765012c531" />

> Immagine satellitare nelle 4 bande a due anni dall'inizio dell'intervento di eradicazione

````r
franco_2026 <- rast("franco_2026.tif")  # importo e nomino il terzo .tif
plot(franco_2026)                       # visualizzo il terzo .tif
dev.off()                               # chiudo il pannello di visualizzazione delle immagini
````

<img width="1280" height="709" alt="franco_2026_" src="https://github.com/user-attachments/assets/2eaa3816-94fe-4439-aefc-f5416d7ebe29" />

> Immagine satellitare nelle 4 bande a due anni dalla fine del progetto di eradicazione


### 3.3. Visualizzazione immagini in RGB 

Applico B2-B3-B4 nei rispettivi canali blu, verde e rosso, creando una composizione **RGB**, simile alla vista umana. 

````r
im.multiframe(1, 3)  # preparo pannello grafico con 1 riga e 3 colonne usando la funzione di imageRy
im.plotRGB(franco_2020, r = 3, g = 2, b = 1, title = "Pre-eradicazione")  # visualizzo immagini in RGB con funzione di imageRy
im.plotRGB(franco_2023, r = 3, g = 2, b = 1, title = "Eradicazione") 
im.plotRGB(franco_2026, r = 3, g = 2, b = 1, title = "Post-eradicazione")
dev.off() # chiudo il pannello di visualizzazione delle immagini
````
<img width="1280" height="709" alt="franco_rgb" src="https://github.com/user-attachments/assets/796a24c0-f358-4548-94a4-4773be155ee2" />

> Confronto tra le immagini in RGB delle diverse fasi analizzate


### 3.4. Visualizzazione NIR in Red

Applico una composizione **RGB in falso colore** (NIR-R-G), assegnando la banda del vicino infrarosso (B8) al canale rosso, la banda rossa (B4) al canale verde e la banda verde (B3) al canale blu.

````r
im.multiframe(1, 3)  # preparo pannello grafico con 1 riga e 3 colonne usando la funzione di imageRy
# r = 4 (B8, NIR), g = 3 (B4, Red), b = 2 (B3, Green)  # imposto NIR nel canale red
im.plotRGB(franco_2020, r = 4, g = 3, b = 2, title = "Pre-eradicazione (2020)")  # visualizzo con funzione imageRy
im.plotRGB(franco_2023, r = 4, g = 3, b = 2, title = "Eradicazione (2023)")      
im.plotRGB(franco_2026, r = 4, g = 3, b = 2, title = "Post-eradicazione (2026)")
dev.off()  # chiudo il pannello di visualizzazione delle immagini
````

<img width="1280" height="709" alt="franco_nir_red" src="https://github.com/user-attachments/assets/6a8dbe74-13da-45ac-b177-9f64c428290d" />

> Confronto eseguito con il NIR nel canale del rosso nei diversi anni presi in analisi

> [!NOTE]
> Sostituendo il **NIR** al posto della banda del rosso si evidenziano in **rosso** le zone di **vegetazione** (alta riflettanza del NIR). In particolare, il rosso brillante, più intenso, indicherebbe una vegetazione più vigorosa, mentre il rosso più scuro una vegetazione con riflettanza più bassa nel NIR (potenzialmente meno vigorosa). Colori più tendenti al grigio indicano suolo nudo o aree urbanizzate, mentre il colore azzuro indica acqua o superfici con bassissima risposta nel NIR.

### 3.5. Visualizzazione 4 bande separate per le 3 immagini (RGB + NIR)

````r
im.multiframe(3, 4)  # preparo pannello grafico con 3 righe e 4 colonne usando la funzione di imageRy
plot(franco_2020[[1]], col = viridis(100), main = "2020 - Blue")  # visualizzo immagini, assegno palette colore e nomino i file raster
plot(franco_2020[[2]], col = viridis(100), main = "2020 - Green") # in alternativa, si può usare funzione im.plot() di imageRy
plot(franco_2020[[3]], col = viridis(100), main = "2020 - Red")   # vegetazione assorbe molto nel Red
plot(franco_2020[[4]], col = viridis(100), main = "2020 - NIR")   # vegetazione riflette molto nel NIR

plot(franco_2023[[1]], col = viridis(100), main = "2023 - Blue")  
plot(franco_2023[[2]], col = viridis(100), main = "2023 - Green")
plot(franco_2023[[3]], col = viridis(100), main = "2023 - Red") 
plot(franco_2023[[4]], col = viridis(100), main = "2023 - NIR")

plot(franco_2026[[1]], col = viridis(100), main = "2026 - Blue")
plot(franco_2026[[2]], col = viridis(100), main = "2026 - Green")
plot(franco_2026[[3]], col = viridis(100), main = "2026 - Red")
plot(franco_2026[[4]], col = viridis(100), main = "2026 - NIR")
dev.off()  # chiudo il pannello di visualizzazione delle immagini
````

<img width="1280" height="709" alt="franco_rgb_nir" src="https://github.com/user-attachments/assets/bc73b2d3-3efd-4001-a8b5-de5834752fe5" />

> Confronto tra le 4 bande (colonne) nei diversi anni (righe) presi in analisi

> [!TIP]
> Le bande RGB (B2, B3, B4) corrispondono allo spettro del visibile, nel quale la vegetazione assorbe principalmente la radiazione rossa grazie alla clorofilla. La banda del vicino infrarosso (B8), non percepibile dall’occhio umano, è invece fortemente riflessa dalla struttura interna delle foglie, in particolare dal mesofillo, ed è quindi strettamente correlata alla vigoria e alla densità della copertura vegetale.

## 4. Calcolo degli indici vegetazionali 🌳

Gli indici vegetazionali impiegati per le analisi sono:

- DVI (Difference Vegetation Index), per misurare la quantità assoluta di vegetazione;
- NDVI (Normalized Difference Vegetation Index), per misurare lo stato di vigoria della vegetazione;


### 4.1. Analisi DVI (Difference Vegetation Index)

Il **DVI** è uno dei più semplici indici spettrali utilizzati per valutare la presenza e la vitalità della vegetazione. Si calcola sottraendo la riflettanza nel rosso (Red, B4) da quella nel vicino infrarosso (NIR, B8):

$$
DVI = NIR - RED
$$

Le piante sane riflettono molto nel NIR e poco nel rosso; quindi, valori alti di DVI indicano una quantità maggiore di vegetazione, mentre valori vicini allo zero o negativi indicano generalmente suolo nudo o roccia. Sebbene fornisca un'indicazione diretta della biomassa verde, il DVI è un indice non normalizzato. Questo lo rende utile per analisi comparative rapide quando le condizioni di acquisizione sono simili, ma risente degli effetti topografici e delle ombre, motivo per cui spesso gli si preferisce l'NDVI.

````r
dvi_2020 <- im.dvi(franco_2020, 4, 3)  # utilizzo funzione im.dvi() del pacchetto imageRy 
dvi_2023 <- im.dvi(franco_2023, 4, 3)  # 4 è la banda NIR, 3 è la banda Red
dvi_2026 <- im.dvi(franco_2026, 4, 3)  

im.multiframe(1, 3)  # configuro pannello grafico con 1 riga e 3 colonne usando la funzione di imageRy
plot(dvi_2020, col = viridis(100), main = "DVI 2020")   # visualizzo DVI prima dell'eradicazione, assegno palette col., denomino
plot(dvi_2023, col = viridis(100), main = "DVI 2023")   # visualizzo DVI durante eradicazione, assegno palette col., denomino
plot(dvi_2026, col = viridis(100), main = "DVI 2026")   # visualizzo DVI dopo eradicazione, assegno palette col., denomino
dev.off()  # chiudo il pannello di visualizzazione delle immagini
````

<img width="1280" height="709" alt="franco_dvi" src="https://github.com/user-attachments/assets/64ca5a87-0a92-4c62-96e3-e21d77a8d910" />

> DVI dei tre periodi presi in analisi


Calcolo la differenza tra il DVI del 2023 e quello del 2020, tra il DVI del 2026 e quello del 2023 e, infine, tra il DVI del 2026 e quello del 2020. 

````r
dvi_diff_fase1  <- dvi_2023 - dvi_2020  # assegno nome e calcolo differenze DVI
dvi_diff_fase2  <- dvi_2026 - dvi_2023
dvi_diff_totale <- dvi_2026 - dvi_2020

im.multiframe(1, 3)  # configuro pannello grafico con 1 riga e 3 colonne usando la funzione di imageRy
plot(dvi_diff_fase1, col = magma(100), main = "ΔDVI (2023 - 2020)")  # visualizzo immagini con risultati differenza DVI
plot(dvi_diff_fase2, col = magma(100), main = "ΔDVI (2026 - 2023)")
plot(dvi_diff_totale, col = magma(100), main = "ΔDVI (2026 - 2020)")
dev.off()  # chiudo il pannello di visualizzazione delle immagini
````

<img width="1280" height="709" alt="franco_delta_dvi" src="https://github.com/user-attachments/assets/c2197d7d-0eea-454a-8fc4-5531f124aafc" />

> Confronto dei **ΔDVI**

> [!NOTE]
> Il confronto sembrerebbe mostrare un passaggio da valori più bassi di DVI, indicanti, in termini assoluti, una più bassa quantità di vegetazione, a valori più alti, i quali suggerirebbero un progressivo aumento della vegetazione.


### 4.2. Analisi NDVI (Normalized Difference Vegetation Index)

L'**NDVI** è uno degli indici di vegetazione più diffusi in telerilevamento grazie alla sua capacità di normalizzare le differenze tra immagini acquisite in tempi o condizioni diverse, riducendo gli effetti di disturbo causati dalle ombre e dalla topografia del terreno. Si calcola come il rapporto tra la differenza e la somma delle riflettanze nel vicino infrarosso (NIR) e nel rosso (Red):

$$NDVI = \frac{NIR - Red}{NIR + Red}$$

I valori ottenuti variano strettamente tra $-1$ e $+1$: valori vicini a $+1$ indicano vegetazione densa, strutturata e sana, mentre valori prossimi a $0$ o negativi indicano la totale assenza di fotosintesi, identificando suolo nudo, rocce o acqua. L'NDVI è particolarmente utile per monitorare variazioni nella copertura vegetale nel tempo e valutare stress idrici, dinamiche ecologiche o impatti antropici e faunistici, come nel caso del sovrapascolamento.

````r
ndvi_2020 <- im.ndvi(franco_2020, 4, 3)  # utilizzo funzione im.ndvi() del pacchetto imageRy
ndvi_2023 <- im.ndvi(franco_2023, 4, 3)  # 4 è la banda NIR, 3 è la banda Red
ndvi_2026 <- im.ndvi(franco_2026, 4, 3)  

im.multiframe(1, 3)  # configuro pannello grafico con 1 riga e 3 colonne usando la funzione di imageRy
plot(ndvi_2020, col = viridis(100), main = "NDVI 2020")  # visualizzo NDVI prima dell'eradicazione, assegno palette col., denomino
plot(ndvi_2023, col = viridis(100), main = "NDVI 2023")  # visualizzo NDVI durante eradicazione, assegno palette col., denomino
plot(ndvi_2026, col = viridis(100), main = "NDVI 2026")  # visualizzo NDVI dopo eradicazione, assegno palette col., denomino
dev.off()  # chiudo il pannello di visualizzazione delle immagini
````

<img width="1280" height="709" alt="franco_ndvi" src="https://github.com/user-attachments/assets/065f7a95-1e31-457d-9054-d5740eadfdaf" />

> NDVI dei tre periodi presi in analisi

Procedo con il calcolo della differenza tra l'NDVI del 2023 e quello del 2020, tra l'NDVI del 2026 e quello del 2023 e, infine, tra l'NDVI del 2026 e quello del 2020.

````r
ndvi_diff_fase1  <- ndvi_2023 - ndvi_2020  # assegno nome e calcolo differenze NDVI
ndvi_diff_fase2 <- ndvi_2026 - ndvi_2023
ndvi_diff_totale <- ndvi_2026 - ndvi_2020

im.multiframe(1, 3)  # configuro pannello grafico con 1 riga e 3 colonne usando la funzione di imageRy
plot(ndvi_diff_fase1, col = magma(100), main = "ΔNDVI (2023 - 2020)")  # visualizzo immagini con risultati differenza NDVI
plot(ndvi_diff_fase2, col = magma(100), main = "ΔNDVI (2026 - 2023)")
plot(ndvi_diff_totale, col = magma(100), main = "ΔNDVI (2026 - 2020)")
dev.off()  # chiudo il pannello di visualizzazione delle immagini
````

<img width="1280" height="709" alt="franco_delta_ndvi" src="https://github.com/user-attachments/assets/abe9a72f-74b0-4e51-a579-b2634cbb62ca" />

>  Confronto dei **ΔNDVI**

> [!NOTE]
> Il confronto mostra differenze graduali e continue, passando da valori prossimi allo 0 a valori più elevati, i quali indicano un incremento strutturale della biomassa fogliare.


## 5. Visualizzazione dei dati 📊

### 5.1. Ridgeline Plot

Il Ridgeline Plot dei singoli NDVI consente di confrontare visivamente la distribuzione dell’indice NDVI nel 2020, 2023 e 2026, evidenziando eventuali variazioni nel tempo dei valori assoluti di vegetazione.

````r
franco_ridg <- c(ndvi_2020, ndvi_2023, ndvi_2026)  # unisco raster NDVI dei diversi anni in un unico oggetto multistrato
# nomino punti sull'asse verticale
names(franco_ridg) <- c("NDVI 2020 (Pre-eradicazione)", "NDVI 2023 (Eradicazione)", "NDVI 2026 (Post-eradicazione)")
im.ridgeline(franco_ridg, scale = 1.2, palette = "viridis")  # creo grafico ridgeline con funzione di imageRy
dev.off()  # chiudo il pannello di visualizzazione delle immagini
````

<img width="1280" height="709" alt="franco_ridge_ndvi" src="https://github.com/user-attachments/assets/d664c03e-9d52-4db8-88c1-c939e3494043" />

> Ridgeline Plot per confrontare la distribuzione dell'NDVI nei tre anni presi in analisi

> [!IMPORTANT]
> Il **Ridgeline Plot** dei singoli **NDVI** offre una conferma statistica al trend osservato da immagini satellitari. Anzitutto, la distribuzione bimodale fortemente asimmetrica riflette la netta separazione tra le aree fotosinteticamente non attive (zone costiere, suolo roccioso, etc.) e a bassa riflettanza, con picco stabile poco superiore allo 0, e la biomassa insulare. Tra il 2020 e il 2023 le curve relative alla biomassa vegetale sono pressoché sovrapposte, indicando che, a due anni dall'inizio dell'intervento di eradicazione, la vegetazione non mostrava ancora una risposta visibile. Nella curva NDVI del 2026 il picco della vegetazione si sposta verso destra (> 0.75), divenendo più alto e stretto. Questo shift della densità di frequenza verso valori più alti dell'indice suggerisce un incremento di vigore vegetativo, mentre la minor larghezza della curva indica un aumento omogeneo in tutta l'area considerata. 

Inoltre, sempre tramite Ridgeline Plot, procedo con un confronto tra ΔNDVI 2023-2020, ΔNDVI 2026-2023 e ΔNDVI 2026-2020 al fine di osservare eventuali cambiamenti rispetto alla differenza della prima fase di eradicazione, alla differenza della seconda fase e alla differenza totale tra un anno prima dell'inizio e due anni dopo la fine del progetto Life.

````r
delta_ridg <- c(ndvi_diff_fase1, ndvi_diff_fase2, ndvi_diff_totale)  # unisco ΔNDVI dei diversi anni in un unico oggetto multistrato
names(delta_ridg) <- c("ΔNDVI 2023-2020", "ΔNDVI 2026-2023", "ΔNDVI 2026-2020")  # denomino punti sull'asse verticale
im.ridgeline(delta_ridg, scale = 1.2, palette = "magma")  # creo grafico ridgeline con funzione di imageRy
dev.off()  # chiudo il pannello di visualizzazione delle immagini
````

<img width="1280" height="709" alt="franco_ridge_delta_ndvi" src="https://github.com/user-attachments/assets/76a85e39-466e-499a-9a13-b3cc56d4a1b5" />

> Ridgeline Plot per confrontare la distribuzione dei ΔNDVI

> [!IMPORTANT]
> Nel **Ridgeline Plot** dei **ΔNDVI** la distribuzione del 2023–2020 risulta pressoché centrata attorno allo 0, indicando un cambiamento vegetazionale complessivamente limitato durante le prime fasi di eradicazione della specie. La distribuzione del ΔNDVI 2026–2023 mostra un progressivo spostamento verso valori positivi, suggerendo un incremento generalizzato dell'attività vegetativa rispetto alle condizioni iniziali antecedenti. Infine, la curva ΔNDVI 2026–2020, la quale esprime il bilancio complessivo dell'intervento, consolida questo trend mostrando una distribuzione verso valori positivi. Tale grafico, più alto e stretto, suggerisce come l'incremento della risposta spettrale associata alla copertura vegetale sia aumentato in modo netto e omogeneo in tutta l'area solo dopo il completamento dell'eradicazione.


### 5.2. Classificazione per classi NDVI di copertura del suolo

Scelgo il range di valori adatto alla classificazione facendo riferimento agli **istogrammi** della distribuzione dell'**NDVI**.

````r
im.multiframe(1, 3)  # configuro il pannello grafico con 1 riga e 3 colonne per gli istogrammi

breaks_ndvi <- seq(-0.6, 0.9, by = 0.05)  # con seq(inizio, fine, passo) creo una sequenza di numeri in cui divido intervallo valori NDVI da -0.6 a 0.9 in intervalli larghi 0.05

# istogramma NDVI 2020
hist(ndvi_2020,             # uso funzione per generare istogramma
     breaks = breaks_ndvi,  # imposto barre istogramma con stessi intervalli per confronto temporale
     xlim = c(-0.6, 0.9),   # imposto limiti asse x
     ylim = c(0, 6000),     # imposto limiti asse y
     main = "Distribuzione NDVI 2020",  # denomino istogramma 
     col = "lightgray",                 # imposto colore
     xlab = "Valori NDVI")              # denomino asse x

# istogramma NDVI 2023
hist(ndvi_2023,
     breaks = breaks_ndvi,
     xlim = c(-0.6, 0.9), 
     ylim = c(0, 6000), 
     main = "Distribuzione NDVI 2023", 
     col = "lightgray", 
     xlab = "Valori NDVI")

# istogramma NDVI 2026
hist(ndvi_2026,
     breaks = breaks_ndvi,
     xlim = c(-0.6, 0.9), 
     ylim = c(0, 6000), 
     main = "Distribuzione NDVI 2026", 
     col = "lightgray", 
     xlab = "Valori NDVI")
dev.off()  # chiudo il pannello di visualizzazione delle immagini
````
<details>
<summary>Istogrammi (cliccare qui)</summary> 
  
<img width="1280" height="709" alt="franco_hist_ndvi" src="https://github.com/user-attachments/assets/19490c0a-975e-4a69-9d29-fd9dc560ce62" />

</details>

Procedo con la classificazione della copertura del suolo mediante **classi NDVI** basata sugli istogrammi precedentemente ottenuti. Creo una matrice di riclassificazione per trasformare i valori originali dell’NDVI in nuove classi.

````r
class_matrix <- matrix(c(   # creo matrice di riclassificazione contenente i valori delle nuove classi
  -Inf,  0.35, 1,           # se NDVI < 0.35: classe 1 (scogliera / roccia / suolo)
  0.35,  0.65, 2,           # se 0.35 <= NDVI < 0.65: classe 2 (vegetazione rada / macchia degradata)
  0.65,  Inf, 3             # se NDVI >= 0.65: classe 3 (vegetazione densa / macchia in recupero)
), ncol = 3, byrow = TRUE)  # assegno il numero di colonne e imposto il riempimento della matrice riga per riga

class_matrix  # stampo la matrice per controllo grafico

# classificazione dei singoli anni con la funzione classify del pacchetto terra
ndvi_2020_cl <- classify(ndvi_2020, class_matrix)  # classifico raster in classi definite tramite la matrice
ndvi_2023_cl <- classify(ndvi_2023, class_matrix)  # funzione classify() legge ogni pixel del raster, riclassificandolo
ndvi_2026_cl <- classify(ndvi_2026, class_matrix)  


im.multiframe(1, 3)  # creo un multiframe con 1 riga e 3 colonne 
# visualizzazione delle mappe classificate
plot(ndvi_2020_cl, col = c("royalblue", "gold", "forestgreen"), main = "NDVI class. 2020", colNA = "white")  
plot(ndvi_2023_cl, col = c("royalblue", "gold", "forestgreen"), main = "NDVI class. 2023", colNA = "white")   
plot(ndvi_2026_cl, col = c("royalblue", "gold", "forestgreen"), main = "NDVI class. 2026", colNA = "white")
dev.off()  # chiudo il pannello di visualizzazione delle immagini
````
<img width="1280" height="709" alt="franco_classi_ndvi" src="https://github.com/user-attachments/assets/0827cd3a-c469-4642-b3d6-0da29c6bec87" />

> Classificazione della copertura del suolo mediante classi NDVI nei tre anni analizzati

> **LEGENDA**
> 
> 1 (blu): zona costiera / roccia / area urbanizzata; 2 (giallo): vegetazione meno densa; 3 (verde): vegetazione più densa. 


### 5.3. Calcolo delle frequenze delle classi NDVI di copertura del suolo 

Dalla classificazione precedentemente effettuata ricavo le **frequenze** delle nuove classi, riportandole in una tabella e, infine, visualizzandole in un diagramma a barre.

````r
# calcolo frequenza pixel appartenenti a ciascuna classe del raster NDVI riclassificato
freq_2020 <- freq(ndvi_2020_cl)
freq_2023 <- freq(ndvi_2023_cl)
freq_2026 <- freq(ndvi_2026_cl)

# calcolo totale pixel di terraferma escludendo NA per ogni anno
tot_pix_2020 <- sum(freq_2020$count)  # calcolo il totale dei pixel validi del raster NDVI riclassificato
tot_pix_2023 <- sum(freq_2023$count)  # sum() somma il totale dei pixel validi per ogni classe, contenuti nella colonna count 
tot_pix_2026 <- sum(freq_2026$count)  # il simbolo $ serve per accedere a un elemento di un oggetto, in questo caso a una colonna di un data frame

# calcolo percentuali moltiplicando pixel validi per 100 diviso totale pixel validi
perc_2020 <- freq_2020$count * 100 / tot_pix_2020
perc_2023 <- freq_2023$count * 100 / tot_pix_2023
perc_2026 <- freq_2026$count * 100 / tot_pix_2026

# creo dataframe
tabella_franco <- data.frame(   # funzione per creare tabella
  Classi = c("1: suolo / roccia", "2: macchia rada", "3: macchia densa"),
  a2020 = round(perc_2020, 2),  # colonne che contengono percentuali di ciascun anno arrotondate a 2 cifre decimali 
  a2023 = round(perc_2023, 2),
  a2026 = round(perc_2026, 2)
)

print(tabella_franco)  # visualizzo tabella
````

<div align="center">

| Classi | 2020 | 2023 | 2026
|--- |--- |--- |--- |
|   **1**: suolo / roccia | 11.91% | 12.34%  | 11.23% |  
|   **2**: macchia rada | 32.60% | 32.54% | 21.85% | 
|   **3**: macchia densa | 55.49% | 55.12% | 66.92% | 

</div>

> La **tabella** mostra valori simili tra il 2020 e il 2023 per le classi di macchia rada e macchia densa. Per quanto riguarda il 2026, rispetto ai precedenti anni presi in analisi, si passa a un 11% circa in meno di macchia rada e a un aumento del 12% circa di macchia densa

     
#### Visualizzazione 

````r
# creo grafico percentuali NDVI 2020
# uso dataset tabella_franco, personalizzo estetica, fill = Classi serve per colorare le barre in base alla classe NDVI
p1 <- ggplot(tabella_franco, aes(x = Classi, y = a2020, fill = Classi)) +   # funzione ggplot() per trasformare dati in grafici
  geom_bar(stat = "identity") +  # stat = "identity" significa che uso i valori già presenti nei dati, ovvero le percentuali già calcolate
  scale_fill_manual(values = c("royalblue", "gold", "forestgreen")) +  # assegno manualmente i colori alle classi
  ylim(0, 100) +  # imposto asse y da 0 a 100 (percentuali)
  labs(title = "Classi NDVI 2020", y = "% Copertura", x = NULL) +      # aggiungo titolo ed etichette agli assi
  theme_minimal() +  # applico stile grafico semplice
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
  legend.position = "none"  # nascondo legenda per non duplicarla 3 volte
  )

# creo grafico percentuali NDVI 2023
p2 <- ggplot(tabella_franco, aes(x = Classi, y = a2023, fill = Classi)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c("royalblue", "gold", "forestgreen")) +
  ylim(0, 100) +
  labs(title = "Classi NDVI 2023", y = NULL, x = NULL) +  # tolgo asse y per ridondanza
  theme_minimal() + 
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    legend.position = "none"  # nascondo legenda per non duplicarla 3 volte
  )

# creo grafico percentuali NDVI 2026
p3 <- ggplot(tabella_franco, aes(x = Classi, y = a2026, fill = Classi)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c("royalblue", "gold", "forestgreen")) +
  ylim(0, 100) +
  labs(title = "Classi NDVI 2026", y = NULL, x = NULL) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    legend.position = "right"  # attivo legenda
  )

p1 + p2 + p3  # affianco i tre grafici in un'unica riga (patchwork)
dev.off()     # chiudo il pannello grafico
````

<img width="1280" height="709" alt="franco_barre_ndvi" src="https://github.com/user-attachments/assets/fbb2799c-4b96-4ebe-be50-9b1185feb08c" />

> **Diagramma a barre** delle classi NDVI di copertura del suolo


## 6. Analisi multitemporale 📈

L’analisi multitemporale è stata applicata per valutare l’evoluzione della risposta vegetazionale prima, durante e dopo l’intervento di eradicazione del muflone sull’Isola del Giglio. Il confronto del ΔNDVI consente di quantificare le variazioni del vigore vegetativo rispetto alla condizione iniziale. Parallelamente, l’analisi delle differenze nella banda del vicino infrarosso (NIR) permette di osservare le variazioni della riflettanza associate alla struttura della vegetazione e alla biomassa. L’integrazione delle informazioni spettrali e spaziali consente quindi di identificare non solo l’entità del cambiamento, ma anche la sua distribuzione spaziale all’interno dell’area di studio.

````r
nir_dif_fase1 <- franco_2023[[4]] - franco_2020[[4]]   # calcolo differenza NIR durante eradicazione
nir_dif_fase2 <- franco_2026[[4]] - franco_2023[[4]]   # calcolo differenza NIR dopo eradicazione
nir_dif_totale <- franco_2026[[4]] - franco_2020[[4]]  # calcolo differenza NIR tra inizio e fine eradicazione

ndvi_dif_fase1 <- ndvi_2023 - ndvi_2020   # calcolo differenza NDVI durante eradicazione
ndvi_dif_fase2 <- ndvi_2026 - ndvi_2023   # calcolo differenza NDVI dopo eradicazione
ndvi_dif_totale <- ndvi_2026 - ndvi_2020  # calcolo differenza NDVI tra inizio e fine eradicazione

im.multiframe(2, 3)  # preparo pannello grafico con 2 righe e 3 colonne

plot(nir_dif_fase1, col = magma(100), main = "NIR (2023 - 2020)")   # visualizzo immagini differenza NIR
plot(nir_dif_fase2, col = magma(100), main = "NIR (2026 - 2023)")
plot(nir_dif_totale, col = magma(100), main = "NIR (2026 - 2020)")

plot(ndvi_dif_fase1, col = magma(100), main = "NDVI (2023 - 2020)")  # visualizzo immagini differenza NDVI
plot(ndvi_dif_fase2, col = magma(100), main = "NDVI (2026 - 2023)")
plot(ndvi_dif_totale, col = magma(100), main = "NDVI (2026 - 2020)")
dev.off()  # chiudo il pannello grafico
````
<img width="1280" height="709" alt="franco_multitemp" src="https://github.com/user-attachments/assets/87df216a-2dd2-4ce8-a278-ef33c0e68e1f" />

> Confronto NIR e NDVI nei periodi presi in analisi

> [!NOTE]
> Nel periodo **2023–2020**, la dinamica del NIR si attesta su valori prossimi allo 0 nella maggior parte dell'area, registrando solo locali fluttuazioni spaziali prive di un trend geografico definito. Parallelamente, l'andamento del ΔNDVI conferma che in questa prima fase non viene rilevato alcun segnale di ripresa vegetazionale generalizzato. Dal punto di vista ecologico, questa iniziale stasi spettrale potrebbe indicare un tempo di latenza biologica: la cessazione di un elevato disturbo di pascolamento non innesca una risposta immediata. Nel periodo **2026–2023**, lo scenario osservato indicherebbe l'inversione di tendenza dell'ecosistema insulare. Le mappe della differenza nel NIR e del ΔNDVI abbandonano le tonalità neutre e virano diffusamente verso valori positivi. Dal punto di vista ecologico, questo triennio potrebbe rappresentare la fase di reazione e colonizzazione: una volta completata l'eradicazione della specie target e superata la latenza iniziale, la vegetazione risponde con una crescita accelerata nella successione ecologica secondaria. Infine, nel periodo **2026–2020**, che esprime il bilancio complessivo del progetto, il trend di recupero sembrerebbe consolidarsi in modo definitivo. La differenza nel NIR evidenzia un incremento marcato e diffuso delle frequenze positive, il quale riflette un cambiamento strutturale profondo della vegetazione, probabilmente legato alla maggior ricrescita di biomassa legnosa e all'aumento della densità fogliare.


## 7. Conclusioni 🐐

Nel complesso, i dati ottenuti indicano una possibile fase di recupero della macchia mediterranea del Promontorio del Franco successiva alla rimozione del muflone, fornendo un’indicazione positiva rispetto all’efficacia dell’intervento. Tuttavia, i risultati devono essere interpretati considerando i limiti dell’approccio utilizzato: gli indici satellitari impiegati descrivono variazioni della risposta vegetazionale, ma non permettono da soli di attribuire esclusivamente all’eradicazione del muflone il cambiamento osservato. Fattori ambientali come disponibilità idrica, condizioni climatiche annuali e dinamiche naturali della vegetazione possono infatti contribuire alla variazione rilevata. Nonostante queste limitazioni, appaiono chiare le differenze nello stato della vegetazione tra la fase antecedente e quella successiva all'intervento di eradicazione, suggerendo spunti e riflessioni al riguardo.  Dunque, l'approccio integrato tra gestione della fauna e telerilevamento può rappresentare uno strumento di monitoraggio degli interventi di biologia della conservazione, permettendo di esplorare nel tempo la risposta degli habitat sottoposti a ripristino ecologico. In conclusione, il caso dell’Isola del Giglio evidenzia come la gestione delle specie aliene invasive non rappresenti soltanto un’azione di controllo della fauna, ma un intervento finalizzato alla conservazione della biodiversità e al recupero dei processi ecologici degli ecosistemi. 

---

### Bibliografia 📖

- *Nicoloso S. et al*., [Sintesi delle attività di eradicazione del muflone dall'Isola del Giglio, 2024](https://www.lifegogiglio.eu/wp-content/uploads/Life_LetsGoGiglio_Eradicazione_sintesi.pdf)
- *Nicoloso S. et al.*, [Protocollo operativo per l’eradicazione del 
muflone (Ovis aries) presso l’Isola del Giglio, 2021](https://www.lifegogiglio.eu/wp-content/uploads/ACTION-A1-LETSGOGIGLIO_Protocollo_Muflone__approvato_.pdf) 


### Link utili 💻
[Life LETSGO Giglio](https://www.lifegogiglio.eu/)

