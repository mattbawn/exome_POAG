## Script for comparing shortened VCF files for POAG patients
## Matt Bawn 15/07/14 mattbawn@gmail.com

# Read  data
data122 <- read.table("SeattleSeqAnnotation137.PG122.txt", sep = "\t", header=T)
data180 <- read.table("SeattleSeqAnnotation137.PG180.txt", sep = "\t", header=T)
data288 <- read.table("SeattleSeqAnnotation137.PG288.txt", sep = "\t", header=T)

# Compare patients 122 and 180 for common positions
commonLocations <- intersect(data122$position, data180$position)

# Check the common locations against 288 and remove if found 
reducedLocations <- setdiff(commonLocations, data288$position)

# Subset origional data of 122 and 180 based on reducedLocations
newdata122 <- subset(data122, data122$position %in% reducedLocations,)
newdata180 <- subset(data180, data180$position %in% reducedLocations,)

# Sunset the new data based on "missense" mutations
Missense_122 <- subset(newdata122, newdata122$functionGVS == "missense",)
Missense_180 <- subset(newdata180, newdata180$functionGVS == "missense",)

# Output missense data as .csv file
write.table(Missense_122,file = "122_missense.csv", sep=",")
write.table(Missense_180,file = "180_missense.csv", sep=",")

