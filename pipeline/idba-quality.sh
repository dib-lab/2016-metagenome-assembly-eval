#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=96:00:00
#PBS -l mem=100GB
#PBS -N IDBAQCPodar


cd /mnt/research/ged/sherine/2015-metagenome-assembly/pipeline/

module swap GNU GNU/4.4.5
module load IDBAUD

make SRR606249.idba.d.qc/scaffold.fa 
make idba-quality-assembly.fa 










