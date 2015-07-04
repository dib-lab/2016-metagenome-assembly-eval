#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=100GB
#PBS -N VDMapping

module load samtools 
module load bwa
module load pysam

cd /mnt/home/mahmoud4/Metagenome-Protocol/Mapping/

bwa index velvet-diginorm-assembly.fa

bwa aln velvet-diginorm-assembly.fa SRR606249.pe.qc.fq.gz   > /mnt/research/ged/sherine/Mapping/vd.pe.sai
bwa aln velvet-diginorm-assembly.fa SRR606249.se.qc.fq.gz   > /mnt/research/ged/sherine/Mapping/vd.se.sai

bwa samse velvet-diginorm-assembly.fa  /mnt/research/ged/sherine/Mapping/vd.pe.sai  SRR606249.pe.qc.fq.gz > /mnt/research/ged/sherine/Mapping/vd.pe.sam
bwa samse velvet-diginorm-assembly.fa  /mnt/research/ged/sherine/Mapping/vd.se.sai  SRR606249.se.qc.fq.gz > /mnt/research/ged/sherine/Mapping/vd.se.sam

samtools faidx velvet-diginorm-assembly.fa

samtools import velvet-diginorm-assembly.fa.fai /mnt/research/ged/sherine/Mapping/vd.pe.sam /mnt/research/ged/sherine/Mapping/vd.pe.bam
samtools import velvet-diginorm-assembly.fa.fai /mnt/research/ged/sherine/Mapping/vd.se.sam /mnt/research/ged/sherine/Mapping/vd.se.bam


python extract-unaligned.py -o vd.pe.unaligned --format fasta /mnt/research/ged/sherine/Mapping/vd.pe.bam
python extract-unaligned.py -o vd.se.unaligned --format fasta /mnt/research/ged/sherine/Mapping/vd.se.bam 
