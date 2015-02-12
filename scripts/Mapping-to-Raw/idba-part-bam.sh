#!/bin/bash

module load samtools
cd /mnt/home/mahmoud4/paired-mapping/
~/samtools-1.1/samtools import idba-partition-assembly.fa.fai /mnt/scratch/tg/mahmoud4/paired-mapping/idba/idba-part.sam /mnt/scratch/tg/mahmoud4/paired-mapping/idba/idba-part.bam
