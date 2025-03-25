#!/bin/bash

#===================#
#  Pipeline script  #
#  From fastq QC to sorting and remove duplicate #
#===================#

# Usage:
# bash ChIP_preprocess.sh <sample_name> <fastq>

#--------#
# Inputs #
#--------#
sample=$1
fastq=$2

#--------#
# Params #
#--------#
threads=8
genome_index="/home/wz1424/fly_embryo_multiome/raw_data/ChIP_data/reference_data/dm6_index"

#--------#
# Step 1: fastp quality control #
#--------#
echo "[Step 1] fastp quality control started..."

fastp -i ${fastq} \
      -o ${sample}.clean.fastq \
      -h ${sample}_fastp.html \
      -j ${sample}_fastp.json

echo "[Step 1] fastp quality control done!"

#--------#
# Step 2: Alignment with bowtie2 #
#--------#
echo "[Step 2] Bowtie2 alignment started..."

bowtie2 -p 4 -q --local \
	-x ${genome_index} -U ${sample}.clean.fastq -p ${threads} | \
    samtools view -Sb - > ${sample}.bam

echo "[Step 2] Alignment completed!"

#--------#
# Step 3: Sort and remove duplicates #
#--------#
echo "[Step 3] Sorting and duplicate removal started..."

# Sort BAM files
samtools sort -@ ${threads} -o ${sample}.sorted.bam ${sample}.bam

# Remove duplicates
samtools rmdup ${sample}.sorted.bam ${sample}.sorted.dedup.bam

# Index final BAM files
samtools index ${sample}.sorted.dedup.bam

echo "[Step 3] Sorting and duplicate removal completed!"

echo "Pipeline completed successfully!"

