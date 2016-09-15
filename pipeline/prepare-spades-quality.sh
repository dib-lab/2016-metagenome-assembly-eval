for i in *.pe.qc.fq.gz
do
   gunzip -c $i > $(basename $i .gz)
done
