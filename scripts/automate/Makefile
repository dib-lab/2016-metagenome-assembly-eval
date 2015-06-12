DATA=/mnt/home/mahmoud4/DATA
CURRENT=/mnt/research/ged/sherine/metagenome
QUALITY=/mnt/home/mahmoud4/Metagenome-Protocol/quality
DIGINORM=/mnt/home/mahmoud4/Metagenome-Protocol/diginorm
PARTITION=/mnt/home/mahmoud4/Metagenome-Protocol/partition
NUCMER=contigs_reports/nucmer_CURRENT
QUAST=~/quast-2.3/
PREFIX=SRR606249
mc= 0 250 500 750 1000 2000
KHMER=/usr/local/share/khmer
TRIM=/usr/local/bin
KAK=kak
MEGAHIT=/mnt/home/mahmoud4/megahit
############
all-protocol: quality \
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

#########################################
quality: ${DATA}/${PREFIX}-1.fastq.gz  ${DATA}/${PREFIX}-2.fastq.gz 
	interleaving-1 \
	interleaving-2 \
	interleaving-3 \
	protocol-quality-rename-1 \
	protocol-quality-rename-2 	
#########################################
diginorm: ${QUALITY}/${PREFIX}.pe.qc.fq.gz ${QUALITY}/${PREFIX}.se.qc.fq.gz 
	linking-quality \
        protocol-diginorm-C20 \
        protocol-diginorm-filter \
        protocol-diginorm-extract \
        protocol-diginorm-C5 \
	protocol-diginorm-combine-pe-se
########################################
partition: ${DIGINORM}/${PREFIX}.pe.kak.qc.fq.gz ${DIGINORM}/${PREFIX}.se.kak.qc.fq.gz 
	linking-diginorm \
	protocol-partition-below \
	protocol-partition-rename-1 \
	protocol-partition-run \
	protocol-partition-extract \
	protocol-partition-rename-2 \
	protocol-partition-compress 

#--------------------------------------------Velvet Quality--------------------------------------------------------
velvet-quality:  ${QUALITY}/${PREFIX}.pe.qc.fq.gz ${QUALITY}/${PREFIX}.se.qc.fq.gz 
	velvet-quality-1 \
	finalize-velvet-quality
#--------------------------------------------Spades Quality--------------------------------------------------------
spades-quality:  ${QUALITY}/${PREFIX}.pe.qc.fq.gz ${QUALITY}/${PREFIX}.se.qc.fq.gz 
	spades-quality-1 \
	spades-quality-2 \
	finalize-spades-quality
#---------------------------------------------IDBA Quality---------------------------------------------------------
idba-quality:  ${QUALITY}/${PREFIX}.pe.qc.fq.gz ${QUALITY}/${PREFIX}.se.qc.fq.gz 
	idba-quality-1 \
	idba-quality-2 \
	finalize-idba-quality	
#----------------------------------------------Velvet Diginorm---------------------------------------------------------
velvet-diginorm: ${DIGINORM}/${PREFIX}.pe.kak.qc.fq.gz ${DIGINORM}/${PREFIX}.se.kak.qc.fq.gz
	velvet-diginorm-1 \
	finalize-velvet-diginorm 

#----------------------------------------------Spades Diginorm---------------------------------------------------------
spades-diginorm: ${DIGINORM}/${PREFIX}.pe.kak.qc.fq.gz ${DIGINORM}/${PREFIX}.se.kak.qc.fq.gz
	spades-diginorm-1 \
	spades-diginorm-2 \
	finalize-spades-diginorm	
#----------------------------------------------IDBA Diginorm----------------------------------------------------------
idba-diginorm: ${DIGINORM}/${PREFIX}.pe.kak.qc.fq.gz ${DIGINORM}/${PREFIX}.se.kak.qc.fq.gz
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

interleaving-3: ${QUALITY}/${PREFIX}.pe.qc.fq.gz 
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
	cd ${QUALITY} && python ${KHMER}/sandbox/calc-best-assembly.py ${QUALITY}/${PREFIX}.velvet.*.d/contigs.fa -o ${QUALITY}/velvet-quality-best.fa &&  python ${KHMER}/sandbox/multi-rename.py assembly  ${QUALITY}/velvet-quality-best.fa >${QUALITY}/velvet-quality-assembly.fa

#--------------------------------------------------------------SPADES QUALITY---------------------------------------------------------------------------------
spades-quality-1: ${QUALITY}/${PREFIX}.pe.qc.fq.gz 
	cd ${QUALITY} && ./spades-qc.sh \
	touch spades-quality-1

spades-quality-2:  ${QUALITY}/${PREFIX}.pe.qc.fq.gz 
	cd ${QUALITY} && /usr/bin/time -o sqc.txt spades.py --sc --pe1-12 ${QUALITY}/${PREFIX}.pe.qc.fq.gz -o ${QUALITY}/${PREFIX}.spades.d	

finalize-spades-quality: ${QUALITY}/${PREFIX}.spades.d/contigs.fasta  
	cd ${QUALITY} && python ${KHMER}/sandbox/calc-best-assembly.py ${QUALITY}/${PREFIX}.spades.d/contigs.fasta -o ${QUALITY}/spades-quality-best.fa \
	cd ${QUALITY} && python ${KHMER}/sandbox/multi-rename.py assembly ${QUALITY}/spades-quality-best.fa > ${QUALITY}/spades-quality-assembly.fa

#------------------------------------------------------------------IDBA QUALITY-------------------------------------------------------------------------------
idba-quality-1: ${QUALITY}/${PREFIX}/.pe.qc.fq.gz
	cd ${QUALITY} && ./idba-qc.sh && touch idba-quality-1

idba-quality-2: ${QUALITY}/${PREFIX}.pe.fa
	cd ${QUALITY}  && /usr/bin/time -a -o iqc.txt idba_ud --pre_correction -r ${QUALITY}/${PREFIX}.pe.fa -o ${QUALITY}/${PREFIX}.idba.d 

finalize-idba-quality: ${PREFIX}.idba.d/scaffold.fa
	cd ${QUALITY} && python ${KHMER}/sandbox/calc-best-assembly.py  ${QUALITY}/${PREFIX}.idba.d/scaffold.fa -o ${QUALITY}/idba-quality-best.fa \
	cd ${QUALITY} && python ${KHMER}/sandbox/multi-rename.py assembly  ${QUALITY}/idba-quality-best.fa > ${QUALITY}/idba-quality-assembly.fa

#----------------------------------------------------------------Megahit Quality------------------------------------------------------------------------------
megahit-qc-1: ${QUALITY}/${PREFIX}.pe.qc.fq.gz  ${QUALITY}/${PREFIX}.se.qc.fq.gz  
	/usr/bin/time  -a  -o megqc.txt python ${MEGAHIT}/megahit -l 101 -m 1e+10 --cpu-only -r ${QUALITY}/${PREFIX}.pe.qc.fq.gz -o ${QUALITY}/megahit.qc.pe \
	/usr/bin/time  -a  -o megqc.txt python ${MEGAHIT}/megahit -l 101 -m 1e+10 --cpu-only -r ${QUALITY}/${PREFIX}.se.qc.fq.gz -o ${QUALITY}/megahit.qc.se

