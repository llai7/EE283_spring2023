library(tidyverse)
mytab = read_tsv("RNAseq.samcode.txt")

temp <- mytab[,c("RILcode","TissueCode","Replicate","FullSampleName","SampleNumber","Lane","i7index")]
temp1 <- temp[which(temp$RILcode %in% c(21148, 21286, 22162, 21297, 21029, 22052, 22031, 21293, 22378, 22390)),]
temp2 <- temp1[which(temp1$TissueCode %in% c("B", "E")),]
temp3 <- temp2[temp2$Replicate == 0,]

for(i in 1:nrow(temp3)){
	  cat("/share/crsp/lab/satwood/llai7/EE283_spring2023/Week_3/RNA_output/",temp3$SampleNumber[i],"_",temp3$i7index[i],"_",temp3$Lane[i],".sort.bam\n",file="shortRNAseq.names.txt",append=TRUE,sep='')
	}
write_tsv(temp3,"shortRNAseq.txt")
