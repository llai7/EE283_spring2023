#!/bin/bash
#SBATCH --job-name=hw5_addreadgrps    ## Name of the job.
#SBATCH -A ecoevo283       ## account to charge
#SBATCH -p standard        ## partition/queue name
#SBATCH --cpus-per-task=2  ## number of cores the job needs
#SBATCH --mail-type=fail,end
#SBATCH --mail-user=llai7@uci.edu
#SBATCH --array=1-4
#SBATCH --output=./out/Array.%A.%a.out
#SBATCH --error=./err/Array.%A.%a.error

module load java/1.8.0
module load gatk/4.2.6.1 
module load picard-tools/2.27.1  
module load samtools/1.15.1

genotype_list="/share/crsp/lab/satwood/llai7/EE283_spring2023/Week_3/DNA_genotypes.txt"
prefix=$(head -n $SLURM_ARRAY_TASK_ID  $genotype_list | tail -n 1)
outputpath="/share/crsp/lab/satwood/llai7/EE283_spring2023/Week_5/read_groups_added"
inputpath="/share/crsp/lab/satwood/llai7/EE283_spring2023/Week_3/DNA_output"
ref="/share/crsp/lab/satwood/llai7/EE283_spring2023/Week_3/ref/dmel-all-chromosome-r6.13.fasta"

# you want to add paths to output files so they are not in your root directory
# hint: $(printf '%s ' ${prefix}*.sort.bam)
samtools merge -o $outputpath/${prefix}.bam $inputpath/${prefix}_1.sort.bam $inputpath/${prefix}_2.sort.bam $inputpath/${prefix}_3.sort.bam
samtools sort $outputpath/$prefix.bam -o $outputpath/$prefix.sort.bam
java -jar /opt/apps/picard-tools/2.27.1/picard.jar AddOrReplaceReadGroups I=$outputpath/$prefix.sort.bam O=$outputpath/$prefix.RG.bam SORT_ORDER=coordinate RGPL=illumina RGPU=D109LACXX RGLB=Lib1 RGID=$prefix RGSM=$prefix VALIDATION_STRINGENCY=LENIENT
java -jar /opt/apps/picard-tools/2.27.1/picard.jar MarkDuplicates REMOVE_DUPLICATES=true I=$outputpath/$prefix.RG.bam O=$outputpath/$prefix.dedup.bam M=$outputpath/${prefix}_marked_dup_metrics.txt
samtools index $outputpath/$prefix.dedup.bam
/opt/apps/gatk/4.2.6.1/gatk HaplotypeCaller -R $ref -I $outputpath/${prefix}.dedup.bam\ --minimum-mapping-quality 30 -ERC GVCF -O $outputpath/${prefix}.g.vcf.gz
