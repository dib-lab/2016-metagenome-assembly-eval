#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=75GB
#PBS -N idbaQC5


cd /mnt/research/ged/sherine/2015-metagenome-assembly/ecoli-test/


module swap GNU GNU/4.4.5
module load IDBAUD

make ecoli.idba.d.qc/contig.fa 


make idba-quality-assembly.fa 










