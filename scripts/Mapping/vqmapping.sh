#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=100GB
#PBS -N VQMapping

module load samtools 
module load bwa
module load pysam


cd /mnt/home/mahmoud4/Metagenome-Protocol/Mapping/

bwa index velvet-quality-assembly.fa

bwa aln velvet-quality-assembly.fa SRR606249.pe.qc.fq.gz   > /mnt/research/ged/sherine/Mapping/vq.pe.sai
bwa aln velvet-quality-assembly.fa SRR606249.se.qc.fq.gz   > /mnt/research/ged/sherine/Mapping/vq.se.sai

bwa samse velvet-quality-assembly.fa  /mnt/research/ged/sherine/Mapping/vq.pe.sai  SRR606249.pe.qc.fq.gz > /mnt/research/ged/sherine/Mapping/vq.pe.sam
bwa samse velvet-quality-assembly.fa  /mnt/research/ged/sherine/Mapping/vq.se.sai  SRR606249.se.qc.fq.gz > /mnt/research/ged/sherine/Mapping/vq.se.sam

samtools faidx velvet-quality-assembly.fa

samtools import velvet-quality-assembly.fa.fai /mnt/research/ged/sherine/Mapping/vq.pe.sam /mnt/research/ged/sherine/Mapping/vq.pe.bam
samtools import velvet-quality-assembly.fa.fai /mnt/research/ged/sherine/Mapping/vq.se.sam /mnt/research/ged/sherine/Mapping/vq.se.bam

python extract-unaligned.py -o vq.pe.unaligned --format fasta /mnt/research/ged/sherine/Mapping/vq.pe.bam
python extract-unaligned.py -o vq.se.unaligned --format fasta /mnt/research/ged/sherine/Mapping/vq.se.bam
