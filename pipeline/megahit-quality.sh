#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=72:00:00
#PBS -l mem=100GB
#PBS -N MegahitQCPodar


cd /mnt/research/ged/sherine/2015-metagenome-assembly/pipeline/

module swap GNU GNU/4.8.2
module load khmer


make megahit-quality









