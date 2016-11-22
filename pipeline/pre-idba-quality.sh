#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=4:00:00
#PBS -l mem=75GB
#PBS -N preidbaQC5


cd /mnt/research/ged/sherine/2015-metagenome-assembly/pipeline/

module swap GNU GNU/4.8.2
module load khmer

make sample5per.pe.fa 












