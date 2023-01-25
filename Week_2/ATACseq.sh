#!/bin/bash
#SBATCH --job-name=hw2    ## Name of the job.
#SBATCH -A ecoevo283       ## account to charge
#SBATCH -p standard        ## partition/queue name
#SBATCH --cpus-per-task=1  ## number of cores the job needs
#SBATCH --mail-type=fail,end
#SBATCH --mail-user=llai7@uci.edu
#SBATCH -o ./out/%j.out
#SBATCH -e ./err/%j.err


SourceDir2="/data/class/ecoevo283/public/RAWDATA/ATACseq/"
#remove header and footer and output to a new file
#sed '1d' $SourceDir2/README.ATACseq.txt | head -n -4 > ATACseq.labels.txt

DestDir2="./ATACseq/"

File="ATACseq.labels.txt"
while read p
do
	   echo "${p}"
	      barcode=$(echo $p | cut -f1 -d" ")
	         genotype=$(echo $p | cut -f2 -d" ")
		    tissue=$(echo $p | cut -f3 -d" ")
		       bioRep=$(echo $p | cut -f4 -d" ")

		           READ1=$(find ${SourceDir2}/ -type f -iname "*_${barcode}_R1.fq.gz")
			   READ2=$(find ${SourceDir2}/ -type f -iname "*_${barcode}_R2.fq.gz")

			   variable_name=$(echo "${barcode}_${genotype}_${tissue}_${bioRep}_R1")
			   variable_name2=$(echo "${barcode}_${genotype}_${tissue}_${bioRep}_R2")



			   ln -s $READ1 $DestDir2/$variable_name
			   ln -s $READ2 $DestDir2/$variable_name2


			  done < $File
