#!/bin/bash

module load samtools
~/samtools-1.1/samtools import velvet-partition-assembly.fa.fai /mnt/scratch/tg/mahmoud4/paired-mapping/velvet/velvet-part.sam /mnt/scratch/tg/mahmoud4/paired-mapping/velvet/velvet-part.bam
