# First R script

2 + 3

# oggetti e assegnazione: due metodi per assegnare un oggetto (2+3) a un nome che si vuole utilizzare
boccia <- 2+3
boccia = 2+3
pippo <- 4+6

# operazioni
pippo + boccia
pippo ^ boccia
boccia / pippo

#arrays o vettori
blabla <- c(10, 8, 3, 1, 0) #funzione "concatenate" e argomenti o vettori (elementi all'interno della parentesi)

giorgio <- c(3, 10, 20, 50, 100) #variabile indipendente sulle x

plot (giorgio, blabla, col="blue", pch=19, cex=2, xlab="pollution", ylab="numero di delfini") #cex è la dimensione del punto, pch è il tipo di punto, xlab è l'etichetta che si vuole dare all'asse x

# installazione pacchetti
## CRAN
install.packages("terra") # funzione che consente di installare pacchetto
library(terra) #funzione che consente di chiamare il pacchetto precedentemente installato

##GitHUB 
install.packages("devtools") #in alternativa si può installare anche pacchetto "remotes"
library(devtools)
install_github ("ducciorocchini/imageRy")
