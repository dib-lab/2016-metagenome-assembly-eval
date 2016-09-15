#!/bin/bash

for i in *.pe.qc.fq.gz.se
do
    echo working on SE file $i
    otherfile="$(basename $i .pe.qc.fq.gz.se).se.qc.fq.gz"
    gunzip -c $otherfile > combine
    cat $i >> combine
    rm -f $otherfile
    gzip -c combine > $otherfile
    rm $i combine
done

