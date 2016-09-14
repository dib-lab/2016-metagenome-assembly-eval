#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=75GB
#PBS -N ndigi5


cd /mnt/research/ged/sherine/sampling/five/

module swap GNU GNU/4.8.2
module load khmer

make protocol-diginorm-C20 
make protocol-diginorm-filter 
make protocol-diginorm-extract 
make protocol-diginorm-C5 
make protocol-diginorm-combine-pe-se





