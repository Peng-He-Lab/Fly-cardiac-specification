#!/bin/bash

# Opa
samtools merge Opa_early_merged.bam Opa_early_rep1.sorted.dedup.bam Opa_early_rep2.sorted.dedup.bam
samtools sort -@ 8 -o Opa_early_merged.sorted.bam Opa_early_merged.bam
samtools index Opa_early_merged.sorted.bam
macs2 callpeak -t Opa_early_merged.sorted.bam -f BAM -g dm -n Opa_early --outdir macs2 --keep-dup all -q 0.01

# Twi
macs2 callpeak -t Twi_early.sorted.dedup.bam -f BAM -g dm -n Twi_early --outdir macs2 --keep-dup all -q 0.01

# SuH
macs2 callpeak -t SuH_early.sorted.dedup.bam -f BAM -g dm -n SuH_early --outdir macs2 --keep-dup all -q 0.01
