#!/bin/bash
#SBATCH --job-name=final_freebayes    ## Name of the job.
#SBATCH -A ecoevo283       ## account to charge
#SBATCH -p standard        ## partition/queue name
#SBATCH --cpus-per-task=1  ## number of cores the job needs
#SBATCH --mail-type=fail,end
#SBATCH --mail-user=llai7@uci.edu
#SBATCH --array=1-4
#SBATCH --output=./out/Array.%A.%a.out
#SBATCH --error=./err/Array.%A.%a.error

module load anaconda/2020.07
eval "$(/opt/apps/anaconda/2020.07/bin/conda 'shell.bash' 'hook')"
conda activate free_bayes

file='prefixes.txt'
prefix=$(head -n $SLURM_ARRAY_TASK_ID  $file | tail -n 1)
outputpath="/share/crsp/lab/satwood/llai7/EE283_spring2023/Final_project/freeBayes_output/"
inputpath="/share/crsp/lab/satwood/llai7/EE283_spring2023/Week_5/read_groups_added/"
ref="/share/crsp/lab/satwood/llai7/EE283_spring2023/Week_3/ref/dmel-all-chromosome-r6.13.fasta"


freebayes -f $ref $inputpath/${prefix}.dedup.bam -r X:1-10000000 > $outputpath/${prefix}.var.vcf

conda deactivate
