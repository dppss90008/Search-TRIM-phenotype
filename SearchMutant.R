# Set your working Directory

setwd("C:/")

#### You can start your program from here (You do not have to craw the data again) ####
# Open file from phenotype csv file

Phenotype <- read.csv(file = 'TRIM_phenotype.csv',header = TRUE)

# Search mutant's phenotype and print output

Search <- function(name){
  for(i in c(1:68)){
    if(grepl(name, as.character(Phenotype$Mutant_data[i]))==TRUE){
      print(paste(as.character(Phenotype$struct[i]),'-',as.character(Phenotype$title[i])))
    }
  } 
}

# Command : Search("Mutant name")

Search("M0052048")