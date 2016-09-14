#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=75GB
#PBS -N megahitdigi25


cd /mnt/research/ged/sherine/quality25
module load khmer 

make megahit-digi-1

make finalize-megahit-diginorm







