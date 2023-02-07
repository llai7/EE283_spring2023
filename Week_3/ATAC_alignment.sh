#!/bin/bash
#SBATCH --job-name=hw3_ATACseq    ## Name of the job.
#SBATCH -A ecoevo283       ## account to charge
#SBATCH -p standard        ## partition/queue name
#SBATCH --cpus-per-task=2  ## number of cores the job needs
#SBATCH --mail-type=fail,end
#SBATCH --mail-user=llai7@uci.edu
#SBATCH --array=1-12
#SBATCH --output=./out/Array.%A_%a.out
#SBATCH --error=./err/Array.%A_%a.error

module load picard-tools/2.27.1
module load bwa/0.7.8
module load samtools/1.15.1

file="ATAC_prefixes.txt"
prefix=$(head -n $SLURM_ARRAY_TASK_ID  $file | tail -n 1)
ref="ref/dmel-all-chromosome-r6.13.fasta"

echo "${prefix}"

pathToOutput="/share/crsp/lab/satwood/llai7/EE283_spring2023/Week_3/ATAC_output"

#echo "$pathToOutput/${prefix}"

outputbam=$(basename $prefix)
echo "$pathToOutput/${outputbam}.bam"

bwa mem -t 2 -M $ref ${prefix}_R1.fq.gz ${prefix}_R2.fq.gz | samtools view -bS - > $pathToOutput/${outputbam}.bam

samtools sort $pathToOutput/${outputbam}.bam -o $pathToOutput/${outputbam}.sort.bam

rm $pathToOutput/${outputbam}.bam
echo "End"

