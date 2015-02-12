KHMER=/usr/local/share/khmer
TRIM=/usr/local/bin
INSTALLED=/root
DATA=/mnt/data
QUALITY=/mnt/quality-make
DIGINORM=/mnt/diginorm-make
PARTITION=/mnt/partition-make
PREFIX=extract
KAK=kak

all: quality \
	diginorm \
	partition \
	velvet-quality \
	spades-quality \
	idba-quality \
	velvet-diginorm \
	spades-diginorm \
	idba-diginorm \
	velvet-partition \
	spades-partition \
	idba-partition \
	quast	

#########################################
quality: interleaving-1 \
	interleaving-2 \
	interleaving-3 \
	protocol-quality-rename-1 \
	protocol-quality-rename-2 	
#########################################
diginorm: ${QUALITY}/${PREFIX}.pe.qc.fq.gz ${QUALITY}/${PREFIX}.se.qc.fq.gz \
	linking-quality \
        protocol-diginorm-C20 \
        protocol-diginorm-filter \
        protocol-diginorm-extract \
        protocol-diginorm-C5 \
	protocol-diginorm-combine-pe-se
########################################
partition: ${DIGINORM}.${PREFIX}.pe.kak.qc.fq.gz ${DIGINORM}.${PREFIX}.se.kak.qc.fq.gz \
	linking-diginorm \
	protocol-partition-below \
	protocol-partition-rename-1 \
	protocol-partition-run \
	protocol-partition-extract \
	protocol-partition-rename-2 \
	protocol-partition-compress 
#######################################

#--------------------------------------------Velvet Quality--------------------------------------------------------
velvet-quality:quality \
	velvet-quality-1 \
	finalize-velvet-quality
#--------------------------------------------Spades Quality--------------------------------------------------------
spades-quality: quality \
	spades-quality-1 \
	spades-quality-2 \
	finalize-spades-quality
#---------------------------------------------IDBA Quality---------------------------------------------------------
idba-quality: quality \
	idba-quality-1 \
	idba-quality-2 \
	finalize-idba-quality	
#----------------------------------------------Velvet Diginorm---------------------------------------------------------
velvet-diginorm: diginorm \
	velvet-diginorm-1 \
	finalize-velvet-diginorm 

#----------------------------------------------Spades Diginorm---------------------------------------------------------
spades-diginorm: diginorm \
	spades-diginorm-1 \
	spades-diginorm-2 \
	finalize-spades-diginorm	
#----------------------------------------------IDBA Diginorm----------------------------------------------------------
idba-diginorm: diginorm  \
	idba-diginorm-1 \
	idba-diginorm-2 \
	finalize-idba-diginorm 
#------------------------------------------------Velvet  Partition-------------------------------------------------------------
velvet-partition: partition \
	velvet-partition-1 \
	velvet-partition-2 \
	finalize-velvet-partition 
#-------------------------------------------------Spades Partition-------------------------------------------------------------
spades-partition: partition \
	spades-partition-1 \
	spades-partition-2 \
	spades-partition-3 \
	finalize-spades-partition 
#--------------------------------------------------IDBA Partition--------------------------------------------------------------
idba-partition: partition \
	idba-partition-1 \
	idba-partition-2 \
	idba-partition-3 \
	finalize-idba-partition
#-----------------------------------------------------------QUALITY STARTS----------------------------------------------------------------------------------- 
interleaving-1: ${DATA}/${PREFIX}-1.fastq.gz  ${DATA}/${PREFIX}-2.fastq.gz
	java -jar ${TRIM}/trimmomatic-0.30.jar PE ${DATA}/${PREFIX}-1.fastq.gz  ${DATA}/${PREFIX}-2.fastq.gz  ${QUALITY}/s1_pe ${QUALITY}/s1_se ${QUALITY}/s2_pe ${QUALITY}/s2_se ILLUMINACLIP:/usr/local/share/adapters/TruSeq3-PE.fa:2:30:10 \
	${KHMER}/scripts/interleave-reads.py ${QUALITY}/s1_pe ${QUALITY}/s2_pe | gzip -9c > ${QUALITY}/${PREFIX}.pe.fq.gz \
	cat ${QUALITY}/s1_se ${QUALITY}/s2_se | gzip -9c > ${QUALITY}/${PREFIX}.se.fq.gz