finalize-megahit-quality: ${QUALITY}/megahit.qc.pe  ${QUALITY}/megahit.qc.se  
	cd ${QUALITY} && python ${KHMER}/sandbox/calc-best-assembly.py  ${QUALITY}/megahit.qc.*/*.fa -o ${QUALITY}/megahit-quality-best.fa \
	cd ${QUALITY} && python ${KHMER}/sandbox/multi-rename.py assembly  ${QUALITY}/megahit-quality-best.fa > ${QUALITY}/megahit-quality-assembly.fa	

#-----------------------------------------------------------------DIGINORM STARTS-----------------------------------------------------------------------------
linking-quality: 
	ln -fs ${QUALITY}/*.* ${DIGINORM}
protocol-diginorm-C20: ${QUALITY}/${PREFIX}.pe.qc.fq.gz ${QUALITY}/${PREFIX}.se.qc.fq.gz
	cd ${DIGINORM}/&& normalize-by-median.py -p -k 20 -C 20 -N 4 -x 1e9 --savetable ${DIGINORM}/normC20k20.kh  ${QUALITY}/*.pe.qc.fq.gz;\
	cd ${DIGINORM}/&& normalize-by-median.py -C 20 --loadtable ${DIGINORM}/normC20k20.kh --savetable ${DIGINORM}/normC20k20.kh ${QUALITY}/*.se.qc.fq.gz

protocol-diginorm-filter: ${DIGINORM}/normC20k20.kh
	cd ${DIGINORM}/ && filter-abund.py -V ${DIGINORM}/normC20k20.kh ${DIGINORM}/*.keep 

protocol-diginorm-extract: 
	cd ${DIGINORM}/&& extract-paired-reads.py ${DIGINORM}/${PREFIX}.*.keep.*;  #change .pe.qc.fq.gz.keep.abundfilt

protocol-diginorm-C5:
	cd ${DIGINORM}/&& normalize-by-median.py -C 5 -k 20 -N 4 -x 1e9 --savetable ${DIGINORM}/normC5k20.kh -p ${DIGINORM}/*.pe.qc.fq.gz.keep.abundfilt.pe ;\
        cd ${DIGINORM}/&& normalize-by-median.py -C 5 --savetable ${DIGINORM}/normC5k20.kh --loadtable ${DIGINORM}/normC5k20.kh ${DIGINORM}/*.pe.qc.fq.gz.keep.abundfilt.se ${DIGINORM}/*.se.qc.fq.gz.keep.abundfilt

protocol-diginorm-combine-pe-se:
	cd ${DIGINORM}/&& ./diginorm-combine-pe.sh && ./diginorm-combine-se.sh \
        touch protocol-diginorm-combine-pe-se
#----------------------------------------------------------------VELVET DIGINORM-----------------------------------------------------------------------------
velvet-diginorm-1:  
	$(foreach k, $(KSIZES),\
	  $(subst KSIZE, $k, ${DIGINORM}/${PREFIX}.velvet.KSIZE.d))

${DIGINORM}/${PREFIX}.velvet.%.d: ${DIGINORM}/${PREFIX}.pe.kak.qc.fq.gz ${DIGINORM}/${PREFIX}.se.kak.qc.fq.gz
	/usr/bin/time -a -o vdig.txt velveth $@ $* -fastq.gz -shortPaired $< -short $(word 2,$^) && velvetg $@ -exp_cov auto -cov_cutoff auto

finalize-velvet-diginorm:
	cd ${DIGINORM}/&& python ${KHMER}/sandbox/calc-best-assembly.py ${DIGINORM}/${PREFIX}.velvet.*.d/contigs.fa -o ${DIGINORM}/velvet-diginorm-best.fa 
	cd ${DIGINORM}/&& python ${KHMER}/sandbox/multi-rename.py assembly ${DIGINORM}/velvet-diginorm-best.fa > ${DIGINORM}/velvet-diginorm-assembly.fa 
#----------------------------------------------------------------SPADES DIGINORM------------------------------------------------------------------------------
spades-diginorm-1:${DIGINORM}/*.pe.kak.qc.fq.gz
	cd ${DIGINORM}/&& ./spades-dig.sh \
	touch spades-diginorm-1

spades-diginorm-2: ${DIGINORM}/${PREFIX}.pe.kak.qc.fq.gz    ${DIGINORM}/${PREFIX}.se.kak.qc.fq.gz
	cd ${DIGINORM}/&& /usr/bin/time -a -o sdig.txt spades.py --sc --pe1-12 ${DIGINORM}/${PREFIX}.pe.kak.qc.fq.gz -o ${DIGINORM}/${PREFIX}.pe.kak.qc.spades.d
	cd ${DIGINORM}/&& /usr/bin/time -a -o sdig.txt spades.py --sc --pe1-12 ${DIGINORM}/${PREFIX}.se.kak.qc.fq.gz -o ${DIGINORM}/${PREFIX}.se.kak.qc.spades.d
	
finalize-spades-diginorm:  ${DIGINORM}/${PREFIX}.spades.d/contigs.fasta 
	cd ${DIGINORM}/&& python ${KHMER}/sandbox/calc-best-assembly.py ${DIGINORM}/${PREFIX}.pe.kak.qc.spades.d/contigs.fasta -o ${DIGINORM}/spades-diginorm-best.fa
	cd ${DIGINORM}/&& python ${KHMER}/sandbox/multi-rename.py assembly ${DIGINORM}/spades-diginorm-best.fa > ${DIGINORM}/spades-diginorm-assembly.fa
#-------------------------------------------------------------------IDBA DIGINORM-----------------------------------------------------------------------------
idba-diginorm-1: ${DIGINORM}/*.pe.kak.qc.fq.gz  
	cd ${DIGINORM}/&& ./idba-dig.sh \
	touch idba-diginorm-2

idba-diginorm-2: ${DIGINORM}/${PREFIX}.pe.kak.fa 
	cd ${DIGINORM}/ &&  /usr/bin/time -a -o idig.txt idba_ud --pre_correction -r ${DIGINORM}/${PREFIX}.pe.kak.fa  -o ${DIGINORM}/${PREFIX}.idba.d

finalize-idba-diginorm: ${DIGINORM}/${PREFIX}.idba.d/scaffold.fa	
	cd ${DIGINORM}/&& python ${KHMER}/sandbox/calc-best-assembly.py  ${DIGINORM}/${PREFIX}.idba.d/scaffold.fa -o ${DIGINORM}/idba-diginorm-best.fa \
	cd ${DIGINORM}/&& python ${KHMER}/sandbox/multi-rename.py assembly  ${DIGINORM}/idba-diginorm-best.fa > ${DIGINORM}/idba-diginorm-assembly.fa
#---------------------------------------------------------------Megahit DIGINORM------------------------------------------------------------------------------
megahit-digi-1:
	/usr/bin/time  -a  -o megdigi.txt python ${MEGAHIT}/megahit -l 101 -m 1e+10 --cpu-only -r ${DIGINORM}/${PREFIX}.pe.kak.qc.fq.gz -o ${DIGINORM}/megahi.digi.pe
	/usr/bin/time  -a  -o megdigi.txt python ${MEGAHIT}/megahit -l 101 -m 1e+10 --cpu-only -r ${DIGINORM}/${PREFIX}.se.kak.qc.fq.gz -o ${DIGINORM}/megahit.digi.se

finalize-megahit-diginorm: ${QUALITY}/megahit.digi.pe  ${QUALITY}/megahit.digi.se 
        cd ${DIGINORM}/&& python ${KHMER}/sandbox/calc-best-assembly.py  ${DIGINORM}/megahit.digi.*/*.fa  -o ${DIGINORM}/megahit-diginorm-best.fa \
        cd ${DIGINORM}/&& python ${KHMER}/sandbox/multi-rename.py assembly  ${DIGINORM}/megahit-diginorm-best.fa > ${DIGINORM}/megahit-diginorm-assembly.fa
