#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=75GB
#PBS -N spadesdigi25


cd /mnt/research/ged/sherine/quality25

module swap GNU GNU/4.8.2
module load khmer
module load spades


make finalize-spades-diginorm




