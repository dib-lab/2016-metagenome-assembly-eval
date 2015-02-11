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
