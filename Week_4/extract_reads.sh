#!/bin/bash
#SBATCH --job-name=hw4    ## Name of the job.
#SBATCH -A ecoevo283       ## account to charge
#SBATCH -p standard        ## partition/queue name
#SBATCH --cpus-per-task=1  ## number of cores the job needs
#SBATCH --mail-type=fail,end
#SBATCH --mail-user=llai7@uci.edu
#SBATCH --array=1-6
#SBATCH --output=./out/Array.%A_%a.out
#SBATCH --error=./err/Array.%A_%a.error

module load samtools/1.15.1

file="/share/crsp/lab/satwood/llai7/EE283_spring2023/Week_3/DNA_A4_A5_prefixes.txt"
inputpath="/share/crsp/lab/satwood/llai7/EE283_spring2023/Week_3/DNA_output"
prefix=$(head -n $SLURM_ARRAY_TASK_ID  $file | tail -n 1)
outputpath="/share/crsp/lab/satwood/llai7/EE283_spring2023/Week_4/A4_A5_output"

samtools index $inputpath/$prefix.sort.bam > $inputpath/$prefix.index.sort.bai
samtools view -q 30 -b $inputpath/$prefix.sort.bam "X:1880000-2000000" > $outputpath/extracted.$prefix.bam


