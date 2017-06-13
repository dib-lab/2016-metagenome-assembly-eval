#! /bin/bash
# produces ${REFERENCE}.cov.txt, ${REFERENCE}.[ps]e.mapped.fa.gz
set -e
set -x
REFERENCE=$1
REFOUT=$(basename $REFERENCE)
PE_READS=$2
SE_READS=$3

#bwa index ${REFERENCE}
#bwa aln ${REFERENCE} ${PE_READS} > ${REFERENCE}.pe.sai
#bwa aln ${REFERENCE} ${SE_READS} > ${REFERENCE}.se.sai
#bwa samse ${REFERENCE} ${REFERENCE}.pe.sai ${PE_READS} > ${REFERENCE}.pe.sam
#bwa samse ${REFERENCE} ${REFERENCE}.se.sai ${SE_READS} > ${REFERENCE}.se.sam

#cat ${REFERENCE}.pe.sam ${REFERENCE}.se.sam > ${REFERENCE}.cov.sam

./get-mapped.sh ${REFERENCE}.pe.sam | gzip > ${REFOUT}.pe.mapped.fa.gz
./get-mapped.sh ${REFERENCE}.se.sam | gzip > ${REFOUT}.se.mapped.fa.gz

./coverage-profile.py ${REFERENCE} ${REFERENCE}.cov.sam ${REFOUT}.cov.txt

rm ${REFERENCE}.pe.sam ${REFERENCE}.se.sam
rm ${REFERENCE}.{amb,ann,bwt,pac,sa,se.sai,pe.sai,cov.sam}
