#!/bin/bash

for i in *.pe.qc.fq.gz.pe
do
    echo working on PE file $i
    newfile="$(basename $i .pe.qc.fq.gz.pe).pe.qc.fq"
    rm $(basename $i .pe)
    mv $i $newfile
    gzip $newfile
done
