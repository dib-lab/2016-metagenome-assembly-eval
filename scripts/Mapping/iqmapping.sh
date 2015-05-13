#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=100GB
#PBS -N IQMapping

module load samtools 
module load bwa
module load pysam 

cd /mnt/home/mahmoud4/Metagenome-Protocol/Mapping/

bwa index idba-quality-assembly.fa

bwa aln idba-quality-assembly.fa SRR606249.pe.qc.fq.gz   > /mnt/research/ged/sherine/Mapping/iq.pe.sai
bwa aln idba-quality-assembly.fa SRR606249.se.qc.fq.gz   > /mnt/research/ged/sherine/Mapping/iq.se.sai

bwa samse idba-quality-assembly.fa  /mnt/research/ged/sherine/Mapping/iq.pe.sai  SRR606249.pe.qc.fq.gz > /mnt/research/ged/sherine/Mapping/iq.pe.sam
bwa samse idba-quality-assembly.fa  /mnt/research/ged/sherine/Mapping/iq.se.sai  SRR606249.se.qc.fq.gz > /mnt/research/ged/sherine/Mapping/iq.se.sam

samtools faidx idba-quality-assembly.fa

samtools import idba-quality-assembly.fa.fai /mnt/research/ged/sherine/Mapping/iq.pe.sam /mnt/research/ged/sherine/Mapping/iq.pe.bam
samtools import idba-quality-assembly.fa.fai /mnt/research/ged/sherine/Mapping/iq.se.sam /mnt/research/ged/sherine/Mapping/iq.se.bam

python extract-unaligned.py -o iq.pe.unaligned --format fasta /mnt/research/ged/sherine/Mapping/iq.pe.bam
python extract-unaligned.py -o iq.se.unaligned --format fasta /mnt/research/ged/sherine/Mapping/iq.se.bam
