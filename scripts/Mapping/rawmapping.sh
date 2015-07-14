#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=100GB
#PBS -N RAWrawmapping

module load samtools 
module load bwa
module load pysam

cd /mnt/home/mahmoud4/Metagenome-Protocol/Mapping-RAW-REF


bwa index mircea.fa

bwa aln mircea.fa SRR606249.pe.qc.fq.gz   > /mnt/research/ged/sherine/rawmapping/mircea.pe.sai
bwa aln mircea.fa SRR606249.se.qc.fq.gz   > /mnt/research/ged/sherine/rawmapping/mircea.se.sai

bwa samse mircea.fa  /mnt/research/ged/sherine/rawmapping/mircea.pe.sai  SRR606249.pe.qc.fq.gz > /mnt/research/ged/sherine/rawmapping/mircea.pe.sam
bwa samse mircea.fa  /mnt/research/ged/sherine/rawmapping/mircea.se.sai  SRR606249.se.qc.fq.gz > /mnt/research/ged/sherine/rawmapping/mircea.se.sam

samtools faidx mircea.fa

samtools import mircea.fa.fai /mnt/research/ged/sherine/rawmapping/mircea.pe.sam /mnt/research/ged/sherine/rawmapping/mircea.pe.bam
samtools import mircea.fa.fai /mnt/research/ged/sherine/rawmapping/mircea.se.sam /mnt/research/ged/sherine/rawmapping/mircea.se.bam


python extract-unaligned.py -o mircea.pe.unaligned --format fasta /mnt/research/ged/sherine/rawmapping/mircea.pe.bam
python extract-unaligned.py -o mircea.se.unaligned --format fasta /mnt/research/ged/sherine/rawmapping/mircea.se.bam 
