#!/bin/bash
#SBATCH --job-name=final_platypus    ## Name of the job.
#SBATCH -A ecoevo283       ## account to charge
#SBATCH -p standard        ## partition/queue name
#SBATCH --cpus-per-task=1  ## number of cores the job needs
#SBATCH --mail-type=fail,end
#SBATCH --mail-user=llai7@uci.edu
#SBATCH --array=1-4
#SBATCH --output=./out/Array.%A.%a.out
#SBATCH --error=./err/Array.%A.%a.error


file='prefixes.txt'
prefix=$(head -n $SLURM_ARRAY_TASK_ID  $file | tail -n 1)
outputpath="/share/crsp/lab/satwood/llai7/EE283_spring2023/Final_project/Platypus_output/"
inputpath="/share/crsp/lab/satwood/llai7/EE283_spring2023/Week_5/read_groups_added/"
ref="/share/crsp/lab/satwood/llai7/EE283_spring2023/Week_3/ref/dmel-all-chromosome-r6.13.fasta"

module load samtools/1.15.1  
bgzip -c $outputpath/${prefix}.VariantCalls.vcf > $outputpath/${prefix}.vcf.gz
tabix -p vcf -S 1 -s 2 -b 3 -e 0 $outputpath/${prefix}.vcf.gz

