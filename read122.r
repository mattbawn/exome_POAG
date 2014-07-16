
data122 <- read.table("SeattleSeqAnnotation137.PG122.txt", sep = "\t", header=F)
data180 <- read.table("SeattleSeqAnnotation137.PG180.txt", sep = "\t", header=F)
data288 <- read.table("SeattleSeqAnnotation137.PG288.txt", sep = "\t", header=F)

a <- data122[3]
b <- data180[3]
c <- data288[3]

gene122 <- data122[12]
gene180 <- data180[12]
gene288 <- data288[12]

d <- intersect(data122[,3],data180[,3])
diff <- setdiff(d,c[,])

newdata122 <- subset(data122, data122[,3] %in% diff,)
possgenes <- subset(newdata122, newdata122[,8] == "missense",)
numuni <- unique(num)
write.table(possgenes,file = "genes.csv", sep=",")