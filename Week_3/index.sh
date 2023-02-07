#!/bin/bash
#SBATCH --job-name=hw1    ## Name of the job.
#SBATCH -A ecoevo283       ## account to charge
#SBATCH -p standard        ## partition/queue name
#SBATCH --cpus-per-task=2  ## number of cores the job needs
#SBATCH --mail-type=fail,end
#SBATCH --mail-user=llai7@uci.edu

module load picard-tools/2.27.1
module load bwa/0.7.8 
module load samtools/1.15.1

ref="ref/dmel-all-chromosome-r6.13.fasta"
bwa index $ref
samtools faidx $ref
java -jar /opt/apps/picard-tools/2.27.1/picard.jar CreateSequenceDictionary R=$ref O=index/dmel-all-chromosome-r6.13.dict

