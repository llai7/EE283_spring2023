#!/bin/bash
#SBATCH --job-name=hw5_calling_snps    ## Name of the job.
#SBATCH -A ecoevo283       ## account to charge
#SBATCH -p standard        ## partition/queue name
#SBATCH --cpus-per-task=2  ## number of cores the job needs
#SBATCH --mail-type=fail,end
#SBATCH --mail-user=llai7@uci.edu
#SBATCH --array=1-7
#SBATCH --output=./out/Array.%A.%a.out
#SBATCH --error=./err/Array.%A.%a.error

module load java/1.8.0
module load gatk/4.2.6.1 

prefix=$(head -n $SLURM_ARRAY_TASK_ID  $genotype_list | tail -n 1)
inputpath="/share/crsp/lab/satwood/llai7/EE283_spring2023/Week_5/read_groups_added"
outputpath="/share/crsp/lab/satwood/llai7/EE283_spring2023/Week_5/calling_SNP"
ref="/share/crsp/lab/satwood/llai7/EE283_spring2023/Week_3/ref/dmel-all-chromosome-r6.13.fasta"

mychr=$(head -n $SLURM_ARRAY_TASK_ID chrome.names.txt | tail -n 1)

/opt/apps/gatk/4.1.9.0/gatk --java-options "-Xmx3g" GenotypeGVCFs \
	-R $ref -V $inputpath/allsample.g.vcf.gz --intervals $mychr \
	-stand-call-conf 5 -O $outputpath/result.${mychr}.vcf.gz

