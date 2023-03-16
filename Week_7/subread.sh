#!/bin/bash
#SBATCH --job-name=hw7_subread    ## Name of the job.
#SBATCH -A ecoevo283       ## account to charge
#SBATCH -p standard        ## partition/queue name
#SBATCH --cpus-per-task=8  ## number of cores the job needs
#SBATCH --mail-type=fail,end
#SBATCH --mail-user=llai7@uci.edu
#SBATCH -o ./out/%j.out
#SBATCH -e ./err/%j.err

module load subread/2.0.3

gtf="/share/crsp/lab/satwood/llai7/EE283_spring2023/Week_3/ref/dmel-all-r6.13.gtf"

myfile=`cat shortRNAseq.names.txt | tr "\n" " "`
featureCounts -p -T 8 -t exon -g gene_id -Q 30 -F GTF -a $gtf -o fly_counts.txt $myfile