interleaving-2: ${QUALITY}/${PREFIX}.se.fq.gz ${QUALITY}/${PREFIX}.pe.fq.gz
	gunzip -c ${QUALITY}/${PREFIX}.pe.fq.gz | fastq_quality_filter -Q33 -q 30 -p 50 | gzip -9c > ${QUALITY}/${PREFIX}.pe.qc.fq.gz \
	gunzip -c ${QUALITY}/${PREFIX}.se.fq.gz | fastq_quality_filter -Q33 -q 30 -p 50 | gzip -9c > ${QUALITY}/${PREFIX}.se.qc.fq.gz

interleaving-3: ${QUALITY}/${PREFIX}.pe.qc.fq.gz  ${QUALITY}/${PREFIX}.se.qc.fq.gz
	cd ${QUALITY} && extract-paired-reads.py ${QUALITY}/${PREFIX}.pe.qc.fq.gz 

protocol-quality-rename-1: ${QUALITY}/${PREFIX}.pe.qc.fq.gz.pe
	cd ${QUALITY} && ./qc-rename-1.sh \
	touch protocol-quality-rename-1


protocol-quality-rename-2: ${QUALITY}/${PREFIX}.pe.qc.fq.gz.se 
	cd ${QUALITY} && ./qc-rename-2.sh \
	touch protocol-quality-rename-2
#----------------------------------------------------------------VELVET QUALITY ------------------------------------------------------------------------------
velvet-quality-1: ${QUALITY}/${PREFIX}.pe.qc.fq.gz  ${QUALITY}/${PREFIX}.se.qc.fq.gz 
	cd ${QUALITY} && ./velvet-qc.sh 
	touch velvet-quality-1

finalize-velvet-quality: 
	cd ${QUALITY} && python ${KHMER}/sandbox/calc-best-assembly.py ${PREFIX}.velvet.*.d/contigs.fa -o velvet-quality-best.fa &&  python ${KHMER}/sandbox/multi-rename.py assembly  velvet-quality-best.fa >velvet-quality-assembly.fa

#--------------------------------------------------------------SPADES QUALITY---------------------------------------------------------------------------------
spades-quality-1: ${QUALITY}/${PREFIX}.pe.qc.fq.gz 
	cd ${QUALITY} && ./spades-qc.sh \
	touch spades-quality-1

spades-quality-2:  ${QUALITY}/${PREFIX}.pe.qc.fq.gz 
	cd ${QUALITY} && /usr/bin/time -o sqc.txt spades.py --sc --pe1-12 ${QUALITY}/${PREFIX}.pe.qc.fq.gz -o ${PREFIX}.spades.d	

finalize-spades-quality: ${QUALITY}/${PREFIX}.spades.d/contigs.fasta  
	cd ${QUALITY} && python ${KHMER}/sandbox/calc-best-assembly.py ${PREFIX}.spades.d/contigs.fasta -o spades-quality-best.fa \
	cd ${QUALITY} && python ${KHMER}/sandbox/multi-rename.py assembly spades-quality-best.fa > spades-quality-assembly.fa

#------------------------------------------------------------------IDBA QUALITY-------------------------------------------------------------------------------
idba-quality-1: ${QUALITY}/${PREFIX}/.pe.qc.fq.gz
	cd ${QUALITY} && ./idba-qc.sh && touch idba-quality-1

idba-quality-2: ${QUALITY}/${PREFIX}.pe.fa
	cd ${QUALITY}  && /usr/bin/time -a -o iqc.txt idba_ud --pre_correction -r ${PREFIX}.pe.fa -o ${PREFIX}.idba.d 

