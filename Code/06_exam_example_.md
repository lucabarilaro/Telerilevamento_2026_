# Ice spread: questo è il titolo della presentazione da fare all'esame 

<img width="1280" height="960" alt="JCXUFYUOUHQ3OILJNXS3W5GJVE" src="https://github.com/user-attachments/assets/4d45d77e-b261-4e21-84bd-3d118e040de0" />

*Nota bene: l'immagine è stata riportata semplicemente trascinandola del desktop*

In questa riga scrivo l'intro alle mie analisi.

## Immagine satellitare da internet: dati di input 

L'immagine è stata scaricata da Earth Observatory:
https://science.nasa.gov/earth/earth-observatory/contours-of-the-james-bay-lowlands/

L'immagine è stata scaricata da [Earth Observatory](
https://science.nasa.gov/earth/earth-observatory/contours-of-the-james-bay-lowlands/)

*Nota bene: con il secondo metodo, mettendo le quadre, associo il link direttamente al nome. Stilisticamente più carino*

Pacchetti usati in R:

``` r
library(terra) #package to manage spatial data
library(imageRy) #package for RS didactics
```

Importazione dei dati tramite `setwd()`:
``` r
setwd()
getwd()
list.files()
```

Dati importati via `rast()`:
``` r
ice <- rast("ISS074-E-417243.jpg")
```

## Plottaggio delle singole bande 

Le singole bande sono state plottate usando un multiframe:
``` r
im.multiframe(2,1)
plot(ice[[1]]) 
plot(ice[[2]])
```

Questo l'output del plottaggio:

<img width="1280" height="709" alt="output_esempio_esame" src="https://github.com/user-attachments/assets/e5fe8ebd-9182-4f83-93de-1ebf6806a2cd" />

*Immagine inserita sempre per trascinamento*

> Nota: l'immagine è già stata analizzata da Earth Observatory

Se vogliamo inserire un elenco puntato è sufficiente usare il +:
+ punto dell'elenco
+ punto dell'elenco
+ punto dell'elenco

Istogrammi per la mia immagine:
``` r
im.multiframe(3,1)
hist(values(ice[[1]]), main="Istogramma Red", col="red")
hist(values(ice[[2]]), main="Istogramma Green", col="green")
hist(values(ice[[3]]), main="Istogramma Blue", col="blue")
```
Output:

<img width="480" height="480" alt="ist" src="https://github.com/user-attachments/assets/79c029d7-33ed-484c-8cfc-45c11148e76f" />
