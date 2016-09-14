#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=75GB
#PBS -N idbadigi25


cd /mnt/research/ged/sherine/quality25
module load khmer 
module load IDBAUD

make idba-diginorm-1

make idba-diginorm-2

make finalize-idba-diginorm









