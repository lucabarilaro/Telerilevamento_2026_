# R code for visualizing multispectral data

# install.packages("devtools")
# install.packages("viridis")
# library()  #comando per richiamare pacchetti installati in precedenza

# library vanno chiamate sempre all'inizio di ogni script. inoltre, vanno spiegate, così come qualsiasi funzione si esegue
library(terra) #package for spatial data
library(imageRy) #package devoted to satellite images
library(viridis)

# ogni funzione di imageRy inizia con im.
im.list()

# Sentinel 2-bands
# https://gisgeography.com/sentinel-2-bands-combinations/

im.import("sentinel.dolomites.b2.tif") #funzione per importare e mostrare dei dati
b2 <- im.import("sentinel.dolomites.b2.tif") #eseguo assegnazione


# funzioni per cambiare colore

colorRampPalette(c("darkslategray4", "darkseagreen4", "green4"))(100) 
# funzione colorRampPalette è la più grezza. da lui definito come metodo "selvaggio"
#i vettori vanno sempre concatenati con la funzione c() 
#100 è il numero di sfumature. lo mette sempre
cl <- colorRampPalette(c("darkslategray4", "darkorchid3", "green4"))(100)
plot (b2, col=cl)
#per passare a una scala di grigi
colorRampPalette(c("dark gray", "gray", "lightgray"))(100) #i vettori vanno sempre concatenati con la funzione c() #100 è il numero di sfumature
cl <- colorRampPalette(c("dark gray", "gray", "light gray"))(100)

#modo più fine per cambiare colori, utilizzando una libreria anche per daltonici
library("viridis")
plot(b2, col=inferno(100))
#oppure, a seconda del tipo di scala di colore, col=mako invece che inferno, etc. Cercare su viridis per vedere le tipologie di scale di colore
plot(b2, col=mako(100))


# funzioni per mettere a confronto immagini

# funzione par() metodo grezzo
par(mfrow=c(1,2))
plot(b2, col=inferno(100))
plot (b2, col=cl)

# per chiudere qualsiasi finestra grafica eseguire funzione dev.off()

# funzione im.multiframe() metodo più fine
im.multiframe(1,2)
plot(b2, col=inferno(100))
plot (b2, col=cl)


# importing band 3
b3 <- im.import("sentinel.dolomites.b3.tif")

excercise: change the ramp palette according to the viridis package
plot(b3, col=plasma(100))
 
# importing band 4
b4 <- im.import("sentinel.dolomites.b4.tif")

#importing band 8
b8 <- im.import("sentinel.dolomites.b8.tif")

# esercizio multiframe con le 4 bande
b2 <- im.import("sentinel.dolomites.b2.tif")
clb <- colorRampPalette(c("dark blue", "blue", "light blue"))(100)

b3 <- im.import("sentinel.dolomites.b3.tif")
clg <- colorRampPalette(c("dark green", "green", "light green"))(100)

b4 <- im.import("sentinel.dolomites.b4.tif")
clr <- colorRampPalette(c("#8B1A1A", "red", "pink"))(100)

b8 <- im.import("sentinel.dolomites.b8.tif")
cln <- colorRampPalette(c("goldenrod3", "goldenrod2", "goldenrod"))(100)

im.multiframe(2,2)
plot(b2, col=clb)
plot(b3, col=clg)
plot(b4, col=clr)
plot(b8, col=cln)

# altri metodi per confrontare immagini in modo più veloce
# 1
sentinel <- c(b2, b3, b4, b8)
plot(sentinel)
plot(sentinel, col=inferno(100))
# 2
plot(sentinel$sentinel.dolomites.b8)
# 3
# layer1=b2, layer2=b3, layer3=b4, layer4=b8
plot(sentinel[[4]])
plot(sentinel[[2]])


## stack
#metodo per sovrapporre immagini (bande), creando unico file multistrato
b2 <- im.import("sentinel.dolomites.b2.tif") 
b3 <- im.import("sentinel.dolomites.b3.tif")
b4 <- im.import("sentinel.dolomites.b4.tif")
b8 <- im.import("sentinel.dolomites.b8.tif")

##NOTA BENE: stack funziona solo con immagini con la stessa banda
# e sistemi di riferimento uguali


## ggplot2
#metodo per confrontare immagini (bande)

p1 <- im.ggplot(b8) 
#funzione im.ggplot() converte un'immagine satellitare (raster) 
#in formato compatibile con ggplot2, permettendo creazione mappe con scale di colore come viridis
p2 <- im.ggplot(b4)
p1 + p2


###Ricapitolando, esistono più metodi per Multiframe:
# 1. par(mfrow=c(1,2))
# 2. im.multiframe(1,2)
# 3. stack
# 4. ggplot2 & patchwork


## RGB plotting
#tecnica che permette di visualizzare un'immagine satellitare
#combinando 3 bande spettrali: R (red), G (green), B (blue).

sentinel <- c(b2, b3, b4, b8)

# 1=b2 blue
# 2=b3 green
# 3=b4 red
# 4=b8 nir

# 3 filters and 4 bands
im.plotRGB(sentinel, r=3, g=2, b=1) # natural colors. immagine simile a quella scattata da un aereo
im.plotRGB(sentinel, r=4, g=3, b=2) # false colors. sostituzione banda visibile con una invisibile (NIR, infrarosso)


#applicazione metodi di confronto-sovrapposizione bande visti in precedenza
im.multiframe(1,2)
im.plotRGB(sentinel, r=3, g=2, b=1)
im.plotRGB(sentinel, r=4, g=3, b=2)

dev.off()

plot(sentinel[[4]])
im.plotRGB(sentinel, r=4, g=3, b=2)


#NIR on green
im.plotRGB(sentinel, r=3, g=4, b=2) #false colors
#NIR on blue
im.plotRGB(sentinel, r=3, g=2, b=4) #false colors

#Plot the four manners of RGB in a single multiframe
im.multiframe(2,2)
im.plotRGB(sentinel, r=3, g=2, b=1) # natural colors 
im.plotRGB(sentinel, r=4, g=3, b=2) # false colors
im.plotRGB(sentinel, r=3, g=4, b=2) # false colors
im.plotRGB(sentinel, r=3, g=2, b=4) # false colors

#Positioning of visible bands
im.multiframe(1,2)
im.plotRGB(sentinel, r=4, g=3, b=2) # false colors
im.plotRGB(sentinel, r=4, g=2, b=3) # false colors

#Semplificazione scrittura stringa (no lettere)
im.plotRGB(sentinel, 4, 2, 3) # false colors
