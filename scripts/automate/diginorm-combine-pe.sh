#!/bin/bash

for i in *.abundfilt.pe
do
    newfile=$(basename $i .pe.qc.fq.gz.keep.abundfilt.pe)
    echo newfile is $newfile
    gzip -c $i > $newfile.pe.kak.qc.fq.gz
done
