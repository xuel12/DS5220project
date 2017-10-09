library(xlsx)
library(tidyverse)
library(reshape2)

############## meta info ###############
prefix <- getwd()
inputdir <- "./input/"
if (!dir.exists(inputdir)) {dir.create(inputdir)}
intermediatedir <- "./rda/"
if (!dir.exists(intermediatedir)) {dir.create(intermediatedir)}
outputdir <- "./result/"
if (!dir.exists(outputdir)) {dir.create(outputdir)}

filename <- "FragSummary_201709040616.xls"

tmp <- (readLines(paste0("./input/", filename)))
tmp <- strsplit(tmp, split = "\t")
df <- do.call(rbind.data.frame, tmp)

frag.table <- data.frame(matrix(unlist(frag.table), nrow=length(frag.table), byrow=T),stringsAsFactors=FALSE)
colnames(frag.table) <- frag.table[1,]
frag.table <- frag.table[-1,]
save(frag.table, file=paste0(intermediatedir, "frag.table.rda"))

frag.table[,5:113] <- apply(frag.table[,5:113], 2, as.numeric)
boxplot(frag.table[,6])

tmp <- frag.table[which(frag.table$nselevse_L120412_009_SW_Spec_Centric_Prob==-1),]
tmp1 <- frag.table[which(frag.table$nselevse_L120412_009_SW_Pep_Centric_Prob==-1),]
