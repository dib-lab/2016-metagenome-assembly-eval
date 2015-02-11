#!/bin/bash

for i in *.se.qc.fq.gz.keep.abundfilt
 do
     pe_orphans=$(basename $i .se.qc.fq.gz.keep.abundfilt).pe.qc.fq.gz.keep.abundfilt.se
     newfile=$(basename $i .se.qc.fq.gz.keep.abundfilt).se.kak.qc.fq.gz
    cat $i $pe_orphans | gzip -c > $newfile
done
