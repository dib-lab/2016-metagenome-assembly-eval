#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=100GB
#PBS -N VPMapping

module load samtools 
module load bwa
module load pysam


cd /mnt/home/mahmoud4/Metagenome-Protocol/Mapping/

bwa index velvet-partition-assembly.fa

bwa aln velvet-partition-assembly.fa SRR606249.pe.qc.fq.gz   > /mnt/research/ged/sherine/Mapping/vp.pe.sai
bwa aln velvet-partition-assembly.fa SRR606249.se.qc.fq.gz   > /mnt/research/ged/sherine/Mapping/vp.se.sai

bwa samse velvet-partition-assembly.fa  /mnt/research/ged/sherine/Mapping/vp.pe.sai  SRR606249.pe.qc.fq.gz > /mnt/research/ged/sherine/Mapping/vp.pe.sam
bwa samse velvet-partition-assembly.fa  /mnt/research/ged/sherine/Mapping/vp.se.sai  SRR606249.se.qc.fq.gz > /mnt/research/ged/sherine/Mapping/vp.se.sam

samtools faidx velvet-partition-assembly.fa

samtools import velvet-partition-assembly.fa.fai /mnt/research/ged/sherine/Mapping/vp.pe.sam /mnt/research/ged/sherine/Mapping/vp.pe.bam
samtools import velvet-partition-assembly.fa.fai /mnt/research/ged/sherine/Mapping/vp.se.sam /mnt/research/ged/sherine/Mapping/vp.se.bam

python extract-unaligned.py -o vp.pe.unaligned --format fasta /mnt/research/ged/sherine/Mapping/vp.pe.bam
python extract-unaligned.py -o vp.se.unaligned --format fasta /mnt/research/ged/sherine/Mapping/vp.se.bam
