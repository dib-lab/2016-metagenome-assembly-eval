#PBS -A ged
#PBS -l nodes=1:ppn=3
#PBS -l walltime=160:00:00
#PBS -l mem=75GB
#PBS -N 5perdiginorm 

cd /mnt/research/ged/sherine/2015-metagenome-assembly/pipeline/ 

module swap GNU GNU/4.8.2
module load khmer

 
make sample5per.ignore.long

make sample5per.ignore.long.pe 

make normC20k20.kh 

make sample5per.pe.qc.fq.gz.keep.abundfilt

make sample5per.pe.qc.fq.gz.keep.abundfilt.pe 

make sample5per.pe.qc.fq.gz.keep.abundfilt.se.keep

make sample5per.se.kak.qc.fq.gz






