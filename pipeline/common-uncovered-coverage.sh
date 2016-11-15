#PBS -A ged
#PBS -l nodes=1:ppn=3
#PBS -l walltime=160:00:00
#PBS -l mem=100GB
#PBS -N common-uncovered 


cd /mnt/research/ged/sherine/upgrades/foo/

module load bwa
module load samtools 


python common-uncovered-coverage.py mircea.fa qc-ref.sam QC.AMBIGIOUS500.99.uncovered.bases  uncov500.coverage.out