finalize-idba-quality: ${PREFIX}.idba.d/scaffold.fa
	cd ${QUALITY} && python ${KHMER}/sandbox/calc-best-assembly.py  ${PREFIX}.idba.d/scaffold.fa -o idba-quality-best.fa \
	cd ${QUALITY} && python ${KHMER}/sandbox/multi-rename.py assembly  idba-quality-best.fa > idba-quality-assembly.fa

#-----------------------------------------------------------------DIGINORM STARTS-----------------------------------------------------------------------------
linking-quality: 
	ln -fs ${QUALITY}/*.* ${DIGINORM}
protocol-diginorm-C20: ${QUALITY}/${PREFIX}.pe.qc.fq.gz ${QUALITY}/${PREFIX}.se.qc.fq.gz
	cd ${DIGINORM} && normalize-by-median.py -p -k 20 -C 20 -N 4 -x 1e9 --savetable normC20k20.kh  ${QUALITY}/*.pe.qc.fq.gz;\
	cd ${DIGINORM} && normalize-by-median.py -C 20 --loadtable ${DIGINORM}/normC20k20.kh --savetable normC20k20.kh ${QUALITY}/*.se.qc.fq.gz

protocol-diginorm-filter: ${DIGINORM}/normC20k20.kh
	cd ${DIGINORM}  && filter-abund.py -V ${DIGINORM}/normC20k20.kh ${DIGINORM}/*.keep 

protocol-diginorm-extract: 
	cd ${DIGINORM} && extract-paired-reads.py ${DIGINORM}/${PREFIX}.pe.qc.fq.gz.keep.abundfilt; \

protocol-diginorm-C5:
	cd ${DIGINORM} && normalize-by-median.py -C 5 -k 20 -N 4 -x 1e9 --savetable ${DIGINORM}/normC5k20.kh -p ${DIGINORM}/*.pe.qc.fq.gz.keep.abundfilt.pe ;\
        cd ${DIGINORM} && normalize-by-median.py -C 5 --savetable normC5k20.kh --loadtable ${DIGINORM}/normC5k20.kh ${DIGINORM}/*.pe.qc.fq.gz.keep.abundfilt.se ${DIGINORM}/*.se.qc.fq.gz.keep.abundfilt

protocol-diginorm-combine: ${DIGINORM}/${PREFIX}.pe.qc.fq.gz.keep.abundfilt.pe.keep ${DIGINORM}/${PREFIX}.pe.qc.fq.gz.keep.abundfilt.se.keep ${DIGINORM}\${PREFIX}.se.qc.fq.gz.keep.abundfilt.keep
	cd ${DIGINORM} && cat ${DIGINORM}\${PREFIX}.pe.qc.fq.gz.keep.abundfilt.pe.keep  ${DIGINORM}\${PREFIX}.pe.qc.fq.gz.keep.abundfilt.se.keep |gzip -c >${DIGINORM}\${PREFIX}.pe.kak.qc.fq.gz  && gzip -c ${DIGINORM}\${PREFIX}.se.qc.fq.gz.keep.abundfilt.keep > ${DIGINORM}\${PREFIX}.se.kak.qc.fq.gz      

protocol-diginorm-combine-pe-se:
	cd ${DIGINORM} && ./diginorm-combine-pe.sh && ./diginorm-combine-se.sh \
        touch protocol-diginorm-combine-pe-se
#----------------------------------------------------------------VELVET DIGINORM-----------------------------------------------------------------------------
velvet-diginorm-1:  
	$(foreach k, $(KSIZES),\
	  $(subst KSIZE, $k, ${DIGINORM}/${PREFIX}.velvet.KSIZE.d))

${DIGINORM}/${PREFIX}.velvet.%.d: ${DIGINORM}/${PREFIX}.pe.kak.qc.fq.gz ${DIGINORM}/${PREFIX}.se.kak.qc.fq.gz
	/usr/bin/time -a -o vdig.txt velveth $@ $* -fastq.gz -shortPaired $< -short $(word 2,$^) && velvetg $@ -exp_cov auto -cov_cutoff auto

finalize-velvet-diginorm:
	cd ${DIGINORM} && python ${KHMER}/sandbox/calc-best-assembly.py ${PREFIX}.velvet.*.d/contigs.fa -o velvet-diginorm-best.fa 
	cd ${DIGINORM} && python ${KHMER}/sandbox/multi-rename.py assembly velvet-diginorm-best.fa > velvet-diginorm-assembly.fa 
#----------------------------------------------------------------SPADES DIGINORM------------------------------------------------------------------------------
spades-diginorm-1:
	cd ${DIGINORM} && ./spades-dig.sh \
	touch spades-diginorm-1

spades-diginorm-2: ${DIGINORM}/${PREFIX}.pe.kak.qc.fq.gz	
	cd ${DIGINORM} && /usr/bin/time -a -o sdig.txt spades.py --sc --pe1-12 ${DIGINORM}/${PREFIX}.pe.kak.qc.fq.gz -o ${DIGINORM}/${PREFIX}.spades.d
	
finalize-spades-diginorm:  ${DIGINORM}/${PREFIX}.spades.d/contigs.fasta 
	cd ${DIGINORM} && python ${KHMER}/sandbox/calc-best-assembly.py ${DIGINORM}/${PREFIX}.spades.d/contigs.fasta -o ${DIGINORM}/spades-diginorm-best.fa
	cd ${DIGINORM} && python ${KHMER}/sandbox/multi-rename.py assembly ${DIGINORM}/spades-diginorm-best.fa > ${DIGINORM}/spades-diginorm-assembly.fa
#-------------------------------------------------------------------IDBA DIGINORM-----------------------------------------------------------------------------
idba-diginorm-1: 
	cd ${DIGINORM} && ./idba-dig.sh \
	touch idba-diginorm-2

idba-diginorm-2: 
	cd ${DIGINORM}  &&  /usr/bin/time -a -o idig.txt idba_ud --pre_correction -r ${DIGINORM}/${PREFIX}.pe.kak.fa  -o ${DIGINORM}/${PREFIX}.idba.d

finalize-idba-diginorm: ${DIGINORM}/${PREFIX}.idba.d/scaffold.fa	
	cd ${DIGINORM} && python ${KHMER}/sandbox/calc-best-assembly.py  ${DIGINORM}/${PREFIX}.idba.d/scaffold.fa -o ${DIGINORM}/idba-diginorm-best.fa \
	cd ${DIGINORM} && python ${KHMER}/sandbox/multi-rename.py assembly  idba-diginorm-best.fa > ${DIGINORM}/idba-diginorm-assembly.fa
#-------------------------------------------------------------------PARTITION STARTS--------------------------------------------------------------------------
linking-diginorm: 
	 ln -fs ${DIGINORM}/*.* ${PARTITION}

protocol-partition-below: ${DIGINORM}/normC5k20.kh ${DIGINORM}/*.kak.*.fq.gz
	cd ${PARTITION} && python ${KHMER}/sandbox/filter-below-abund.py ${DIGINORM}/normC5k20.kh ${DIGINORM}/*.kak.*.fq.gz 


protocol-partition-rename-1: 
	cd ${PARTITION} && mv ${PREFIX}.pe.kak.qc.fq.gz.below  ${PREFIX}.pe.kak.qc.fq.gz.below.fq &&  mv ${PREFIX}.se.kak.qc.fq.gz.below ${PREFIX}.se.kak.qc.fq.gz.below.fq 

protocol-partition-run: ${PARTITION}/${PREFIX}.pe.kak.qc.fq.gz.below.fq  ${PARTITION}/${PREFIX}.se.kak.qc.fq.gz.below.fq 
	cd ${PARTITION} && ${KHMER}/scripts/do-partition.py -k 32 -x 1e9 --threads 4 kak ${PARTITION}/*.kak.qc.fq.gz.below.fq


protocol-partition-extract: 
	cd ${PARTITION} && ${KHMER}/scripts/extract-partitions.py -X 100000 kak *.part


protocol-partition-rename-2:  
	cd ${PARTITION} && ./seperate.sh \
	touch protocol-partition-rename-2

protocol-partition-compress: 
	cd ${PARTITION} && gzip *.pe.fq  *.se.fq

#--------------------------------------------------------------------Velvet Partition-------------------------------------------------------------------------
velvet-partition-1: 
	cd ${PARTITION} && ./velvet-part.sh \
	touch velvet-partition-1

velvet-partition-2:
	cd ${PARTITION} &&  ./velvet-part-finalize.sh \
	touch velvet-partition-2
finalize-velvet-partition:
	        python ${KHMER}/sandbox/multi-rename.py assembly ${PARTITION}/velvet-partition-best.group*.fa > ${PARTITION}/velvet-partition-assembly.fa

#-------------------------------------------------------------------Spades Partition--------------------------------------------------------------------------
spades-partition-1:
	cd ${PARTITION} && ./spades-part.sh \
	touch spades-partition-1

spades-partition-2:
	cd ${PARTITION} && ./spades-part-run.sh \
	touch spades-partition-2

spades-partition-3:
	cd ${PARTITION} && ./spades-part-finalize.sh \
	touch spades-partition-3

finalize-spades-partition: 
	python ${KHMER}/sandbox/multi-rename.py assembly ${PARTITION}/spades-partition-best.group*.fa > ${PARTITION}/spades-partition-assembly.fa
#------------------------------------------------------------------IDBA Partition-----------------------------------------------------------------------------
idba-partition-1:
	cd ${PARTITION} && ./idba-part.sh \
	touch idba-partition-1

idba-partition-2: 
	cd ${PARTITION} && ./idba-part-run.sh \
	touch idba-partition-2

idba-partition-3:
	cd ${PARTITION} && ./idba-part-finalize.sh \
	touch idba-partition-3

finalize-idba-partition:
	python ${KHMER}/sandbox/multi-rename.py assembly ${PARTITION}/idba-partition-best.group*.fa > ${PARTITION}/idba-partition-assembly.fa

#-------------------------------------------------------------------QUAST-------------------------------------------------------------------------------------
quast: 
	python ${QUAST}/quast.py -R ${data}/mircea.fa  -o ${QUALITY}/quast-velvet-quality/ ${QUALITY}/velvet-quality-assembly.fa \
	python ${QUAST}/quast.py -R ${data}/mircea.fa  -o ${QUALITY}/quast-idba-quality/ ${QUALITY}/idba-quality-assembly.fa \
	python ${QUAST}/quast.py -R ${data}/mircea.fa  -o ${DIGINORM}/quast-spades-diginorm/ ${DIGINORM}/spades-diginorm-assembly.fa \
	python ${QUAST}/quast.py -R ${data}/mircea.fa  -o ${DIGINORM}/quast-velvet-diginorm/ ${DIGINORM}/velvet-diginorm-assembly.fa \
	python ${QUAST}/quast.py -R ${data}/mircea.fa  -o ${DIGINORM}/quast-idba-diginorm/ ${DIGINORM}/idba-diginorm-assembly.fa \
	python ${QUAST}/quast.py -R ${data}/mircea.fa  -o ${PARTITION}/quast-spades-partition/ ${PARTITION}/spades-partition-massembly.fa \
	python ${QUAST}/quast.py -R ${data}/mircea.fa  -o ${PARTITION}/quast-velvet-partition/ ${PARTITION}/velvet-partition-assembly.fa \
	python ${QUAST}/quast.py -R ${data}/mircea.fa  -o ${PARTITION}/quast-idba-partition/ ${PARTITION}/idba-partition-assembly.fa \

