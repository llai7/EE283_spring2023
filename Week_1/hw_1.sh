#!/bin/bash
#SBATCH --job-name=test    ## Name of the job.
#SBATCH -A ecoevo283       ## account to charge
#SBATCH -p standard        ## partition/queue name
#SBATCH --cpus-per-task=1  ## number of cores the job needs
#SBATCH -array=1-12        ## discussed more below


