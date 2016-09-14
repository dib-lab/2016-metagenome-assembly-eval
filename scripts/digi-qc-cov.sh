#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=100GB
#PBS -N QC-DIGI-REF-COV

module load samtools 
module load bwa

cd /mnt/home/mahmoud4/Metagenome-Protocol/ref-cov/

cat ../diginorm/SRR606249.pe.kak.qc.fq.gz ../diginorm/SRR606249.se.kak.qc.fq.gz > diginorm.fq.gz

cat ../quality/SRR606249.pe.qc.fq.gz  ../quality/SRR606249.se.qc.fq.gz > qc.fq.gz

bwa index mircea.fa

bwa aln mircea.fa diginorm.fq.gz  > /mnt/research/ged/sherine/ref-cov/diginorm.sai
bwa aln mircea.fa qc.fq.gz >  /mnt/research/ged/sherine/ref-cov/qc.sai 

bwa samse mircea.fa  /mnt/research/ged/sherine/ref-cov/qc.sai qc.fq.gz > /mnt/research/ged/sherine/ref-cov/qc.sam
bwa samse mircea.fa  /mnt/research/ged/sherine/ref-cov/diginorm.sai diginorm.fq.gz > /mnt/research/ged/sherine/ref-cov/diginorm.sam


python /mnt/home/mahmoud4/2014-streaming/pipeline/sam-calc-refcov-cmp.py mircea.fa /mnt/research/ged/sherine/ref-cov/qc.sam   /mnt/research/ged/sherine/ref-cov/diginorm.sam 

