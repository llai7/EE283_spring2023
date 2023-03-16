#!/bin/bash
#SBATCH --job-name=hw7_subsetting    ## Name of the job.
#SBATCH -A ecoevo283       ## account to charge
#SBATCH -p standard        ## partition/queue name
#SBATCH --cpus-per-task=1  ## number of cores the job needs
#SBATCH --mail-type=fail,end
#SBATCH --mail-user=llai7@uci.edu
#SBATCH -o ./out/%j.out
#SBATCH -e ./err/%j.err

module load anaconda/2022.05
eval "$(/opt/apps/anaconda/2022.05/bin/conda 'shell.bash' 'hook')"

conda activate R_envi

Rscript subsetting.R

conda deactivate
