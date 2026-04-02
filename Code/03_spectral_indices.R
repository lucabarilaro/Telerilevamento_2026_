library(terra)
library(imageRy)
library(viridis)

im.list() #elenca tutti i file (dataset) disponibili all'interno del pacchetto ImageRy
windows()

mato1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
mato1992 <- flip(mato1992)

# l1=NIR l2=red l3=green
im.plotRGB(mato1992, 1, 2, 3)

##Exercise
# put NIR on top of the green component of the RGB scheme
im.plotRGB(mato1992, 2, 1, 3)
# NIR ontop of the blue
im.plotRGB(mato1992, 3, 2, 1)

##Exercise: import the image from 2006
mato2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
mato2006 <- flip(mato2006)
im.plotRGB(mato2006, 1, 2, 3)

##Exercise: make a multiframe with the two images, one beside the other
im.multiframe(1,2)
im.plotRGB(mato1992, 1, 2, 3)
im.plotRGB(mato2006, 1, 2, 3)

dev.off()

plotRGB(mato1992, 1,2,3, stretch="hist")
#stretch serve a "spalmare", stirare, i valori dei pixel su tutta la scala di colori disponibile (da 0 a 255)
#stretch="hist" determina stiramento ad istogramma (contrasto molto forte)
plotRGB(mato2006, 1,2,3, stretch="hist")


im.plotRGB(mato1992, 2, 1, 3)
im.plotRGB(mato2006, 2, 1, 3)

im.plotRGB(mato1992, 2, 3, 1)
im.plotRGB(mato2006, 2, 3, 1)


##DVI #Difference Vegetation Index (Indice di Vegetazione per Differenza).
# indice per quantificare la presenza e la salute della vegetazione in un'immagine satellitare

#l1=NIR l2=red l3=green
dvi1992 <- mato1992[[1]] - mato1992[[2]]

## 8 bit 
#più bit hai, più sfumature di colore si possono distinguere
#8 bit significa che il sensore può contare fino a 2^8=256 valori (da 0 a 255)
# NIR - red = 255 - 0 = 255 max DVI -> massimo di NIR e minimo di red (0)
# NIR - red = 0 - 255 = -255 min DVI -> pixel riflette tutto il rosso ma no infrarosso
# range = -255, 255 -> risultato oscilla sempre tra -255 e 255. 

# Exercise: calculate min and max of DVI for an image composed by data at 4 bit
# 4 bit = 2^4 = 16 -> sensore più grossolano, può contare fino a 16 valori (da 0 a 15)
# NIR - red = 15 - 0 = 15 max DVI
# NIR - red = 0 - 15 = -15 min DVI

# dvi1992 <- mato1992[[1]] - mato1992[[2]] crea una nuova mappa in cui pixel 
# con numeri alti (vicini a 255 o 15) sono foreste rigogliose. 
# pixel vicini allo 0 sono suolo nudo, strade o edifici (riflettono NIR e red in modo simile)
# pixel con numeri negativi quasi sempre acqua (che assorbe tutto l'infrarosso)

##NDVI #Normalize Difference Vegetation Index
#(NIR-red/NIR+red)->(DVI/NIR+red)
#immagine a 8 bit e DVI=10 -> pochissima vegetazione
#immagine a 4 bit e DVI=10 -> vegetazione rigogliosa
#per evitare confusione tra satelliti diversi si usa NDVI
#il range sempre tra -1 e 1, indipendentemente dai bit del satellite. È un modo per normalizzare i dati e renderli confrontabili universalmente

dvi2006 <- mato2006[[1]] - mato2006[[2]]

ndvi1992 <- dvi1992 / (mato1992[[1]] + mato1992[[2]])
ndvi2006 <- dvi2006 / (mato2006[[1]] + mato2006[[2]])

im.multiframe(1,2)
plot(ndvi1992, col=inferno(100))
plot(ndvi2006, col=inferno(100))

# DVI by imageRy
dvi1992 = im.dvi(mato1992, 1, 2)
dvi2006 = im.dvi(mato2006, 1, 2)
plot(dvi1992, col=inferno(100))
plot(dvi2006, col=inferno(100))

# NDVI via imageRy
ndvi1992 = im.ndvi(mato1992, 1, 2)
ndvi2006 = im.ndvi(mato2006, 1, 2)
plot(ndvi1992, col=mako(100))
plot(ndvi2006, col=mako(100))

# Exercise: plot DVIs and NDVIs for the two dates in two rows and columns
im.multiframe(2, 2)
plot(dvi1992, col=inferno(100))
plot(dvi2006, col=inferno(100))
plot(ndvi1992, col=magma(100))
plot(ndvi2006, col=magma(100))
