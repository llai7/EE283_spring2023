#!/bin/bash
#SBATCH --job-name=final_mpileup    ## Name of the job.
#SBATCH -A ecoevo283       ## account to charge
#SBATCH -p standard        ## partition/queue name
#SBATCH --cpus-per-task=1  ## number of cores the job needs
#SBATCH --mem=6G
#SBATCH --mail-type=fail,end
#SBATCH --mail-user=llai7@uci.edu
#SBATCH --output=./out/%J.out
#SBATCH --error=./err/%J.error

module load samtools/1.15.1
module load  bcftools/1.15.1

outputpath="/share/crsp/lab/satwood/llai7/EE283_spring2023/Final_project/mpileup_output/"
inputpath="/share/crsp/lab/satwood/llai7/EE283_spring2023/Week_5/read_groups_added/"
ref="/share/crsp/lab/satwood/llai7/EE283_spring2023/Week_3/ref/dmel-all-chromosome-r6.13.fasta"

samtools mpileup -f $ref $inputpath/ADL06.dedup.bam $inputpath/ADL09.dedup.bam $inputpath/ADL10.dedup.bam $inputpath/ADL14.dedup.bam -r X:1-10000000 > $outputpath/subset.raw.bcf
bcftools view -vcg $outputpath/subset.raw.bcf | vcfutils.pl varFilter - > $outputpath/my-var.vcf

