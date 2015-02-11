#!/bin/bash

for i in *.pe.qc.fq.gz
do
    name=$(basename $i .pe.qc.fq.gz);
    pefile=$name.pe.qc.fq.gz
    sefile=$name.se.qc.fq.gz;
    for k in {19..51..2};
    do
        velveth $name.velvet.$k.d $k -fastq.gz -shortPaired $pefile -short $sefile && \
        velvetg $name.velvet.$k.d -exp_cov auto -cov_cutoff auto
    done
done >> velvet-quality-assembly.sh
