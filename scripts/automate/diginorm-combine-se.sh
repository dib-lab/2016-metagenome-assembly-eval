#!/bin/bash

for se in *.se.qc.fq.gz.keep.abundfilt.keep 
	do 
	newfile=${se/.se.qc.fq.gz.keep.abundfilt.keep/.se.kak.qc.fq.gz}
	gzip -c  $se >$newfile
done
