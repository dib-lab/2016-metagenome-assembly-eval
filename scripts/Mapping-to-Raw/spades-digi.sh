#!/bin/bash

module load bowtie2
bowtie2 -p 4 -x /mnt/home/mahmoud4/paired-mapping/spades/spades-digi /mnt/home/mahmoud4/paired-mapping/SRR606249.pe.qc.fastq -S /mnt/scratch/tg/mahmoud4/paired-mapping/spades/spades-digi.sam-1
bowtie2 -p 4 -x /mnt/home/mahmoud4/paired-mapping/spades/spades-digi /mnt/home/mahmoud4/paired-mapping/SRR606249.se.qc.fastq -S /mnt/scratch/tg/mahmoud4/paired-mapping/spades/spades-digi.sam-2
gzip -c /mnt/scratch/tg/mahmoud4/paired-mapping/spades/spades-digi.sam-1 /mnt/scratch/tg/mahmoud4/paired-mapping/spades/spades-digi.sam-2 > /mnt/scratch/tg/mahmoud4/paired-mapping/spades/spades-digi.sam

