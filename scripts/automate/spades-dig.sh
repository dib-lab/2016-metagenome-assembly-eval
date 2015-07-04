#!/bin/bash

for i in *.pe.kak.qc.fq.gz
do
   gunzip -c $i > $(basename $i .gz)
done
