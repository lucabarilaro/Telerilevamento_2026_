# R code for visualizing multispectral data

# install.packages("devtools")
# install.packages("viridis")
# library()  #comando per richiamare pacchetti installati in precedenza

library(terra) #package for spatial data
library(imageRy) #package devoted to satellite images

im. #ogni funzione di imageRy inizia con im.
im.list()
# Sentinel 2-bands
# https://gisgeography.com/sentinel-2-bands-combinations/
im.import("sentinel.dolomites.b2.tif") #per importare e mostrare dei dati
b2 <- im.import("sentinel.dolomites.b2.tif") #eseguo assegnazione

colorRampPalette(c("darkslategray4", "darkseagreen4", "green4"))(100) #i vettori vanno sempre concatenati con la funzione c() #100 è il numero di sfumature
cl <- colorRampPalette(c("darkslategray4", "darkorchid3", "green4"))(100)

#Changing colours
plot (b2, col=cl)

#modo più fine per cambiare colori, utilizzando una libreria anche per daltonici #ascoltare reg. 4 pt. 2 da 16.00
library("viridis")

#using viridis to change colors
plot(b2, col=inferno(100))
#oppure, a seconda del tipo di scala di colore, posso usare mako invece che inferno, etc. Cercare su viridis per vedere le tipologie di scale di colore
plot(b2, col=mako(100))

#per passare a una scala di grigi
colorRampPalette(c("dark gray", "gray", "lightgray"))(100) #i vettori vanno sempre concatenati con la funzione c() #100 è il numero di sfumature
cl <- colorRampPalette(c("dark gray", "gray", "light gray"))(100)

#funzione par per mettere immagine accanto a un'altra. metodo grezzo
par(mfrow=c(1,2))
plot(b2, col=inferno(100))
plot (b2, col=cl)

#per chiudere qualsiasi finestra grafica eseguire funzione dev.off()

#funzione per mettere immagine a confronto con un'altra. metodo più fine
im.multiframe(1,2)
plot(b2, col=inferno(100))
plot (b2, col=cl)

#importing band 3
b3 <- im.import("sentinel.dolomites.b3.tif")

library(viridis)

excercise: change the ramp palette according
plot(b3, col=plasma(100))

#importing band 4
b4 <- im.import(b3 <- im.import("sentinel.dolomites.b3.tif"))

#importing band 8
b8 <- im.import("sentinel.dolomites.b8.tif")

#esercizio multiframe con le 4 bande
b2 <- im.import("sentinel.dolomites.b2.tif")
clb <- colorRampPalette(c("dark blue", "blue", "light blue"))(100)

b3 <- im.import("sentinel.dolomites.b3.tif")
clg <- colorRampPalette(c("dark green", "green", "light green"))(100)

b4 <- im.import("sentinel.dolomites.b4.tif")
clr <- colorRampPalette(c("#8B1A1A", "green ", "light green"))(100)

b8 <- im.import("sentinel.dolomites.b8.tif")
cln <- colorRampPalette(c("goldenrod3", "goldenrod2", "goldenrod"))(100)

im.multiframe(2,2)
plot(b2, col=clb)
plot(b3, col=clg)
plot(b4, col=clr)
plot(b8, col=cln)

#stack prende tutte immagini e le mette insieme
sentinel <- c(b2, b3, b4, b8)
plot (sentinel)

#per cambiare colore
plot (sentinel, col=inferno(100))

plot (sentinel$sentinel.dolomites.b8) #$ in R serve per collegare vari pezzi tutti insieme

#layer1=b2, layer2=b3, layer3=b4, layer4=b8
plot(sentinel[[4]])
plot(sentinel[[2]])
