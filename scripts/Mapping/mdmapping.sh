#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=100GB
#PBS -N MDMapping

module load samtools 
module load bwa
module load pysam 

cd /mnt/home/mahmoud4/Metagenome-Protocol/Mapping/

bwa index megahit-diginorm-assembly.fa

bwa aln megahit-diginorm-assembly.fa SRR606249.pe.qc.fq.gz   > /mnt/research/ged/sherine/Mapping/md.pe.sai
bwa aln megahit-diginorm-assembly.fa SRR606249.se.qc.fq.gz   > /mnt/research/ged/sherine/Mapping/md.se.sai

bwa samse megahit-diginorm-assembly.fa  /mnt/research/ged/sherine/Mapping/md.pe.sai  SRR606249.pe.qc.fq.gz > /mnt/research/ged/sherine/Mapping/md.pe.sam
bwa samse megahit-diginorm-assembly.fa  /mnt/research/ged/sherine/Mapping/md.se.sai  SRR606249.se.qc.fq.gz > /mnt/research/ged/sherine/Mapping/md.se.sam

samtools faidx megahit-diginorm-assembly.fa

samtools import megahit-diginorm-assembly.fa.fai /mnt/research/ged/sherine/Mapping/md.pe.sam /mnt/research/ged/sherine/Mapping/md.pe.bam
samtools import megahit-diginorm-assembly.fa.fai /mnt/research/ged/sherine/Mapping/md.se.sam /mnt/research/ged/sherine/Mapping/md.se.bam


python extract-unaligned.py -o md.pe.unaligned --format fasta /mnt/research/ged/sherine/Mapping/md.pe.bam
python extract-unaligned.py -o md.se.unaligned --format fasta /mnt/research/ged/sherine/Mapping/md.se.bam
