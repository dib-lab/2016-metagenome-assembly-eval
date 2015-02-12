#!/bin/bash

module load samtools
~/samtools-1.1/samtools import velvet-diginorm-assembly.fa.fai /mnt/scratch/tg/mahmoud4/paired-mapping/velvet/velvet-digi.sam /mnt/scratch/tg/mahmoud4/paired-mapping/velvet/velvet-digi.bam
