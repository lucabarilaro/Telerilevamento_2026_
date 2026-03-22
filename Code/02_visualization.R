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





#stack prende tutte immagini e le mette insieme
sentinel <- c(b2, b3, b4, b8)
plot (sentinel)

#per cambiare colore
plot (sentinel, col=inferno(100))

plot (sentinel$sentinel.dolomites.b8) #$ in R serve per collegare vari pezzi tutti insieme

#layer1=b2, layer2=b3, layer3=b4, layer4=b8
plot(sentinel[[4]])
plot(sentinel[[2]])
