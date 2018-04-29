# Craw title and Connection from TRIM database
library(rvest)
library(magrittr)

url = 'http://rice.sinica.edu.tw/TRIM2/showTraits.php' %>% read_html %>% html_nodes(.,"a") 
title = html_text(url)
linkURL = html_attr(url,"href") %>% sapply(.,function(x){
  return(paste0("http://rice.sinica.edu.tw/TRIM2/",x))})

# Create a Phenotype URL table
PhenotypeURL <- cbind(title,linkURL)
PhenotypeURL <- PhenotypeURL[-c(69,70),]
rownames(PhenotypeURL) <- c(1:68)

# Craw mutants from linkURL
FindMutant <- function(x){
  mutant = read_html(PhenotypeURL[x,2]) %>% html_nodes(.,"td") %>% html_text
  return(mutant[2])
}

# Create a mutants and phenotype tabe store it as a csv file

Mutant_data <- sapply(c(1:68),FindMutant)
struct <-c(rep("Development",time=4),
           rep("Leaf Color",time=10),
           rep("Leaf Morphology",time=13),
           rep("Plant stature",time=9),
           rep("Lesion",time=1),
           rep("Tiller",time=4),
           rep("Heading Date",time=3),
           rep("Glume",time=5),
           rep("Panicle",time=12),
           rep("Fertility",time=2),
           rep("Grain",time=5)
)

Phenotype <- cbind(PhenotypeURL,struct,Mutant_data) %>% data.frame %>% write.csv(.,file='TRIM_phenotype.csv')


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
