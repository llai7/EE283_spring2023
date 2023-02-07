#!/bin/bash
#SBATCH --job-name=hisat2_RNAseq_alignment    ## Name of the job.
#SBATCH -A ecoevo283       ## account to charge
#SBATCH -p standard        ## partition/queue name
#SBATCH --cpus-per-task=2  ## number of cores the job needs
#SBATCH --mail-type=fail,end
#SBATCH --mail-user=llai7@uci.edu
#SBATCH --array=1-375
#SBATCH --output=./out/Array.%A_%a.out
#SBATCH --error=./err/Array.%A_%a.error

module load python/3.10.2
module load picard-tools/2.27.1
module load hisat2/2.2.1
module load samtools/1.15.1

ref="ref/dmel-all-chromosome-r6.13.fasta"

file="RNA_prefixes.txt"
prefix=$(head -n $SLURM_ARRAY_TASK_ID  $file | tail -n 1)
outputbam=$(basename $prefix)

pathToOutput="/share/crsp/lab/satwood/llai7/EE283_spring2023/Week_3/RNA_output"

hisat2 -p 2 -x ref/dm6_trans -1 ${prefix}_R1.fq.gz -2 ${prefix}_R2.fq.gz | samtools view -bS - > $pathToOutput/${outputbam}.bam
samtools sort $pathToOutput/${outputbam}.bam -o $pathToOutput/${outputbam}.sort.bam
samtools index $pathToOutput/${outputbam}.sorted.bam
rm $pathToOutput/${outputbam}.bam
