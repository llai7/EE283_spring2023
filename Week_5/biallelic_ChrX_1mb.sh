#!/bin/bash
#SBATCH --job-name=hw5_biallelic_1mb    ## Name of the job.
#SBATCH -A ecoevo283       ## account to charge
#SBATCH -p standard        ## partition/queue name
#SBATCH --cpus-per-task=1  ## number of cores the job needs
#SBATCH --mail-type=fail,end
#SBATCH --mail-user=llai7@uci.edu
#SBATCH --output=./out/%J.out
#SBATCH --error=./err/%J.error

module load java/1.8.0
module load  bcftools/1.15.1

outputpath="/share/crsp/lab/satwood/llai7/EE283_spring2023/Week_5/filtered_results"

bcftools index $outputpath/output3.vcf.gz
bcftools view -r X:1-1000000 -m2 -M2 -v snps -o $outputpath/biallelic_X_1mb.vcf.gz $outputpath/output3.vcf.gz

