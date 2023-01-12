#!/bin/bash
#SBATCH --job-name=hw1    ## Name of the job.
#SBATCH -p standard        ## partition/queue name
#SBATCH --cpus-per-task=1  ## number of cores the job needs
#SBATCH --mem=500
#SBATCH --error=error_%A_%a.txt ## error log file name: %A is job id, %a is array task id
#SBATCH --output=out_%A_%a.txt  ## output filename
#SBATCH --nodes=1               ## number of nodes the job will use
#SBATCH --mail-type=fail,end
#SBATCH --mail-user=llai7@uci.edu

wget https://wfitch.bio.uci.edu/~tdlong/problem1.tar.gz
tar -xvf problem1.tar.gz
rm problem1.tar.gz

echo "10th line from file p.txt:"
sed -n '10p' < problem1/p.txt
echo "10th line from file f.txt"
sed -n '10p' < problem1/f.txt

