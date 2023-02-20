#!/bin/bash
#SBATCH --job-name=hw4_fragment    ## Name of the job.
#SBATCH -A ecoevo283       ## account to charge
#SBATCH -p standard        ## partition/queue name
#SBATCH --cpus-per-task=4  ## number of cores the job needs
#SBATCH --mail-type=fail,end
#SBATCH --mail-user=llai7@uci.edu
#SBATCH -o ./out/%j.out
#SBATCH -e ./err/%j.err

module load anaconda/2020.07
eval "$(/opt/apps/anaconda/2020.07/bin/conda 'shell.bash' 'hook')"
#conda init bash
#conda create --name deeptools
#conda install -c bioconda deeptools
conda activate deeptools

outputpath="/share/crsp/lab/satwood/llai7/EE283_spring2023/Week_4/deeptools_per_bp_output"

plotCoverage -v -b ./A4_A5_output/extracted.ADL06_1.bam ./A4_A5_output/extracted.ADL06_2.bam ./A4_A5_output/extracted.ADL06_3.bam ./A4_A5_output/extracted.ADL09_1.bam ./A4_A5_output/extracted.ADL09_2.bam ./A4_A5_output/extracted.ADL09_3.bam\
    --plotFile $outputpath/fragment_coverage_plot \
        -n 1000000 \
	--extendReads \
	    --plotTitle "coverage A4 vs A5" \
		        --outRawCounts $outputpath/fragment.coverage.tab \
			    --ignoreDuplicates \
			        --minMappingQuality 30 \
				    --region X:1880000:2000000

conda deactivate
