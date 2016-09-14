#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=75GB
#PBS -N megahitpart25


cd /mnt/research/ged/sherine/quality25
module load khmer 

make megahit-part-1

make megahit-part-2

make finalize-megahit-partition






