# Set your working Directory

setwd("C:/")

# Open file from phenotype database

Phenotype <- read.csv(file = 'TRIM.csv',header = TRUE)

# Search mutant's phenotype

Search <- function(name){
  for(i in c(1:68)){
    if(grepl(name, as.character(Phenotype$Mutantdata[i]))==TRUE){
      print(paste(as.character(Phenotype$struct[i]),'-',as.character(Phenotype$title[i])))
    }
  } 
}

# Command : Search("Mutant name")

Search("52048")
