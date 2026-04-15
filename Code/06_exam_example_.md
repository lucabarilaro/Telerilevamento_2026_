# Ice spread: titolo della presentazione
<img width="3000" height="2000" alt="8A0A57E0-4FA4-42DC-A44267E8D5D8C94C_source" src="https://github.com/user-attachments/assets/7e95d19d-f2aa-43ca-8461-7fbdb671d7bd" />

in questa riga scrivo intro delle analisi

## Immagine satellitare da internet: dati di input
L'immagine è stata scaricata da Earth Observatory:
link

L'immagine è stata scaricata da Earth Observatory:
link


Pacchetti usati in R:
```r
library(terra) #package to manage spatial data
library(ImageRy) #package for RS didatics
```

Importazione dati tramite setwd():
```r
setwd(desktop)
getwd()
list.files()
```
## Dati importati via rast()
```r
ice <- rast ("ISS074-E-417243.jpg")
```

## 
```r
im.multiframe(1,2)
plot(ice[[1]])
plot(ice[[2]])
```



