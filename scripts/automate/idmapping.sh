#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=100GB
#PBS -N IDMapping

module load samtools 
module load bwa
module load pysam 

cd /mnt/home/mahmoud4/Metagenome-Protocol/Mapping/

bwa index idba-diginorm-assembly.fa

bwa aln idba-diginorm-assembly.fa SRR606249.pe.qc.fq.gz   > /mnt/research/ged/sherine/Mapping/id.pe.sai
bwa aln idba-diginorm-assembly.fa SRR606249.se.qc.fq.gz   > /mnt/research/ged/sherine/Mapping/id.se.sai

bwa samse idba-diginorm-assembly.fa  /mnt/research/ged/sherine/Mapping/id.pe.sai  SRR606249.pe.qc.fq.gz > /mnt/research/ged/sherine/Mapping/id.pe.sam
bwa samse idba-diginorm-assembly.fa  /mnt/research/ged/sherine/Mapping/id.se.sai  SRR606249.se.qc.fq.gz > /mnt/research/ged/sherine/Mapping/id.se.sam

samtools faidx idba-diginorm-assembly.fa

samtools import idba-diginorm-assembly.fa.fai /mnt/research/ged/sherine/Mapping/id.pe.sam /mnt/research/ged/sherine/Mapping/id.pe.bam
samtools import idba-diginorm-assembly.fa.fai /mnt/research/ged/sherine/Mapping/id.se.sam /mnt/research/ged/sherine/Mapping/id.se.bam


python extract-unaligned.py -o id.pe.unaligned --format fasta /mnt/research/ged/sherine/Mapping/id.pe.bam
python extract-unaligned.py -o id.se.unaligned --format fasta /mnt/research/ged/sherine/Mapping/id.se.bam 
