#!/bin/bash
#SBATCH --job-name=hisat2_RNAseq_alignment    ## Name of the job.
#SBATCH -A ecoevo283       ## account to charge
#SBATCH -p standard        ## partition/queue name
#SBATCH --cpus-per-task=8  ## number of cores the job needs
#SBATCH --mail-type=fail,end
#SBATCH --mail-user=llai7@uci.edu
#SBATCH --output=./out/%j.out
#SBATCH --error=./err/%j.error

module load python/3.10.2
module load picard-tools/2.27.1
module load hisat2/2.2.1

ref="ref/dmel-all-chromosome-r6.13.fasta"
gtf="ref/dmel-all-r6.13.gtf"
python /opt/apps/hisat2/2.2.1/bin/hisat2_extract_splice_sites.py $gtf > /share/crsp/lab/satwood/llai7/EE283_spring2023/Week_3/ref/dm6.ss
python /opt/apps/hisat2/2.2.1/bin/hisat2_extract_exons.py $gtf > /share/crsp/lab/satwood/llai7/EE283_spring2023/Week_3/ref/dm6.exon
hisat2-build -p 8 --exon /share/crsp/lab/satwood/llai7/EE283_spring2023/Week_3/ref/dm6.exon --ss /share/crsp/lab/satwood/llai7/EE283_spring2023/Week_3/ref/dm6.ss $ref /share/crsp/lab/satwood/llai7/EE283_spring2023/Week_3/ref/dm6_trans

