# Read  data
Genelist <- read.table("POAG_genelist.csv", sep = "\t", header=T)
GeneUnique <- data.frame(sort(unique(Genelist$Gene.Name), decreasing=F))

write.table(GeneUnique,col.names = F,file = "GenePossList.csv", sep=",",quote=F,row.names=F)