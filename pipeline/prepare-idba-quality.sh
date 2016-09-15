for i in *.pe.qc.fq.gz

do 

    name=$(basename $i .qc.fq.gz).fa

    python /mnt/home/mahmoud4/khmer/scripts/fastq-to-fasta.py $i > $name

 done
