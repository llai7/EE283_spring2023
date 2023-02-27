#!/bin/bash
#SBATCH --job-name=hw5_calling_snps    ## Name of the job.
#SBATCH -A ecoevo283       ## account to charge
#SBATCH -p standard        ## partition/queue name
#SBATCH --cpus-per-task=1  ## number of cores the job needs
#SBATCH --mail-type=fail,end
#SBATCH --mail-user=llai7@uci.edu
#SBATCH --output=./out/%J.out
#SBATCH --error=./err/%J.error

module load java/1.8.0
module load  bcftools/1.15.1

inputpath="/share/crsp/lab/satwood/llai7/EE283_spring2023/Week_5/calling_SNP"
outputpath="/share/crsp/lab/satwood/llai7/EE283_spring2023/Week_5/filtered_results"
ref="/share/crsp/lab/satwood/llai7/EE283_spring2023/Week_3/ref/dmel-all-chromosome-r6.13.fasta"

bcftools filter -i 'FS<40.0 && SOR<3 && MQ>40.0 && MQRankSum>-5.0 && MQRankSum<5 && QD>2.0 && ReadPosRankSum>-4.0 && INFO/DP<16000' -O z -o $outputpath/output1.vcf.gz $inputpath/all_variants.vcf.gz
bcftools view --no-header -G -m 2 -M 2 --types snps $outputpath/output1.vcf.gz | wc -l

bcftools filter -S . -e 'FMT/DP<3 | FMT/GQ<20' -O z -o $outputpath/output2.vcf.gz $outputpath/output1.vcf.gz
bcftools view --no-header -G -m 2 -M 2 --types snps $outputpath/output2.vcf.gz | wc -l

bcftools filter -e 'AC==0 || AC==AN' --SnpGap 10 $outputpath/output2.vcf.gz | \
bcftools view -m2 -M2 -v snps -O z -o $outputpath/output3.vcf.gz
bcftools view --no-header -G -m 2 -M 2 --types snps $outputpath/output3.vcf.gz | wc -l
