#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=100GB
#PBS -N MPMapping

module load samtools 
module load bwa
module load pysam 

cd /mnt/home/mahmoud4/Metagenome-Protocol/Mapping/

bwa index megahit-partition-assembly.fa

bwa aln megahit-partition-assembly.fa SRR606249.pe.qc.fq.gz   > /mnt/research/ged/sherine/Mapping/mp.pe.sai
bwa aln megahit-partition-assembly.fa SRR606249.se.qc.fq.gz   > /mnt/research/ged/sherine/Mapping/mp.se.sai

bwa samse megahit-partition-assembly.fa  /mnt/research/ged/sherine/Mapping/mp.pe.sai  SRR606249.pe.qc.fq.gz > /mnt/research/ged/sherine/Mapping/mp.pe.sam
bwa samse megahit-partition-assembly.fa  /mnt/research/ged/sherine/Mapping/mp.se.sai  SRR606249.se.qc.fq.gz > /mnt/research/ged/sherine/Mapping/mp.se.sam

samtools faidx megahit-partition-assembly.fa

samtools import megahit-partition-assembly.fa.fai /mnt/research/ged/sherine/Mapping/mp.pe.sam /mnt/research/ged/sherine/Mapping/mp.pe.bam
samtools import megahit-partition-assembly.fa.fai /mnt/research/ged/sherine/Mapping/mp.se.sam /mnt/research/ged/sherine/Mapping/mp.se.bam


python extract-unaligned.py -o mp.pe.unaligned --format fasta /mnt/research/ged/sherine/Mapping/mp.pe.bam
python extract-unaligned.py -o mp.se.unaligned --format fasta /mnt/research/ged/sherine/Mapping/mp.se.bam
