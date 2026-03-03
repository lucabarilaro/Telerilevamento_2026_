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
im.import("sentinel.dolomites.b3.tif") #per importare e mostrare dei dati
b2 <- im.import("sentinel.dolomites.b3.tif") #eseguo assegnazione

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
