# Craw title and Connection from TRIM database
library(rvest)
url = 'http://rice.sinica.edu.tw/TRIM2/showTraits.php'
url=read_html(url) 
url=html_nodes(url,"a") 
title=html_text(url)
nxturl=html_attr(url,"href")
nxturl <- sapply(nxturl,function(x){
  return(paste0("http://rice.sinica.edu.tw/TRIM2/",x))
})

# Phenotype URL table
PhenotypeURL <- cbind(title,nxturl)
PhenotypeURL <- PhenotypeURL[-c(69,70),]
rownames(PhenotypeURL) <- c(1:68)

FindMutant <- function(x){
  url=read_html(PhenotypeURL[x,2]) 
  url=html_nodes(url,"td")
  mutant=html_text(url)
  return(mutant[2])
}

library(magrittr)
Mutantdata <- sapply(c(1:68),FindMutant)
Phenotype <- cbind(PhenotypeURL,Mutantdata) %>% data.frame
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

Phenotype<- cbind(Phenotype,struct)
write.csv(Phenotype,file='TRIM.csv')

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

Search("11350")
