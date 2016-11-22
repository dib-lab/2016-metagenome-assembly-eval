#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=4:00:00
#PBS -l mem=75GB
#PBS -N idbaQC5


cd /mnt/research/ged/sherine/2015-metagenome-assembly/pipeline/

module swap GNU GNU/4.4.5
module load IDBAUD

make sample5per.idba.d.qc/scaffold.fa 
make idba-quality-assembly.fa 










