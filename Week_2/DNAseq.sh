#!/bin/bash
#SBATCH --job-name=hw2    ## Name of the job.
#SBATCH -A ecoevo283       ## account to charge
#SBATCH -p standard        ## partition/queue name
#SBATCH --cpus-per-task=1  ## number of cores the job needs
#SBATCH --mail-type=fail,end
#SBATCH --mail-user=llai7@uci.edu
#SBATCH -o ./out/%j.out
#SBATCH -e ./err/%j.err

##DNAseq
SourceDir="/data/class/ecoevo283/public/RAWDATA/DNAseq/"
DestDir="./DNAseq/"
FILES=$(basename -a $SourceDir/*)
for f in $FILES
do
	echo "Processing $f file..."
	ln -s $SourceDir/$f $DestDir/$f
done


