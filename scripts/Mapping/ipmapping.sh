#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=100GB
#PBS -N IPMapping

module load samtools 
module load bwa
module load pysam 


cd /mnt/home/mahmoud4/Metagenome-Protocol/Mapping/

bwa index idba-partition-assembly.fa

bwa aln idba-partition-assembly.fa SRR606249.pe.qc.fq.gz   > /mnt/research/ged/sherine/Mapping/ip.pe.sai
bwa aln idba-partition-assembly.fa SRR606249.se.qc.fq.gz   > /mnt/research/ged/sherine/Mapping/ip.se.sai

bwa samse idba-partition-assembly.fa  /mnt/research/ged/sherine/Mapping/ip.pe.sai  SRR606249.pe.qc.fq.gz > /mnt/research/ged/sherine/Mapping/ip.pe.sam
bwa samse idba-partition-assembly.fa  /mnt/research/ged/sherine/Mapping/ip.se.sai  SRR606249.se.qc.fq.gz > /mnt/research/ged/sherine/Mapping/ip.se.sam

samtools faidx idba-partition-assembly.fa

samtools import idba-partition-assembly.fa.fai /mnt/research/ged/sherine/Mapping/ip.pe.sam /mnt/research/ged/sherine/Mapping/ip.pe.bam
samtools import idba-partition-assembly.fa.fai /mnt/research/ged/sherine/Mapping/ip.se.sam /mnt/research/ged/sherine/Mapping/ip.se.bam


python extract-unaligned.py -o ip.pe.unaligned --format fasta /mnt/research/ged/sherine/Mapping/ip.pe.bam
python extract-unaligned.py -o ip.se.unaligned --format fasta /mnt/research/ged/sherine/Mapping/ip.se.bam 
