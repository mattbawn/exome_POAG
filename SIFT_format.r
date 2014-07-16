## R Script to translate data produced by vcf_comp_sort.r to enable upload to SIFT
## http://sift.jcvi.org/www/chr_coords_example.html
## NOTE ORIENTATION SET TO 1
## Matt Bawn 16/07/14 mattbawn@gmail.com

data_122 <- read.csv("122_missense.csv", )
#data_180 <- read.csv("180_missense.csv",)

# Remove non-standard characters for SIFT analysis
data_122_edit <- data_122[(data_122$sampleGenotype %in% c("C", "G", "T", "A")),]

# Combine nucleotide columns and seperate with /
Nuc_comp <- paste(data_122_edit$referenceBase, data_122_edit$sampleGenotype, sep="/")
SIFT_122 <- subset(data_122_edit, select = c(chromosome, position))

size <- dim(data_122_edit)
size1 <- size[[1]]

orientation <- list(rep(1, size1))

SIFT_format <- cbind(SIFT_122,orientation,Nuc_comp)

#SIFT_format <- SIFT_format[,-1]

write.table(SIFT_format,col.names = F,file = "SIFT.csv", sep=",",quote=F,row.names=F)


## TRANSLATE NON-NUCLEOTIDE CHARACTERS

# Select non-nucleotide characters
data_122_non <- data_122[!(data_122$sampleGenotype %in% c("C", "G", "T", "A")),]

# Change non-nucleotide characters

data_122_c1 <- chartr("RYKSWM", "ACGCAA", data_122_non$sampleGenotype)
data_122_c2 <- chartr("RYKSWM", "GTTGTC", data_122_non$sampleGenotype)

# combine nucleotide refs
Nuc_comp_c1 <- paste(data_122_non$referenceBase, data_122_c1, sep="/")
Nuc_comp_c2 <- paste(data_122_non$referenceBase, data_122_c2, sep="/")

# Select 1st two columns
SIFT_122_c <- subset(data_122_non, select = c(chromosome, position))

sizeC <- dim(data_122_non)
sizeC1 <- sizeC[[1]]

# make orientation column (SET TO 1)
orientation_c <- list(rep(1, sizeC1))

# Coc. to SIFT FORMAT
SIFT_format_c1 <- cbind(SIFT_122_c,orientation_c,Nuc_comp_c1)
SIFT_format_c2 <- cbind(SIFT_122_c,orientation_c,Nuc_comp_c2)

# OUTPUT FILES AS .csv FORMAT
write.table(SIFT_format_c1,col.names = F,file = "SIFTC1.csv", sep=",",quote=F,row.names=F)
write.table(SIFT_format_c2,col.names = F,file = "SIFTC2.csv", sep=",",quote=F,row.names=F)

