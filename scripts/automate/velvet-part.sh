#!/bin/bash 

for i in *kak*.pe.fq.gz;
do
    name=$(basename $i .pe.fq.gz);
    pefile=$name.pe.fq.gz
    sefile=$name.se.fq.gz;
    for k in {19..51..2};
    do
        echo "velveth $name.velvet.$k.d $k -fastq.gz -shortPaired $pefile -short $sefile && \
        velvetg $name.velvet.$k.d -exp_cov auto -cov_cutoff auto"
    done
done >>velvet-part.sh
velveth kak.group0000.velvet.19.d 19 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.19.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.21.d 21 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.21.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.23.d 23 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.23.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.25.d 25 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.25.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.27.d 27 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.27.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.29.d 29 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.29.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.31.d 31 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.31.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.33.d 33 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.33.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.35.d 35 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.35.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.37.d 37 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.37.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.39.d 39 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.39.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.41.d 41 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.41.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.43.d 43 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.43.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.45.d 45 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.45.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.47.d 47 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.47.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.49.d 49 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.49.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.51.d 51 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.51.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.19.d 19 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.19.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.21.d 21 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.21.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.23.d 23 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.23.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.25.d 25 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.25.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.27.d 27 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.27.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.29.d 29 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.29.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.31.d 31 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.31.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.33.d 33 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.33.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.35.d 35 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.35.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.37.d 37 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.37.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.39.d 39 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.39.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.41.d 41 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.41.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.43.d 43 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.43.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.45.d 45 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.45.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.47.d 47 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.47.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.49.d 49 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.49.d -exp_cov auto -cov_cutoff auto
velveth kak.group0000.velvet.51.d 51 -fastq.gz -shortPaired kak.group0000.pe.fq.gz -short kak.group0000.se.fq.gz &&         velvetg kak.group0000.velvet.51.d -exp_cov auto -cov_cutoff auto
