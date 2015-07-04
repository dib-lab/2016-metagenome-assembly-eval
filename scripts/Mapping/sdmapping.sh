#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=100GB
#PBS -N SDMapping

module load samtools 
module load bwa
module load pysam 


cd /mnt/home/mahmoud4/Metagenome-Protocol/Mapping/

bwa index spades-diginorm-assembly.fa

bwa aln spades-diginorm-assembly.fa SRR606249.pe.qc.fq.gz   > /mnt/research/ged/sherine/Mapping/sd.pe.sai
bwa aln spades-diginorm-assembly.fa SRR606249.se.qc.fq.gz   > /mnt/research/ged/sherine/Mapping/sd.se.sai

bwa samse spades-diginorm-assembly.fa  /mnt/research/ged/sherine/Mapping/sd.pe.sai  SRR606249.pe.qc.fq.gz > /mnt/research/ged/sherine/Mapping/sd.pe.sam
bwa samse spades-diginorm-assembly.fa  /mnt/research/ged/sherine/Mapping/sd.se.sai  SRR606249.se.qc.fq.gz > /mnt/research/ged/sherine/Mapping/sd.se.sam

samtools faidx spades-diginorm-assembly.fa

samtools import spades-diginorm-assembly.fa.fai /mnt/research/ged/sherine/Mapping/sd.pe.sam /mnt/research/ged/sherine/Mapping/sd.pe.bam
samtools import spades-diginorm-assembly.fa.fai /mnt/research/ged/sherine/Mapping/sd.se.sam /mnt/research/ged/sherine/Mapping/sd.se.bam


python extract-unaligned.py -o sd.pe.unaligned --format fasta /mnt/research/ged/sherine/Mapping/sd.pe.bam
python extract-unaligned.py -o sd.se.unaligned --format fasta /mnt/research/ged/sherine/Mapping/sd.se.bam
