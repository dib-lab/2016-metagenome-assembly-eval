#PBS -A ged
#PBS -l nodes=6:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=200GB
#PBS -N newcuc

 

cd /mnt/research/ged/sherine/run/
module load bwa
module load samtools 




python uncoveredbases-coverage.py  mircea.fa qc-ref.sam QC.AMBIGIOUS500.99.uncovered.bases  new.common.uncovered500.coverage.out


