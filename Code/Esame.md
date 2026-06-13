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

> Isola del Giglio. Nel riquadro arancione è indicata l'area di intervento, con presenza di siti caratterizzati da maggior densità della specie. Mappa di Lorenzo La Russa.



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

### Acquisizione immagini

Le immagini satellitari provengono da [**Google Earth Engine**](https://earthengine.google.com/), attraverso cui è stata selezionata l'area di intervento per le fasi e le relative date precedentemente indicate.
> [!NOTE]
> Il codice JavaScript utilizzato è quello fornito durante il corso ed è disponibile nel file Codice.js

### Importazione e visualizzazione immagini
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

<img width="664" height="664" alt="pre_2016" src="https://github.com/user-attachments/assets/d100be43-5d3b-4a6b-b956-0542d05d99e1" />
> Immagine satellitare nelle 4 bande riguardante il periodo antecedente all'intervento di eradicazione












