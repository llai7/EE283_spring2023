#!/bin/bash
#SBATCH --job-name=hw5_vcf_012    ## Name of the job.
#SBATCH -A ecoevo283       ## account to charge
#SBATCH -p standard        ## partition/queue name
#SBATCH --cpus-per-task=1  ## number of cores the job needs
#SBATCH --mail-type=fail,end
#SBATCH --mail-user=llai7@uci.edu
#SBATCH --output=./out/%J.out
#SBATCH --error=./err/%J.error

module load java/1.8.0
module load vcftools/0.1.16

outputpath="/share/crsp/lab/satwood/llai7/EE283_spring2023/Week_5/filtered_results"

vcftools --gzvcf $outputpath/biallelic_X_1mb.vcf.gz --012 --out biallelic_X_1mb_analysis
