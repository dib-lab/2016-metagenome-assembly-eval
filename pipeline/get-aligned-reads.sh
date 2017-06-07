#! /bin/bash
# produces ${REFERENCE}.cov.txt, ${REFERENCE}.[ps]e.mapped.fa.gz
set -e
set -x
REFERENCE=$1
PE_READS=$2
SE_READS=$3

bwa index ${REFERENCE}
bwa aln ${REFERENCE} ${PE_READS} > ${REFERENCE}.pe.sai
bwa aln ${REFERENCE} ${SE_READS} > ${REFERENCE}.se.sai
bwa samse ${REFERENCE} ${REFERENCE}.pe.sai ${PE_READS} > ${REFERENCE}.pe.sam
bwa samse ${REFERENCE} ${REFERENCE}.se.sai ${SE_READS} > ${REFERENCE}.se.sam

cat ${REFERENCE}.pe.sam ${REFERENCE}.se.sam > ${REFERENCE}.cov.sam
./coverage-profile.py ${REFERENCE} ${REFERENCE}.cov.sam ${REFERENCE}.cov.txt

./get-mapped.sh ${REFERENCE}.pe.sam | gzip > ${REFERENCE}.pe.mapped.fa.gz
./get-mapped.sh ${REFERENCE}.se.sam | gzip > ${REFERENCE}.se.mapped.fa.gz

rm ${REFERENCE}.pe.sam ${REFERENCE}.se.sam
rm ${REFERENCE}.{amb,ann,bwt,pac,sa,se.sai,pe.sai,cov.sam}
