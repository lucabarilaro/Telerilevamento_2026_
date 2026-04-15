library(terra) #package to manage spatial data

setwd(desktop)
getwd()
list.files()

ice <- rast ("ISS074-E-417243.jpg")

im.multiframe(1,2)
plot(ice[[1]])
plot(ice[[2]])



