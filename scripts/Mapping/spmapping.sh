#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=100GB
#PBS -N SPMapping

module load samtools 
module load bwa
module load pysam 


cd /mnt/home/mahmoud4/Metagenome-Protocol/Mapping/

bwa index spades-partition-assembly.fa

bwa aln spades-partition-assembly.fa SRR606249.pe.qc.fq.gz   > /mnt/research/ged/sherine/Mapping/sp.pe.sai
bwa aln spades-partition-assembly.fa SRR606249.se.qc.fq.gz   > /mnt/research/ged/sherine/Mapping/sp.se.sai

bwa samse spades-partition-assembly.fa  /mnt/research/ged/sherine/Mapping/sp.pe.sai  SRR606249.pe.qc.fq.gz > /mnt/research/ged/sherine/Mapping/sp.pe.sam
bwa samse spades-partition-assembly.fa  /mnt/research/ged/sherine/Mapping/sp.se.sai  SRR606249.se.qc.fq.gz > /mnt/research/ged/sherine/Mapping/sp.se.sam

samtools faidx spades-partition-assembly.fa

samtools import spades-partition-assembly.fa.fai /mnt/research/ged/sherine/Mapping/sp.pe.sam /mnt/research/ged/sherine/Mapping/sp.pe.bam
samtools import spades-partition-assembly.fa.fai /mnt/research/ged/sherine/Mapping/sp.se.sam /mnt/research/ged/sherine/Mapping/sp.se.bam


python extract-unaligned.py -o sp.pe.unaligned --format fasta /mnt/research/ged/sherine/Mapping/sp.pe.bam
python extract-unaligned.py -o sp.se.unaligned --format fasta /mnt/research/ged/sherine/Mapping/sp.se.bam
