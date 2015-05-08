#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=100GB
#PBS -N SQMapping

module load samtools 
module load bwa
module load pysam


cd /mnt/home/mahmoud4/Metagenome-Protocol/Mapping/

bwa index spades-quality-assembly.fa

bwa aln spades-quality-assembly.fa SRR606249.pe.qc.fq.gz   > /mnt/research/ged/sherine/Mapping/sq.pe.sai
bwa aln spades-quality-assembly.fa SRR606249.se.qc.fq.gz   > /mnt/research/ged/sherine/Mapping/sq.se.sai

bwa samse spades-quality-assembly.fa  /mnt/research/ged/sherine/Mapping/sq.pe.sai  SRR606249.pe.qc.fq.gz > /mnt/research/ged/sherine/Mapping/sq.pe.sam
bwa samse spades-quality-assembly.fa  /mnt/research/ged/sherine/Mapping/sq.se.sai  SRR606249.se.qc.fq.gz > /mnt/research/ged/sherine/Mapping/sq.se.sam

samtools faidx spades-quality-assembly.fa

samtools import spades-quality-assembly.fa.fai /mnt/research/ged/sherine/Mapping/sq.pe.sam /mnt/research/ged/sherine/Mapping/sq.pe.bam
samtools import spades-quality-assembly.fa.fai /mnt/research/ged/sherine/Mapping/sq.se.sam /mnt/research/ged/sherine/Mapping/sq.se.bam


python extract-unaligned.py -o sq.pe.unaligned --format fasta /mnt/research/ged/sherine/Mapping/sq.pe.bam
python extract-unaligned.py -o sq.se.unaligned --format fasta /mnt/research/ged/sherine/Mapping/sq.se.bam
