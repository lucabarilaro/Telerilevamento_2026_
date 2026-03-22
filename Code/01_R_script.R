# first R script

2 + 3

# oggetti e assegnazione: due metodi per assegnare un oggetto (es. 2+3) a un nome che si vuole utilizzare
luca <- 2+3
luca = 2+3

giada <- 4+6

# operazioni
giada + luca
giada ^ luca
giada / luca

# arrays o vettori
teresa <- c(10, 8, 3, 1, 0) # c() funzione "concatenate" con argomenti o vettori (elementi all'interno della parentesi)
arianna <- c(3, 10, 20, 50, 100) 

# esecuzione del plot. ricorda: variabile indipendente va sull'asse x

plot (arianna, teresa, col="blue", pch=19, cex=2, xlab="pollution", ylab="numero di delfini") 
# cex è la dimensione del punto, pch è il tipo di punto, xlab è l'etichetta che si vuole dare all'asse x

# installazione pacchetti
## CRAN
install.packages("terra") # fuzione che consente di installare pacchetto (es.terra)
library(terra) # funzione che consente di chiamare il pacchetto precedentemente installato

##GitHUB 
install.packages("devtools") # in alternativa si può installare anche pacchetto "remotes"
library(devtools)
install_github ("ducciorocchini/imageRy")
