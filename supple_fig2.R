
infile <- read.table('annotation_LINE.txt')

LINEfactor <- as.factor(infile$V1)


sorted <-sort(table(LINEfactor), decreasing=T)

barplot(sorted[1:10], ylim=c(0,10000))