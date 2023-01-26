#!/bin/bash
#SBATCH --job-name=hw2    ## Name of the job.
#SBATCH -A ecoevo283       ## account to charge
#SBATCH -p standard        ## partition/queue name
#SBATCH --cpus-per-task=1  ## number of cores the job needs
#SBATCH --mail-type=fail,end
#SBATCH --mail-user=llai7@uci.edu
#SBATCH -o ./out/%j.out
#SBATCH -e ./err/%j.err


SourceDir="/data/class/ecoevo283/public/RAWDATA/RNAseq/RNAseq384plex_flowcell01/"
#remove header and footer and output to a new file
#sed '1d' $SourceDir/RNAseq384_SampleCoding.txt > RNAseq.txt

DestDir="./RNAseq"

File="RNAseq.txt"
while read p
do
	   echo "${p}"
	      i7barcode=$(echo $p | cut -f4 -d" ")
	        i5barcode=$(echo $p | cut -f2 -d" ")
		    lane=$(echo $p | cut -f3 -d" ")
		       sample=$(echo $p | cut -f1 -d" ")

		           READ1=$(find ${SourceDir}/ -type f -iname "${sample}_${i7barcode}_${lane}_R1_001.fastq.gz")
			   READ2=$(find ${SourceDir}/ -type f -iname "${sample}_${i7barcode}_${lane}_R2_001.fastq.gz")

			   variable_name=$(echo "${sample}_${i7barcode}_${lane}_R1")
			   variable_name2=$(echo "${sample}_${i7barcode}_${lane}_R2")



			   ln -s $READ1 $DestDir/${variable_name}.fq.gz
			   ln -s $READ2 $DestDir/${variable_name2}.fq.gz


			  done < $File
