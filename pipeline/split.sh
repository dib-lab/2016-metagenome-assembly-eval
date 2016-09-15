#!/bin/bash
for i in *kak*.sweep
do
    sweep=$(basename $i .fq)
    mv $i $sweep.fq
    /usr/local/share/khmer/scripts/extract-paired-reads.py ${sweep}.fq
    mv $sweep.fq.pe  ${sweep}.nodn.pe.fq
    mv $sweep.fq.se  ${sweep}.nodn.se.fq
done

