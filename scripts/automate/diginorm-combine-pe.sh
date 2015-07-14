#!/bin/bash

for pe in *.pe.qc.fq.gz.keep.abundfilt.pe.keep
	do 
	se=${pe/pe.keep/se.keep}
	newfile=${pe/.pe.qc.fq.gz.keep.abundfilt.pe.keep/.pe.kak.qc.fq.gz}
	cat $pe $se |gzip -c > $newfile
done
