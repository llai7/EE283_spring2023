library(DESeq2)
library( "gplots" )
library( "RColorBrewer" )
library( "genefilter" )
library(EnhancedVolcano)

sampleInfo$FullSampleName = as.character(shortRNAseq$FullSampleName)

countdata = read.table("fly_counts.txt", header=TRUE, row.names=1)
# Remove first five columns (chr, start, end, strand, length)
# or do it the tidy way
countdata = countdata[ ,6:ncol(countdata)]

# Remove crap from colnames in countdata
temp = colnames(countdata)
temp = gsub(".*.RNA_output.","",temp)
temp = gsub(".sort","",temp)
temp = sub("^[^_]*_", "", temp)
temp <- sub("*_.*$", "", temp)

colnames(countdata) = temp

##  does everything match up...
cbind(temp,shortRNAseq$i7index,temp == shortRNAseq$i7index)

# create DEseq2 object & run DEseq
dds = DESeqDataSetFromMatrix(countDat