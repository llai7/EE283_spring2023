#!/bin/bash
#SBATCH --job-name=final_filtering    ## Name of the job.
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
conda activate vcflib

file='prefixes.txt'
prefix=$(head -n $SLURM_ARRAY_TASK_ID  $file | tail -n 1)

vcffilter -f  "QUAL > 20" ${prefix}.var.vcf  | grep -vc '#'
grep -vc '#' ${prefix}.var.vcf

vcffilter -f "QUAL > 20 & DP > 20" ${prefix}.var.vcf  > ${prefix}.Q20.DP20.vcf
grep -vc '#' ${prefix}.Q20.DP20.vcf

conda deactivate
