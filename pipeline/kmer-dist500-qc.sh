#PBS -A ged
#PBS -l nodes=1:ppn=3
#PBS -l walltime=160:00:00
#PBS -l mem=75GB
#PBS -N kmerdist500


cd /mnt/research/ged/sherine/run
module load Trimmomatic
module swap GNU GNU/4.8.2
module load khmer


gunzip -c SRR606249.pe.qc.fq.gz > SRR606249.pe.qc.fastq 
gunzip -c SRR606249.se.qc.fq.gz > SRR606249.se.qc.fastq  


python ~/khmer/scripts/load-into-counting.py -x 2e9 -N 4 -k 20 qc.counts.kh SRR606249.pe.qc.fastq SRR606249.se.qc.fastq 
python ~/khmer/scripts/abundance-dist.py -s qc.counts.kh mircea.fa  podar.qc.dist

cat SRR606249.pe.qc.fastq SRR606249.se.qc.fastq  > SRR606249-pese.fastq 
python ~/khmer/scripts/abundance-dist.py qc.counts.kh SRR606249-pese.fastq qc.dist 

cat idba-quality-assembly500.fa spades-quality-assembly500.fa megahit-quality-assembly500.fa > qc-assembly500.fa 
python ~/khmer/scripts/abundance-dist.py -s qc.counts.kh qc-assembly500.fa Rqc500.dist

python ~/khmer/scripts/abundance-dist.py -s qc.counts.kh idba-quality-assembly500.fa  Riqc500.dist
python ~/khmer/scripts/abundance-dist.py -s qc.counts.kh spades-quality-assembly500.fa  Rsqc500.dist 
python ~/khmer/scripts/abundance-dist.py -s qc.counts.kh megahit-quality-assembly500.fa Rmqc500.dist







