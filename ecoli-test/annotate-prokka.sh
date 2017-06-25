#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=100GB
#PBS -N annotate

cd /mnt/research/ged/sherine/2015-metagenome-assembly/ecoli-test/ 

module load prokka 
module load tbl2asn 


make annotate-prokka
make parse-prokka 