#-------------------------------------------------------------------PARTITION STARTS--------------------------------------------------------------------------
linking-diginorm: 
	 ln -fs ${DIGINORM}/*.* ${PARTITION}

protocol-partition-below: ${DIGINORM}/normC5k20.kh ${DIGINORM}/*.kak.*.fq.gz
	cd ${PARTITION} && python ${KHMER}/sandbox/filter-below-abund.py ${DIGINORM}/normC5k20.kh ${DIGINORM}/*.kak.*.fq.gz 


protocol-partition-rename-1: ${PARTITION}/${PREFIX}.pe.kak.qc.fq.gz.below  ${PARTITION}/${PREFIX}.se.kak.qc.fq.gz.below
	cd ${PARTITION} && mv ${PARTITION}/${PREFIX}.pe.kak.qc.fq.gz.below  ${PARTITION}/${PREFIX}.pe.kak.qc.fq.gz.below.fq &&  mv ${PARTITION}/${PREFIX}.se.kak.qc.fq.gz.below ${PARTITION}/${PREFIX}.se.kak.qc.fq.gz.below.fq 

protocol-partition-run: ${DIGINORM}/normC5k20.kh ${PARTITION}/${PREFIX}.pe.kak.qc.fq.gz.below.fq  ${PARTITION}/${PREFIX}.se.kak.qc.fq.gz.below.fq 
	cd ${PARTITION} && ${KHMER}/scripts/do-partition.py -k 32 -x 1e9 --threads 4 kak ${PARTITION}/*.kak.qc.fq.gz.below.fq


protocol-partition-extract: $${PARTITION}/*.part  
	cd ${PARTITION} && ${KHMER}/scripts/extract-partitions.py -X 100000 kak *.part


protocol-partition-rename-2:  
	cd ${PARTITION} && ./seperate.sh \
	touch protocol-partition-rename-2

protocol-partition-compress: 
	cd ${PARTITION} && gzip *.pe.fq  *.se.fq

#--------------------------------------------------------------------Velvet Partition-------------------------------------------------------------------------
velvet-partition-1: ${PARTITION}/kak*.pe.fq.gz  ${PARTITION}/kak*.se.fq.gz 
	cd ${PARTITION} && ./velvet-part.sh \
	touch velvet-partition-1

velvet-partition-2: ${PARTITION}/kak.group*.pe.fq.gz  ${PARTITION}/kak.group*.se.fq.gz
	cd ${PARTITION} &&  ./velvet-part-finalize.sh \
	touch velvet-partition-2
finalize-velvet-partition:
	        python ${KHMER}/sandbox/multi-rename.py assembly ${PARTITION}/velvet-partition-best.group*.fa > ${PARTITION}/velvet-partition-assembly.fa

#-------------------------------------------------------------------Spades Partition--------------------------------------------------------------------------
spades-partition-1:${PARTITION}/kak*.pe.fq.gz
	cd ${PARTITION} && ./spades-part.sh \
	touch spades-partition-1

spades-partition-2:${PARTITION}/*.pe.fq
	cd ${PARTITION} && ./spades-part-run.sh \
	touch spades-partition-2

spades-partition-3:${PARTITION}/kak.group*.pe.fq.gz
	cd ${PARTITION} && ./spades-part-finalize.sh \
	touch spades-partition-3

finalize-spades-partition: 
	python ${KHMER}/sandbox/multi-rename.py assembly ${PARTITION}/spades-partition-best.group*.fa > ${PARTITION}/spades-partition-assembly.fa
#------------------------------------------------------------------IDBA Partition-----------------------------------------------------------------------------
idba-partition-1: ${PARTITION}/kak*.pe.fq.gz
	cd ${PARTITION} && ./idba-part.sh \
	touch idba-partition-1

idba-partition-2: ${PARTITION}/*.pe.fa 
	cd ${PARTITION} && ./idba-part-run.sh \
	touch idba-partition-2

idba-partition-3:${PARTITION}/kak.group*.pe.fq.gz
	cd ${PARTITION} && ./idba-part-finalize.sh \
	touch idba-partition-3

finalize-idba-partition:
	python ${KHMER}/sandbox/multi-rename.py assembly ${PARTITION}/idba-partition-best.group*.fa > ${PARTITION}/idba-partition-assembly.fa
#--------------------------------------------------------------------Megahit PARTITION------------------------------------------------------------------------
megahit-part-1:
	cd ${PARTITION} && ./megahit-part.sh \
	touch megahit-part-1 
megahot-part-2: 
	cd ${PARTITION} && ./megahit-part-finalize.sh \
	touch megahit-part-2
finalize-megahit-partition:
	python ${KHMER}/sandbox/multi-rename.py assembly ${PARTITION}/megahit-partition-best*.fa >${PARTITION}/megahit-partition-assembly.fa

#-------------------------------------------------------------------QUAST------------------------------------------------------------------------------------
quasting-2-ref: ${QUALITY}/*-assembly.fa ${DIGINORM}/*-assembly.fa ${PARTITION}/*-assembly.fa  ${DATA}/mircea.fa.gz 
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/velvet-quality-quast/ ${QUALITY}/velvet-quality-assembly.fa \
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/idba-quality-quast/ ${QUALITY}/idba-quality-assembly.fa \
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/spades-quality-quast/ ${QUALITY}/spades-quality-assembly.fa \
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/megahit-quality-quast/ ${QUALITY}/megahit-quality-assembly.fa \
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/velvet-diginorm-quast/ ${DIGINORM}/velvet-diginorm-assembly.fa \
        python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/idba-diginorm-quast/ ${DIGINORM}/idba-diginorm-assembly.fa \
        python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/spades-diginorm-quast/ ${DIGINORM}/spades-diginorm-assembly.fa \
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/megahit-diginorm-quast/ ${DIGINORM}/megahit-diginorm-assembly.fa \
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/velvet-partition-quast/ ${PARTITION}/velvet-partition-assembly.fa \
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.ga -o ${CURRENT}/velvet-partition-quast/ ${PARTITION}/velvet-partition-assembly.fa \
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/spades-partition-quast/ ${PARTITION}/spades-partition-assembly.fa \
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/megahit-partition-quast/ ${PARTITION}/megahit-partition-assembly.fa 

quasting-2-assembly: ${QUALITY}/*-assembly.fa ${DIGINORM}/*-assembly.fa ${PARTITION}/*-assembly.fa  ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R ${QUALITY}/velvet-quality-assembly.fa -o ${CURRENT}/ref-velvet-quality-quast/ ${DATA}/mircea.fa.gz \
	python ${QUAST}/quast.py -R ${QUALITY}/idba-quality-assembly.fa -o ${CURRENT}/ref-idba-quality-quast/ ${DATA}/mircea.fa.gz \
	python ${QUAST}/quast.py -R ${QUALITY}/spades-quality-assembly.fa -o ${CURRENT}/ref-spades-quality-quast/ ${DATA}/mircea.fa.gz \
	python ${QUAST}/quast.py -R ${QUALITY}/megahit-quality-assembly.fa -o ${CURRENT}/ref-megahit-quality-quast/ ${DATA}/mircea.fa.gz \
	python ${QUAST}/quast.py -R ${DIGINORM}/velvet-diginorm-assembly.fa -o ${CURRENT}/ref-velvet-diginorm-quast/ ${DATA}/mircea.fa.gz \
        python ${QUAST}/quast.py -R ${DIGINORM}/idba-diginorm-assembly.fa -o ${CURRENT}/ref-idba-diginorm-quast/ ${DATA}/mircea.fa.gz \
        python ${QUAST}/quast.py -R ${DIGINORM}/spades-diginorm-assembly.fa -o ${CURRENT}/ref-spades-diginorm-quast/ ${DATA}/mircea.fa.gz \
        python ${QUAST}/quast.py -R ${DIGINORM}/megahit-diginorm-assembly.fa -o ${CURRENT}/ref-megahit-diginorm-quast/ ${DATA}/mircea.fa.gz \
	python ${QUAST}/quast.py -R ${PARTITION}/velvet-partition-assembly.fa -o ${CURRENT}/ref-velvet-partition-quast/ ${DATA}/mircea.fa.gz \
	python ${QUAST}/quast.py -R ${PARTITION}/idba-partition-assembly.fa -o ${CURRENT}/ref-idba-partition-quast/ ${DATA}/mircea.fa.gz \
	python ${QUAST}/quast.py -R ${PARTITION}/spades-partition-assembly.fa -o ${CURRENT}/ref-spades-partition-quast/ ${DATA}/mircea.fa.gz \
	python ${QUAST}/quast.py -R ${PARTITION}/megahit-partition-assembly.fa -o ${CURRENT}/ref-megahit-partition-quast/ ${DATA}/mircea.fa.gz

#----------------------------------------------------------------Mapping-------------------------------------------------------------------------------------
mapping-2-ref: ${QUALITY}/*-assembly.fa ${DIGINORM}/*-assembly.fa ${PARTITION}/*-assembly.fa ${QUALITY}/${PREFIX}.pe.qc.fq.gz ${QUALITY}/${PREFIX}.se.qc.fq.gz
	bwa index ${QUALITY}/velvet-quality-assembly.fa \
	bwa aln ${QUALITY}/velvet-quality-assembly.fa ${QUALITY}/${PREFIX}.pe.qc.fq.gz   > ${CURRENT}/vq.pe.sai \
	bwa aln ${QUALITY}/velvet-quality-assembly.fa ${QUALITY}/${PREFIX}.se.qc.fq.gz   > ${CURRENT}/vq.se.sai \
	bwa samse ${QUALITY}/velvet-quality-assembly.fa ${CURRENT}/vq.pe.sai ${QUALITY}/${PREFIX}.pe.qc.fq.gz > ${CURRENT}/vq.pe.sam \
	bwa samse ${QUALITY}/velvet-quality-assembly.fa ${CURRENT}/vq.se.sai ${QUALITY}/${PREFIX}.se.qc.fq.gz > ${CURRENT}/vq.se.sam \
	samtools faidx ${QUALITY}/velvet-quality-assembly.fa \
	samtools import ${QUALITY}/velvet-quality-assembly.fa.fai ${CURRENT}/vq.pe.sam ${CURRENT}/vq.pe.bam \
	samtools import ${QUALITY}/velvet-quality-assembly.fa.fai ${CURRENT}/vq.se.sam ${CURRENT}/vq.se.bam \
	python extract-unaligned.py -o ${CURRENT}/vq.pe.unaligned --format fasta ${CURRENT}/vq.pe.bam \
	python extract-unaligned.py -o ${CURRENT}/vq.se.unaligned --format fasta ${CURRENT}/vq.se.bam \
	bwa index ${DIGINORM}/velvet-diginorm-assembly.fa \
	bwa aln ${DIGINORM}/velvet-diginorm-assembly.fa ${QUALITY}/${PREFIX}.pe.qc.fq.gz   > ${CURRENT}/vd.pe.sai \
	bwa aln ${DIGINORM}/velvet-diginorm-assembly.fa ${QUALITY}/${PREFIX}.se.qc.fq.gz   > ${CURRENT}/vd.se.sai \
	bwa samse ${DIGINORM}/velvet-diginorm-assembly.fa ${CURRENT}/vd.pe.sai ${QUALITY}/${PREFIX}.pe.qc.fq.gz > ${CURRENT}/vd.pe.sam \
	bwa samse ${DIGINORM}/velvet-diginorm-assembly.fa ${CURRENT}/vd.se.sai ${QUALITY}/${PREFIX}.se.qc.fq.gz > ${CURRENT}/vd.se.sam \
	samtools faidx ${DIGINORM}/velvet-diginorm-assembly.fa \
	samtools import ${DIGINORM}/velvet-diginorm-assembly.fa.fai ${CURRENT}/vd.pe.sam ${CURRENT}/vd.pe.bam \
	samtools import ${DIGINORM}/velvet-diginorm-assembly.fa.fai ${CURRENT}/vd.se.sam ${CURRENT}/vd.se.bam \
	python extract-unaligned.py -o ${CURRENT}/vd.pe.unaligned --format fasta ${CURRENT}/vd.pe.bam \
	python extract-unaligned.py -o ${CURRENT}/vd.se.unaligned --format fasta ${CURRENT}/vd.se.bam \
	bwa index ${PARTITION}/velvet-partition-assembly.fa \ 
	bwa aln ${PARTITION}/velvet-partition-assembly.fa ${QUALITY}/${PREFIX}.pe.qc.fq.gz   > ${CURRENT}/vp.pe.sai \
	bwa aln ${PARTITION}/velvet-partition-assembly.fa ${QUALITY}/${PREFIX}.se.qc.fq.gz   > ${CURRENT}/vp.se.sai \
	bwa samse ${PARTITION}/velvet-partition-assembly.fa ${CURRENT}/vp.pe.sai ${QUALITY}/${PREFIX}.pe.qc.fq.gz > ${CURRENT}/vp.pe.sam \
	bwa samse ${PARTITION}/velvet-partition-assembly.fa ${CURRENT}/vp.se.sai ${QUALITY}/${PREFIX}.se.qc.fq.gz > ${CURRENT}/vp.se.sam \
	samtools faidx ${PARTITION}/velvet-partition-assembly.fa \
	samtools import ${PARTITION}/velvet-partition-assembly.fa.fai ${CURRENT}/vp.pe.sam ${CURRENT}/vp.pe.bam \
	samtools import ${PARTITION}/velvet-partition-assembly.fa.fai ${CURRENT}/vp.se.sam ${CURRENT}/vp.se.bam \
	python extract-unaligned.py -o ${CURRENT}/vp.pe.unaligned --format fasta ${CURRENT}/vp.pe.bam \
	python extract-unaligned.py -o ${CURRENT}/vp.se.unaligned --format fasta ${CURRENT}/vp.se.bam \
	bwa index ${QUALITY}/idba-quality-assembly.fa \
	bwa aln ${QUALITY}/idba-quality-assembly.fa ${QUALITY}/${PREFIX}.pe.qc.fq.gz   > ${CURRENT}/iq.pe.sai \
	bwa aln ${QUALITY}/idba-quality-assembly.fa ${QUALITY}/${PREFIX}.se.qc.fq.gz   > ${CURRENT}/iq.se.sai \
	bwa samse ${QUALITY}/idba-quality-assembly.fa ${CURRENT}/iq.pe.sai ${QUALITY}/${PREFIX}.pe.qc.fq.gz > ${CURRENT}/iq.pe.sam \
	bwa samse ${QUALITY}/idba-quality-assembly.fa ${CURRENT}/iq.se.sai ${QUALITY}/${PREFIX}.se.qc.fq.gz > ${CURRENT}/iq.se.sam \
	samtools faidx ${QUALITY}/idba-quality-assembly.fa \
	samtools import ${QUALITY}/idba-quality-assembly.fa.fai ${CURRENT}/iq.pe.sam ${CURRENT}/iq.pe.bam \
	samtools import ${QUALITY}/idba-quality-assembly.fa.fai ${CURRENT}/iq.se.sam ${CURRENT}/iq.se.bam \
	python extract-unaligned.py -o ${CURRENT}/iq.pe.unaligned --format fasta ${CURRENT}/iq.pe.bam \
	python extract-unaligned.py -o ${CURRENT}/iq.se.unaligned --format fasta ${CURRENT}/iq.se.bam \
	bwa index ${DIGINORM}/idba-diginorm-assembly.fa \
	bwa aln ${DIGINORM}/idba-diginorm-assembly.fa ${QUALITY}/${PREFIX}.pe.qc.fq.gz   > ${CURRENT}/id.pe.sai \
	bwa aln ${DIGINORM}/idba-diginorm-assembly.fa ${QUALITY}/${PREFIX}.se.qc.fq.gz   > ${CURRENT}/id.se.sai \
	bwa samse ${DIGINORM}/idba-diginorm-assembly.fa ${CURRENT}/id.pe.sai ${QUALITY}/${PREFIX}.pe.qc.fq.gz > ${CURRENT}/id.pe.sam \
	bwa samse ${DIGINORM}/idba-diginorm-assembly.fa ${CURRENT}/id.se.sai ${QUALITY}/${PREFIX}.se.qc.fq.gz > ${CURRENT}/id.se.sam \
	samtools faidx ${DIGINORM}/idba-diginorm-assembly.fa \
	samtools import ${DIGINORM}/idba-diginorm-assembly.fa.fai ${CURRENT}/id.pe.sam ${CURRENT}/id.pe.bam \
	samtools import ${DIGINORM}/idba-diginorm-assembly.fa.fai ${CURRENT}/id.se.sam ${CURRENT}/id.se.bam \
	python extract-unaligned.py -o ${CURRENT}/id.pe.unaligned --format fasta ${CURRENT}/id.pe.bam \
	python extract-unaligned.py -o ${CURRENT}/id.se.unaligned --format fasta ${CURRENT}/id.se.bam \
	bwa index ${PARTITION}/idba-partition-assembly.fa \
	bwa aln ${PARTITION}/idba-partition-assembly.fa ${QUALITY}/${PREFIX}.pe.qc.fq.gz   > ${CURRENT}/ip.pe.sai \
	bwa aln ${PARTITION}/idba-partition-assembly.fa ${QUALITY}/${PREFIX}.se.qc.fq.gz   > ${CURRENT}/ip.se.sai \
	bwa samse ${PARTITION}/idba-partition-assembly.fa ${CURRENT}/ip.pe.sai ${QUALITY}/${PREFIX}.pe.qc.fq.gz > ${CURRENT}/ip.pe.sam \
	bwa samse ${PARTITION}/idba-partition-assembly.fa ${CURRENT}/ip.se.sai ${QUALITY}/${PREFIX}.se.qc.fq.gz > ${CURRENT}/ip.se.sam \	
	samtools faidx ${PARTITION}/idba-partition-assembly.fa \
	samtools import ${PARTITION}/idba-partition-assembly.fa.fai ${CURRENT}/ip.pe.sam ${CURRENT}/ip.pe.bam \
	samtools import ${PARTITION}/idba-partition-assembly.fa.fai ${CURRENT}/ip.se.sam ${CURRENT}/ip.se.bam \
	python extract-unaligned.py -o ${CURRENT}/ip.pe.unaligned --format fasta ${CURRENT}/ip.pe.bam \
	python extract-unaligned.py -o ${CURRENT}/ip.se.unaligned --format fasta ${CURRENT}/ip.se.bam \
	bwa index ${QUALITY}/spades-quality-assembly.fa \
	bwa aln ${QUALITY}/spades-quality-assembly.fa ${QUALITY}/${PREFIX}.pe.qc.fq.gz   > ${CURRENT}/sq.pe.sai \
	bwa aln ${QUALITY}/spades-quality-assembly.fa ${QUALITY}/${PREFIX}.se.qc.fq.gz   > ${CURRENT}/sq.se.sai \
	bwa samse ${QUALITY}/spades-quality-assembly.fa ${CURRENT}/sq.pe.sai ${QUALITY}/${PREFIX}.pe.qc.fq.gz > ${CURRENT}/sq.pe.sam \
	bwa samse ${QUALITY}/spades-quality-assembly.fa ${CURRENT}/sq.se.sai ${QUALITY}/${PREFIX}.se.qc.fq.gz > ${CURRENT}/sq.se.sam \
	samtools faidx ${QUALITY}/spades-quality-assembly.fa \
	samtools import ${QUALITY}/spades-quality-assembly.fa.fai ${CURRENT}/sq.pe.sam ${CURRENT}/sq.pe.bam \
	samtools import ${QUALITY}/spades-quality-assembly.fa.fai ${CURRENT}/sq.se.sam ${CURRENT}/sq.se.bam \
	python extract-unaligned.py -o ${CURRENT}/sq.pe.unaligned --format fasta ${CURRENT}/sq.pe.bam \
	python extract-unaligned.py -o ${CURRENT}/sq.se.unaligned --format fasta ${CURRENT}/sq.se.bam \
	bwa index ${DIGINORM}/spades-diginorm-assembly.fa \
	bwa aln ${DIGINORM}/spades-diginorm-assembly.fa ${QUALITY}/${PREFIX}.pe.qc.fq.gz   > ${CURRENT}/sd.pe.sai \
	bwa aln ${DIGINORM}/spades-diginorm-assembly.fa ${QUALITY}/${PREFIX}.se.qc.fq.gz   > ${CURRENT}/sd.se.sai \
	bwa samse ${DIGINORM}/spades-diginorm-assembly.fa ${CURRENT}/sd.pe.sai ${QUALITY}/${PREFIX}.pe.qc.fq.gz > ${CURRENT}/sd.pe.sam \
	bwa samse ${DIGINORM}/spades-diginorm-assembly.fa ${CURRENT}/sd.se.sai ${QUALITY}/${PREFIX}.se.qc.fq.gz > ${CURRENT}/sd.se.sam \
	samtools faidx ${DIGINORM}/spades-diginorm-assembly.fa \
	samtools import ${DIGINORM}/spades-diginorm-assembly.fa.fai ${CURRENT}/sd.pe.sam ${CURRENT}/sd.pe.bam \
	samtools import ${DIGINORM}/spades-diginorm-assembly.fa.fai ${CURRENT}/sd.se.sam ${CURRENT}/sd.se.bam \
	python extract-unaligned.py -o ${CURRENT}/sd.pe.unaligned --format fasta ${CURRENT}/sd.pe.bam \
	python extract-unaligned.py -o ${CURRENT}/sd.se.unaligned --format fasta ${CURRENT}/sd.se.bam \
	bwa index ${PARTITION}/spades-partition-assembly.fa \
	bwa aln ${PARTITION}/spades-partition-assembly.fa ${QUALITY}/${PREFIX}.pe.qc.fq.gz   > ${CURRENT}/sp.pe.sai \
	bwa aln ${PARTITION}/spades-partition-assembly.fa ${QUALITY}/${PREFIX}.se.qc.fq.gz   > ${CURRENT}/sp.se.sai \
	bwa samse ${PARTITION}/spades-partition-assembly.fa ${CURRENT}/sp.pe.sai ${QUALITY}/${PREFIX}.pe.qc.fq.gz > ${CURRENT}/sp.pe.sam \
	bwa samse ${PARTITION}/spades-partition-assembly.fa ${CURRENT}/sp.se.sai ${QUALITY}/${PREFIX}.se.qc.fq.gz > ${CURRENT}/sp.se.sam \
	samtools faidx ${PARTITION}/spades-partition-assembly.fa \
	samtools import ${PARTITION}/spades-partition-assembly.fa.fai ${CURRENT}/sp.pe.sam ${CURRENT}/sp.pe.bam \
	samtools import ${PARTITION}/spades-partition-assembly.fa.fai ${CURRENT}/sp.se.sam ${CURRENT}/sp.se.bam \
	python extract-unaligned.py -o ${CURRENT}/sp.pe.unaligned --format fasta ${CURRENT}/sp.pe.bam \
	python extract-unaligned.py -o ${CURRENT}/sp.se.unaligned --format fasta ${CURRENT}/sp.se.bam \
	bwa index ${QUALITY}/megahit-quality-assembly.fa \
	bwa aln ${QUALITY}/megahit-quality-assembly.fa ${QUALITY}/${PREFIX}.pe.qc.fq.gz   > ${CURRENT}/mq.pe.sai \
	bwa aln ${QUALITY}/megahit-quality-assembly.fa ${QUALITY}/${PREFIX}.se.qc.fq.gz   > ${CURRENT}/mq.se.sai \
	bwa samse ${QUALITY}/megahit-quality-assembly.fa ${CURRENT}/mq.pe.sai ${QUALITY}/${PREFIX}.pe.qc.fq.gz > ${CURRENT}/mq.pe.sam \
	bwa samse ${QUALITY}/megahit-quality-assembly.fa ${CURRENT}/mq.se.sai ${QUALITY}/${PREFIX}.se.qc.fq.gz > ${CURRENT}/mq.se.sam \
	samtools faidx ${QUALITY}/megahit-quality-assembly.fa \
	samtools import ${QUALITY}/megahit-quality-assembly.fa.fai ${CURRENT}/mq.pe.sam ${CURRENT}/mq.pe.bam \
	samtools import ${QUALITY}/megahit-quality-assembly.fa.fai ${CURRENT}/mq.se.sam ${CURRENT}/mq.se.bam \
	python extract-unaligned.py -o ${CURRENT}/mq.pe.unaligned --format fasta ${CURRENT}/mq.pe.bam \
	python extract-unaligned.py -o ${CURRENT}/mq.se.unaligned --format fasta ${CURRENT}/mq.se.bam \
	bwa index ${DIGINORM}/megahit-diginorm-assembly.fa \
	bwa aln ${DIGINORM}/megahit-diginorm-assembly.fa ${QUALITY}/${PREFIX}.pe.qc.fq.gz   > ${CURRENT}/md.pe.sai \
	bwa aln ${DIGINORM}/megahit-diginorm-assembly.fa ${QUALITY}/${PREFIX}.se.qc.fq.gz   > ${CURRENT}/md.se.sai \
	bwa samse ${DIGINORM}/megahit-diginorm-assembly.fa ${CURRENT}/md.pe.sai ${QUALITY}/${PREFIX}.pe.qc.fq.gz > ${CURRENT}/md.pe.sam \
	bwa samse ${DIGINORM}/megahit-diginorm-assembly.fa ${CURRENT}/md.se.sai ${QUALITY}/${PREFIX}.se.qc.fq.gz > ${CURRENT}/md.se.sam \
	samtools faidx ${DIGINORM}/megahit-diginorm-assembly.fa \
	samtools import ${DIGINORM}/megahit-diginorm-assembly.fa.fai ${CURRENT}/md.pe.sam ${CURRENT}/md.pe.bam \
	samtools import ${DIGINORM}/megahit-diginorm-assembly.fa.fai ${CURRENT}/md.se.sam ${CURRENT}/md.se.bam \
	python extract-unaligned.py -o ${CURRENT}/md.pe.unaligned --format fasta ${CURRENT}/md.pe.bam \
	python extract-unaligned.py -o ${CURRENT}/md.se.unaligned --format fasta ${CURRENT}/md.se.bam \
	bwa index ${PARTITION}/megahit-partition-assembly.fa \
	bwa aln ${PARTITION}/megahit-partition-assembly.fa ${QUALITY}/${PREFIX}.pe.qc.fq.gz   > ${CURRENT}/mp.pe.sai \
	bwa aln ${PARTITION}/megahit-partition-assembly.fa ${QUALITY}/${PREFIX}.se.qc.fq.gz   > ${CURRENT}/mp.se.sai \
	bwa samse ${PARTITION}/megahit-partition-assembly.fa ${CURRENT}/mp.pe.sai ${QUALITY}/${PREFIX}.pe.qc.fq.gz > ${CURRENT}/mp.pe.sam \	
	bwa samse ${PARTITION}/megahit-partition-assembly.fa ${CURRENT}/mp.se.sai ${QUALITY}/${PREFIX}.se.qc.fq.gz > ${CURRENT}/mp.se.sam \
	samtools faidx ${PARTITION}/megahit-partition-assembly.fa \
	samtools import ${PARTITION}/megahit-partition-assembly.fa.fai ${CURRENT}/mp.pe.sam ${CURRENT}/mp.pe.bam \
	samtools import ${PARTITION}/megahit-partition-assembly.fa.fai ${CURRENT}/mp.se.sam ${CURRENT}/mp.se.bam \
	python extract-unaligned.py -o ${CURRENT}/mp.pe.unaligned --format fasta ${CURRENT}/mp.pe.bam \
	python extract-unaligned.py -o ${CURRENT}/mp.se.unaligned --format fasta ${CURRENT}/mp.se.bam \
        bash ${CURRENT}/counting.sh 

#----------------------------------------------------------Extracting Unaligned Reads-------------------------------------------------------------------------
extract-unaligned:
	python extract-unaligned-scaffolds.py ${CURRENT}/idba-quality-quast/${nucmer}/idba-quality-assembly.unaligned ${QUALITY}/idba-quality-assembly.fa > ${CURRENT}/idba-quality-unaligned.fa \
	python extract-unaligned-contigs.py ${CURRENT}/velvet-quality-quast/${nucmer}/velvet-quality-assembly.unaligned ${QUALITY}/velvet-quality-assembly.fa > ${CURRENT}/velvet-quality-unaligned.fa \ 
	python extract-unaligned-contigs.py ${CURRENT}/spades-quality-quast/${nucmer}/spades-quality-assembly.unaligned ${QUALITY}/spades-quality-assembly.fa > ${CURRENT}/spades-quality-unaligned.fa \
	python extract-unaligned-contigs.py ${CURRENT}/megahit-quality-quast/${nucmer}/megahit-quality-assembly.unaligned ${QUALITY}/megahit-quality-assembly.fa  >${CURRENT}/megahit-quality-unaligned.fa \
	python extract-unaligned-scaffolds.py ${CURRENT}/idba-diginorm-quast/${nucmer}/idba-diginorm-assembly.unaligned ${QUALITY}/idba-diginorm-assembly.fa > ${CURRENT}/idba-diginorm-unaligned.fa \
	python extract-unaligned-contigs.py ${CURRENT}/velvet-diginorm-quast/${nucmer}/velvet-diginorm-assembly.unaligned ${QUALITY}/velvet-diginorm-assembly.fa > ${CURRENT}/velvet-diginorm-unaligned.fa \
	python extract-unaligned-contigs.py ${CURRENT}/spades-diginorm-quast/${nucmer}/spades-diginorm-assembly.unaligned ${QUALITY}/spades-diginorm-assembly.fa > ${CURRENT}/spades-diginorm-unaligned.fa \
	python extract-unaligned-contigs.py ${CURRENT}/megahit-diginorm-quast/${nucmer}/megahit-diginorm-assembly.unaligned ${QUALITY}/megahit-diginorm-assembly.fa  >${CURRENT}/megahit-diginorm-unaligned.fa \
	python extract-unaligned-scaffolds.py ${CURRENT}/idba-partition-quast/${nucmer}/idba-partition-assembly.unaligned ${QUALITY}/idba-partition-assembly.fa > ${CURRENT}/idba-partition-unaligned.fa \
	python extract-unaligned-contigs.py ${CURRENT}/velvet-partition-quast/${nucmer}/velvet-partition-assembly.unaligned ${QUALITY}/velvet-partition-assembly.fa > ${CURRENT}/velvet-partition-unaligned.fa \
	python extract-unaligned-contigs.py ${CURRENT}/spades-partition-quast/${nucmer}/spades-partition-assembly.unaligned ${QUALITY}/spades-partition-assembly.fa > ${CURRENT}/spades-partition-unaligned.fa \
	python extract-unaligned-contigs.py ${CURRENT}/megahit-partition-quast/${nucmer}/megahit-partition-assembly.unaligned ${QUALITY}/megahit-partition-assembly.fa  >${CURRENT}/megahit-partition-unaligned.fa

#-------------------------------------------------Blasting Unligned Reads to Fusa Seeds----------------------------------------------------------------------
unaligned-fusa: ${CURRENT}/fusA.seeds ${CURRENT}/*-unaligned.fa 
	formatdb -i fusA.seeds  -p F 
	blastall -p blastn -d ${DATA}/fusA.seeds -i ${CURRENT}/velvet-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/vqu \
	blastall -p blastn -d ${DATA}/fusA.seeds -i ${CURRENT}/velvet-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/vdu \
	blastall -p blastn -d ${DATA}/fusA.seeds -i ${CURRENT}/velvet-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/vpu \
	blastall -p blastn -d ${DATA}/fusA.seeds -i ${CURRENT}/idba-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/iqu \
	blastall -p blastn -d ${DATA}/fusA.seeds -i ${CURRENT}/idba-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/idu \
	blastall -p blastn -d ${DATA}/fusA.seeds -i ${CURRENT}/idba-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/ipu \
	blastall -p blastn -d ${DATA}/fusA.seeds -i ${CURRENT}/spades-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/squ \
	blastall -p blastn -d ${DATA}/fusA.seeds -i ${CURRENT}/spades-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/sdu \
	blastall -p blastn -d ${DATA}/fusA.seeds -i ${CURRENT}/spades-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/spu \
	blastall -p blastn -d ${DATA}/fusA.seeds -i ${CURRENT}/megahit-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/mqu \
	blastall -p blastn -d ${DATA}/fusA.seeds -i ${CURRENT}/megahit-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/mdu \
	blastall -p blastn -d ${DATA}/fusA.seeds -i ${CURRENT}/megahit-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/mpu

#-------------------------------------------------Blasting Unaligned Reads to QC reads-----------------------------------------------------------------------
unaligned-to-qc:  ${QUALITY}/${PREFIX}.pe.qc.fq.gz ${QUALITY}/${PREFIX}.se.qc.fq.gz ${CURRENT}/*-unaligned.fa
	cat ${QUALITY}/${PREFIX}.pe.qc.fq.gz ${QUALITY}/${PREFIX}.se.qc.fq.gz >${CURRENT}/${PREFIX}.qc.fq.gz \
	gunzip -c ${CURRENT}/${PREFIX}.qc.fq.gz > ${CURRENT}/${PREFIX}.qc \
	formatdb -i ${CURRENT}/${PREFIX}.qc -p F
	blastall -p blastn -d ${CURRENT}/${PREFIX}.qc -i ${CURRENT}/velvet-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/Qvqu \
	blastall -p blastn -d ${CURRENT}/${PREFIX}.qc -i ${CURRENT}/velvet-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/Qvdu \
	blastall -p blastn -d ${CURRENT}/${PREFIX}.qc -i ${CURRENT}/velvet-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/Qvpu \
	blastall -p blastn -d ${CURRENT}/${PREFIX}.qc -i ${CURRENT}/idba-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/Qiqu \
	blastall -p blastn -d ${CURRENT}/${PREFIX}.qc -i ${CURRENT}/idba-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/Qidu \
	blastall -p blastn -d ${CURRENT}/${PREFIX}.qc -i ${CURRENT}/idba-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/Qipu \
	blastall -p blastn -d ${CURRENT}/${PREFIX}.qc -i ${CURRENT}/spades-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/Qsqu \
	blastall -p blastn -d ${CURRENT}/${PREFIX}.qc -i ${CURRENT}/spades-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/Qsdu \
	blastall -p blastn -d ${CURRENT}/${PREFIX}.qc -i ${CURRENT}/spades-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/Qspu \
	blastall -p blastn -d ${CURRENT}/${PREFIX}.qc -i ${CURRENT}/megahit-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/Qmqu \
	blastall -p blastn -d ${CURRENT}/${PREFIX}.qc -i ${CURRENT}/megahit-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/Qmdu \
	blastall -p blastn -d ${CURRENT}/${PREFIX}.qc -i ${CURRENT}/megahit-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/Qmpu

#-------------------------------------------------Blasting Unaligned Reads to Reference-----------------------------------------------------------------------
unaligned-ref: ${CURRENT}/mircea.fa ${CURRENT}/*-unaligned.fa
	gunzip -c ${DATA}/mircea.fa.gz >${DATA}/mircea.fa \
	formatdb -i ${DATA}/mircea.fa  -p F \
	blastall -p blastn -d ${DATA}/mircea.fa -i ${CURRENT}/velvet-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/Refvqu \
	blastall -p blastn -d ${DATA}/mircea.fa -i ${CURRENT}/velvet-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/Refvdu \
	blastall -p blastn -d ${DATA}/mircea.fa -i ${CURRENT}/velvet-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/Refvpu \
	blastall -p blastn -d ${DATA}/mircea.fa -i ${CURRENT}/idba-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/Refiqu \
	blastall -p blastn -d ${DATA}/mircea.fa -i ${CURRENT}/idba-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/Refidu \
	blastall -p blastn -d ${DATA}/mircea.fa -i ${CURRENT}/idba-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/Refipu \
	blastall -p blastn -d ${DATA}/mircea.fa -i ${CURRENT}/spades-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/Refsqu \
	blastall -p blastn -d ${DATA}/mircea.fa -i ${CURRENT}/spades-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/Refsdu \
	blastall -p blastn -d ${DATA}/mircea.fa -i ${CURRENT}/spades-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/Refspu \
	blastall -p blastn -d ${DATA}/mircea.fa -i ${CURRENT}/megahit-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/Refmqu \
	blastall -p blastn -d ${DATA}/mircea.fa -i ${CURRENT}/megahit-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/Refmdu \
	blastall -p blastn -d ${DATA}/mircea.fa -i ${CURRENT}/megahit-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o ${CURRENT}/Refmpu	
#---------------------------------------Quasting Unaligned reads to Unaligned IDBA reads ---------------------------------------------------------------------
unaligned-idba-unaligned:
	python ${QUAST}/quast.py -R ${CURRENT}/idba-quality-unaligned.fa -o ${CURRENT}/velvet-quality-unaligned/ ${CURRENT}/velvet-quality-unaligned.fa \
	python ${QUAST}/quast.py -R ${CURRENT}/idba-quality-unaligned.fa -o ${CURRENT}/velvet-diginorm-unaligned/ ${CURRENT}/velvet-diginorm-unaligned.fa \   
	python ${QUAST}/quast.py -R ${CURRENT}/idba-quality-unaligned.fa -o ${CURRENT}/velvet-partition-unaligned/ ${CURRENT}/velvet-partition-unaligned.fa \ 
	python ${QUAST}/quast.py -R ${CURRENT}/idba-quality-unaligned.fa -o ${CURRENT}/idba-diginorm-unaligned/ ${CURRENT}/idba-diginorm-unaligned.fa \
	python ${QUAST}/quast.py -R ${CURRENT}/idba-quality-unaligned.fa -o ${CURRENT}/idba-partition-unaligned/ ${CURRENT}/idba-partition-unaligned.fa \
	python ${QUAST}/quast.py -R ${CURRENT}/idba-quality-unaligned.fa -o ${CURRENT}/spades-quality-unaligned/ ${CURRENT}/spades-quality-unaligned.fa \
	python ${QUAST}/quast.py -R ${CURRENT}/idba-quality-unaligned.fa -o ${CURRENT}/spades-diginorm-unaligned/ ${CURRENT}/spades-diginorm-unaligned.fa \
	python ${QUAST}/quast.py -R ${CURRENT}/idba-quality-unaligned.fa -o ${CURRENT}/spades-partition-unaligned/ ${CURRENT}/spades-partition-unaligned.fa \
	python ${QUAST}/quast.py -R ${CURRENT}/idba-quality-unaligned.fa -o ${CURRENT}/megahit-quality-unaligned/ ${CURRENT}/megahit-quality-unaligned.fa \
	python ${QUAST}/quast.py -R ${CURRENT}/idba-quality-unaligned.fa -o ${CURRENT}/megahit-diginorm-unaligned/ ${CURRENT}/megahit-diginorm-unaligned.fa \ 
	python ${QUAST}/quast.py -R ${CURRENT}/idba-quality-unaligned.fa -o ${CURRENT}/megahit-partition-unaligned/ ${CURRENT}/megahit-partition-unaligned.fa

#----------------------------------------------------Trying Different min-contig in QUAST parameters ---------------------------------------------------------
change-min-contig:
	$(foreach i,$(mc),python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o vqc-conting-$(i)/ ${QUALITY}/velvet-quality-assembly.fa --min-contig=$(i); ) 
	$(foreach i,$(mc),python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o iqc-conting-$(i)/ ${QUALITY}/idba-quality-assembly.fa --min-contig=$(i); )  
	$(foreach i,$(mc),python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o sqc-conting-$(i)/ ${QUALITY}/spades-quality-assembly.fa --min-contig=$(i); ) 
	$(foreach i,$(mc),python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o mqc-conting-$(i)/ ${QUALITY}/megahit-quality-assembly.fa --min-contig=$(i); )
 
#------------------------------------------------------------Finding Chimeric Reads--------------------------------------------------------------------------
chimeric:  ${DATA}/mircea.fa  ${QUALITY}/${PREFIX}.se.qc.fq.gz  ${QUALITY}/${PREFIX}.pe.qc.fq.gz
	bwa mem -M -t 16 ${DATA}/mircea.fa  ${QUALITY}/${PREFIX}.se.qc.fq.gz  > ${CURRENT}/${PREFIX}-se.sam \
	bwa mem -M -t 16 ${DATA}/mircea.fa  ${QUALITY}/${PREFIX}.pe.qc.fq.gz  > ${CURRENT}/${PREFIX}-pe.sam \
	samtools faidx ${DATA}/mircea.fa \
	samtools import ${CURRENT}/mircea.fa.fai  ${CURRENT}/${PREFIX}-pe.sam ${CURRENT}/${PREFIX}-pe.bam \
	samtools import ${CURRENT}/mircea.fa.fai  ${CURRENT}/${PREFIX}-se.sam ${CURRENT}/${PREFIX}-se.bam \
	samtools view ${CURRENT}/${PREFIX}-pe.bam | grep 'SA:'  > ${CURRENT}/${PREFIX}-pe.chimeric \
	samtools view ${CURRENT}/${PREFIX}-se.bam | grep 'SA:'  > ${CURRENT}/${PREFIX}-se.chimeric \
	bash ${CURRENT}/count-chimeric.sh 

#----------------------------------------------------------------Cleaning ------------------------------------------------------------------------------------	
clean: ${CURRENT}/*.list ${CURRENT}/*.list.unique
	rm *.list 
	rm *.list.unique  
