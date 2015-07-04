#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=100GB
#PBS -N MQMapping

module load samtools 
module load bwa
module load pysam 


cd /mnt/home/mahmoud4/Metagenome-Protocol/Mapping/

bwa index megahit-quality-assembly.fa

bwa aln megahit-quality-assembly.fa SRR606249.pe.qc.fq.gz   > /mnt/research/ged/sherine/Mapping/mq.pe.sai
bwa aln megahit-quality-assembly.fa SRR606249.se.qc.fq.gz   > /mnt/research/ged/sherine/Mapping/mq.se.sai

bwa samse megahit-quality-assembly.fa  /mnt/research/ged/sherine/Mapping/mq.pe.sai  SRR606249.pe.qc.fq.gz > /mnt/research/ged/sherine/Mapping/mq.pe.sam
bwa samse megahit-quality-assembly.fa  /mnt/research/ged/sherine/Mapping/mq.se.sai  SRR606249.se.qc.fq.gz > /mnt/research/ged/sherine/Mapping/mq.se.sam

samtools faidx megahit-quality-assembly.fa

samtools import megahit-quality-assembly.fa.fai /mnt/research/ged/sherine/Mapping/mq.pe.sam /mnt/research/ged/sherine/Mapping/mq.pe.bam
samtools import megahit-quality-assembly.fa.fai /mnt/research/ged/sherine/Mapping/mq.se.sam /mnt/research/ged/sherine/Mapping/mq.se.bam


python extract-unaligned.py -o mq.pe.unaligned --format fasta /mnt/research/ged/sherine/Mapping/mq.pe.bam
python extract-unaligned.py -o mq.se.unaligned --format fasta /mnt/research/ged/sherine/Mapping/mq.se.bam
