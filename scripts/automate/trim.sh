java -jar /usr/local/bin/trimmomatic-0.30.jar PE R1.fastq.gz R2.fastq.gz s1_pe s1_se s2_pe s2_se ILLUMINACLIP:/usr/local/share/adapters/TruSeq3-PE.fa:2:30:10
/usr/local/share/khmer/scripts/interleave-reads.py s1_pe s2_pe | gzip -9c > R1.pe.fq.gz

cat s1_se s2_se | gzip -9c > R1.se.fq.gz

chmod u-w R1.pe.fq.gz R1.se.fq.gz

