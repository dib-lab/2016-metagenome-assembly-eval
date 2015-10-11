DATA = /mnt/research/ged/sherine
CURRENT = /mnt/research/ged/sherine/check-unaligned
MYSCRIPTS = /mnt/home/mahmoud4/scripts
NUCMER = contigs_reports/nucmer_output
PREFIX = SRR606249
KSIZE = 19 51
mc= 0 250 500 750 1000 2000
KSIZE = 19 21 23 25 27 29 31 33 35 37 39 41 43 45 47 49 51
KAK=kak
MEGAHIT=/mnt/home/mahmoud4/megahit
TRIM = /opt/software/Trimmomatic/0.32
TOOLKIT =/opt/software/FASTX/0.0.14--GCC-4.4.5/bin/
SANDBOX = /opt/software/khmer/khmer-1.4
SCRIPTS =/opt/software/khmer/khmer-1.4/scripts
QUAST = ~/quast-2.3
#--------------------------------------------------------------------------------------------------------------------------------
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

#--------------------------------------------------------------------------------------------------------------------------------
sampling: ${DATA}/SRR606429-1.fastq.gz ${DATA}/SRR606429-1.fastq.gz
	gunzip -c SRR606249_1.fastq.gz | head -40000 |gzip > spodar-1.fastq.gz	
	gunzip -c SRR606249_2.fastq.gz | head -40000 |gzip > spodar-2.fastq.gz
#--------------------------------------------------------------------------------------------------------------------------------
quality: ${DATA}/${PREFIX}-1.fastq.gz  ${DATA}/${PREFIX}-2.fastq.gz 
	interleaving-1
	interleaving-2
	interleaving-3
	protocol-quality-rename-1
	protocol-quality-rename-2 	
#--------------------------------------------------------------------------------------------------------------------------------
diginorm: ${CURRENT}/${PREFIX}.pe.qc.fq.gz ${CURRENT}/${PREFIX}.se.qc.fq.gz 
	linking-quality \
        protocol-diginorm-C20 \
        protocol-diginorm-filter \
        protocol-diginorm-extract \
        protocol-diginorm-C5 \
	protocol-diginorm-combine-pe-se
#--------------------------------------------------------------------------------------------------------------------------------
partition: ${DIGINORM}/${PREFIX}.pe.kak.qc.fq.gz ${DIGINORM}/${PREFIX}.se.kak.qc.fq.gz 
	linking-diginorm \
	protocol-partition-below \
	protocol-partition-rename-1 \
	protocol-partition-run \
	protocol-partition-extract \
	protocol-partition-rename-2 \
	protocol-partition-compress 

#--------------------------------------------Velvet Quality--------------------------------------------------------
velvet-quality:  ${PREFIX}.pe.qc.fq.gz ${PREFIX}.se.qc.fq.gz 
	velvet-quality-1 \
	finalize-velvet-quality
#--------------------------------------------Spades Quality--------------------------------------------------------
spades-quality:  ${PREFIX}.pe.qc.fq.gz ${PREFIX}.se.qc.fq.gz 
	spades-quality-1 \
	spades-quality-2 \
	finalize-spades-quality
#---------------------------------------------IDBA Quality---------------------------------------------------------
idba-quality:  ${PREFIX}.pe.qc.fq.gz ${PREFIX}.se.qc.fq.gz 
	idba-quality-1 \
	idba-quality-2 \
	finalize-idba-quality	
#----------------------------------------------Velvet Diginorm---------------------------------------------------------
velvet-diginorm:
	velvet-diginorm-1
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
	java -jar ${TRIM}/trimmomatic-0.32.jar PE ${DATA}/${PREFIX}-1.fastq.gz  ${DATA}/${PREFIX}-2.fastq.gz  s1_pe s1_se s2_pe s2_se ILLUMINACLIP:${TRIM}/adapters/TruSeq2-PE.fa:2:30:12 
	${SCRIPTS}/interleave-reads.py s1_pe s2_pe | gzip -9c > ${PREFIX}.pe.fq.gz 
	cat s1_se s2_se | gzip -9c > ${PREFIX}.se.fq.gz

interleaving-2: ${PREFIX}.se.fq.gz ${PREFIX}.pe.fq.gz
	gunzip -c ${PREFIX}.pe.fq.gz | ${TOOLKIT}/fastq_quality_filter -Q33 -q 30 -p 50 | gzip -9c > ${PREFIX}.pe.qc.fq.gz 
	gunzip -c ${PREFIX}.se.fq.gz | ${TOOLKIT}/fastq_quality_filter -Q33 -q 30 -p 50 | gzip -9c > ${PREFIX}.se.qc.fq.gz

interleaving-3: ${PREFIX}.pe.qc.fq.gz 
	extract-paired-reads.py ${PREFIX}.pe.qc.fq.gz 

protocol-quality-rename-1: ${PREFIX}.pe.qc.fq.gz.pe
	./qc-rename-1.sh 
	touch protocol-quality-rename-1


protocol-quality-rename-2: ${PREFIX}.pe.qc.fq.gz.se 
	./qc-rename-2.sh 
	touch protocol-quality-rename-2
#----------------------------------------------------------------VELVET QUALITY ------------------------------------------------------------------------------
velvet-quality-1:  
	./velvet-qc.sh 
	touch velvet-quality-1

finalize-velvet-quality: 
	python ${SANDBOX}/sandbox/calc-best-assembly.py ${PREFIX}.velvet.qc.*.d/contigs.fa -o velvet-quality-best.fa
	python ${SANDBOX}/sandbox/multi-rename.py assembly  velvet-quality-best.fa > velvet-quality-assembly.fa

#--------------------------------------------------------------SPADES QUALITY---------------------------------------------------------------------------------
spades-quality-1: ${PREFIX}.pe.qc.fq.gz 
	./spades-qc.sh \
	touch spades-quality-1

spades-quality-2:  ${PREFIX}.pe.qc.fq.gz 
	/usr/bin/time -a -o sqc.txt spades.py --sc --pe1-12 ${PREFIX}.pe.qc.fq.gz -o ${PREFIX}.spades.d	

finalize-spades-quality: ${PREFIX}.spades.d/contigs.fasta  
	python ${SANDBOX}/sandbox/calc-best-assembly.py ${PREFIX}.spades.d/contigs.fasta -o spades-quality-best.fa
	python ${SANDBOX}/sandbox/multi-rename.py assembly spades-quality-best.fa > spades-quality-assembly.fa

#------------------------------------------------------------------IDBA QUALITY-------------------------------------------------------------------------------
idba-quality-1: ${PREFIX}.pe.qc.fq.gz
	./idba-qc.sh && touch idba-quality-1

idba-quality-2: ${PREFIX}.pe.fa
	/usr/bin/time -a -o iqc.txt idba_ud --pre_correction -r ${PREFIX}.pe.fa -o ${PREFIX}.idba.d.qc 

finalize-idba-quality: ${PREFIX}.idba.d.qc/scaffold.fa
	python ${SANDBOX}/sandbox/calc-best-assembly.py ${PREFIX}.idba.d.qc/scaffold.fa -o idba-quality-best.fa 
	python ${SANDBOX}/sandbox/multi-rename.py assembly idba-quality-best.fa > idba-quality-assembly.fa

#----------------------------------------------------------------Megahit Quality------------------------------------------------------------------------------
megahit-qc-1: ${PREFIX}.pe.qc.fq.gz ${PREFIX}.se.qc.fq.gz  
	/usr/bin/time  -a  -o megqc.txt python ${MEGAHIT}/megahit -l 101 -m 1e+10 --cpu-only -r ${PREFIX}.pe.qc.fq.gz -o megahit.qc.pe \
	/usr/bin/time  -a  -o megqc.txt python ${MEGAHIT}/megahit -l 101 -m 1e+10 --cpu-only -r ${PREFIX}.se.qc.fq.gz -o megahit.qc.se

finalize-megahit-quality:  
	python ${SANDBOX}/sandbox/calc-best-assembly.py megahit.qc.?e/final.contigs.fa -o megahit-quality-best.fa
	python ${SANDBOX}/sandbox/multi-rename.py assembly megahit-quality-best.fa > megahit-quality-assembly.fa	

#-----------------------------------------------------------------DIGINORM STARTS-----------------------------------------------------------------------------
protocol-diginorm-C20: ${PREFIX}.pe.qc.fq.gz ${PREFIX}.se.qc.fq.gz
	normalize-by-median.py -p -k 20 -C 20 -N 4 -x 1e9 --savetable normC20k20.kh *.pe.qc.fq.gz
	normalize-by-median.py -C 20 --loadtable normC20k20.kh --savetable normC20k20.kh *.se.qc.fq.gz

protocol-diginorm-filter: normC20k20.kh
	filter-abund.py -V normC20k20.kh *.keep 

protocol-diginorm-extract: 
	./extract.sh 
	touch protocol-diginorm-extract
protocol-diginorm-C5:
	normalize-by-median.py -C 5 -k 20 -N 4 -x 1e9 --savetable normC5k20.kh -p *.pe.qc.fq.gz.keep.abundfilt.pe 
	normalize-by-median.py -C 5 --savetable normC5k20.kh --loadtable normC5k20.kh *.pe.qc.fq.gz.keep.abundfilt.se *.se.qc.fq.gz.keep.abundfilt

protocol-diginorm-combine-pe-se:
	./diginorm-combine-pe.sh && ./diginorm-combine-se.sh \
        touch protocol-diginorm-combine-pe-se
#----------------------------------------------------------------VELVET DIGINORM-----------------------------------------------------------------------------
velvet-diginorm-1: $(foreach k,$(KSIZE),$(subst KSIZE,$k,${PREFIX}.velvet.digi.KSIZE.d))

${PREFIX}.velvet.digi.%.d: ${PREFIX}.pe.kak.qc.fq.gz ${PREFIX}.se.kak.qc.fq.gz 
	/usr/bin/time -a -o vdig.txt velveth $@ $* -fastq.gz -shortPaired $< -short $(word 2,$^) && velvetg $@ -exp_cov auto -cov_cutoff auto

finalize-velvet-diginorm:
	python ${SANDBOX}/sandbox/calc-best-assembly.py ${PREFIX}.velvet.digi.*.d/contigs.fa -o velvet-diginorm-best.fa 
	python ${SANDBOX}/sandbox/multi-rename.py assembly velvet-diginorm-best.fa > velvet-diginorm-assembly.fa 
#----------------------------------------------------------------SPADES DIGINORM------------------------------------------------------------------------------
spades-diginorm-1:
	./spades-dig.sh \
	touch spades-diginorm-1

spades-diginorm-2: 
	spades.py --sc --pe1-s ${PREFIX}.pe.kak.qc.fq -o ${PREFIX}.pe.kak.qc.spades.d
	
finalize-spades-diginorm:   
	python ${SANDBOX}/sandbox/calc-best-assembly.py ${PREFIX}.pe.kak.qc.spades.d/contigs.fasta -o spades-diginorm-best.fa
	python ${SANDBOX}/sandbox/multi-rename.py assembly spades-diginorm-best.fa > spades-diginorm-assembly.fa
#-------------------------------------------------------------------IDBA DIGINORM-----------------------------------------------------------------------------
idba-diginorm-1: *.pe.kak.qc.fq.gz  
	./idba-dig.sh \
	touch idba-diginorm-2

idba-diginorm-2: ${PREFIX}.pe.kak.fa 
	/usr/bin/time -a -o idig.txt idba_ud --pre_correction -r ${PREFIX}.pe.kak.fa  -o ${PREFIX}.idba.d.digi

finalize-idba-diginorm: ${PREFIX}.idba.d.digi/scaffold.fa	
	python ${SANDBOX}/sandbox/calc-best-assembly.py ${PREFIX}.idba.d.digi/scaffold.fa -o idba-diginorm-best.fa
	python ${SANDBOX}/sandbox/multi-rename.py assembly idba-diginorm-best.fa > idba-diginorm-assembly.fa
#---------------------------------------------------------------Megahit DIGINORM------------------------------------------------------------------------------
megahit-digi-1:
	/usr/bin/time  -a  -o megdigi.txt python ${MEGAHIT}/megahit -l 101 -m 1e+10 --cpu-only -r ${PREFIX}.pe.kak.qc.fq.gz -o megahit.digi.pe
	/usr/bin/time  -a  -o megdigi.txt python ${MEGAHIT}/megahit -l 101 -m 1e+10 --cpu-only -r ${PREFIX}.se.kak.qc.fq.gz -o megahit.digi.se

finalize-megahit-diginorm: 
	python ${SANDBOX}/sandbox/calc-best-assembly.py megahit.digi.?e/final.contigs.fa  -o megahit-diginorm-best.fa
	python ${SANDBOX}/sandbox/multi-rename.py assembly megahit-diginorm-best.fa > megahit-diginorm-assembly.fa
#-------------------------------------------------------------------PARTITION STARTS--------------------------------------------------------------------------
protocol-partition-below: 
	python ${SANDBOX}/sandbox/filter-below-abund.py normC5k20.kh *.kak.*.fq.gz 


protocol-partition-rename-1: 
	mv ${PREFIX}.pe.kak.qc.fq.gz.below  ${PREFIX}.pe.kak.qc.fq.gz.below.fq &&  mv ${PREFIX}.se.kak.qc.fq.gz.below ${PREFIX}.se.kak.qc.fq.gz.below.fq 

protocol-partition-run: 
	do-partition.py -k 32 -x 1e9 --threads 4 kak *.kak.qc.fq.gz.below.fq


protocol-partition-extract:  
	extract-partitions.py -X 100000 kak *.part


protocol-partition-rename-2:  
	./seperate.sh \
	touch protocol-partition-rename-2

protocol-partition-compress: 
	gzip *.pe.fq  *.se.fq

#-----------------------------------Velvet Partition-------------------------------------------------------------------------
velvet-partition-1:  
	./velvet-part.sh \
	touch velvet-partition-1

velvet-partition-2: 
	./velvet-part-finalize.sh \
	touch velvet-partition-2
finalize-velvet-partition:
	        python ${SANDBOX}/sandbox/multi-rename.py assembly velvet-partition-best.group*.fa > velvet-partition-assembly.fa

#-------------------------------------------------------------------Spades Partition--------------------------------------------------------------------------
spades-partition-1: kak*.pe.fq.gz
	./spades-part.sh \
	touch spades-partition-1

spades-partition-2: *.pe.fq
	./spades-part-run.sh \
	touch spades-partition-2

spades-partition-3: kak.group*.pe.fq.gz
	./spades-part-finalize.sh \
	touch spades-partition-3

finalize-spades-partition: 
	python ${SANDBOX}/sandbox/multi-rename.py assembly spades-partition-best.group*.fa > spades-partition-assembly.fa
#------------------------------------------------------------------IDBA Partition-----------------------------------------------------------------------------
idba-partition-1: 
	./idba-part.sh \
	touch idba-partition-1

idba-partition-2: 
	./idba-part-run.sh \
	touch idba-partition-2

idba-partition-3: 
	./idba-part-finalize.sh \
	touch idba-partition-3

finalize-idba-partition:
	python ${SANDBOX}/sandbox/multi-rename.py assembly idba-partition-best.group*.fa > idba-partition-assembly.fa
#--------------------------------------------------------------------Megahit PARTITION------------------------------------------------------------------------
megahit-part-1: 
	./megahit-part.sh \
	touch megahit-part-1

megahit-part-2:
	./megahit-part-finalize.sh \
	touch megahit-part-2
finalize-megahit-partition:
	python ${SANDBOX}/sandbox/multi-rename.py assembly megahit-partition-best*.fa > megahit-partition-assembly.fa

#-------------------------------------------------------------------QUAST------------------------------------------------------------------------------------
quasting-2-ref: *-assembly.fa   ${DATA}/mircea.fa.gz 
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/velvet-quality-quast/ ${CURRENT}/velvet-quality-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/idba-quality-quast/ ${CURRENT}/idba-quality-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/spades-quality-quast/ ${CURRENT}/spades-quality-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/megahit-quality-quast/ ${CURRENT}/megahit-quality-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/velvet-diginorm-quast/ ${CURRENT}/velvet-diginorm-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/idba-diginorm-quast/ ${CURRENT}/idba-diginorm-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/spades-diginorm-quast/ ${CURRENT}/spades-diginorm-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/megahit-diginorm-quast/ ${CURRENT}/megahit-diginorm-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/velvet-partition-quast/ ${CURRENT}/velvet-partition-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.ga -o ${CURRENT}/velvet-partition-quast/ ${CURRENT}/velvet-partition-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/spades-partition-quast/ ${CURRENT}/spades-partition-assembly.fa
	python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o ${CURRENT}/megahit-partition-quast/ ${CURRENT}/megahit-partition-assembly.fa 

quasting-2-assembly: *-assembly.fa ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R ${CURRENT}/velvet-quality-assembly.fa -o ref-velvet-quality-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R ${CURRENT}/idba-quality-assembly.fa -o ref-idba-quality-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R ${CURRENT}/spades-quality-assembly.fa -o ref-spades-quality-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R ${CURRENT}/megahit-quality-assembly.fa -o ref-megahit-quality-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R ${CURRENT}/velvet-diginorm-assembly.fa -o ref-velvet-diginorm-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R ${CURRENT}/idba-diginorm-assembly.fa -o ref-idba-diginorm-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R ${CURRENT}/spades-diginorm-assembly.fa -o ref-spades-diginorm-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R ${CURRENT}/megahit-diginorm-assembly.fa -o ref-megahit-diginorm-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R ${CURRENT}/velvet-partition-assembly.fa -o ref-velvet-partition-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R ${CURRENT}/idba-partition-assembly.fa -o ref-idba-partition-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R ${CURRENT}/spades-partition-assembly.fa -o ref-spades-partition-quast/ ${DATA}/mircea.fa.gz
	python ${QUAST}/quast.py -R ${CURRENT}/megahit-partition-assembly.fa -o ref-megahit-partition-quast/ ${DATA}/mircea.fa.gz
#----------------------------------------------------------------Mapping-------------------------------------------------------------------------------------
reads-to-vqc: ${CURRENT}/${PREFIX}.pe.qc.fq.gz ${CURRENT}/${PREFIX}.se.qc.fq.gz ${CURRENT}/velvet-quality-assembly.fa
	bwa index ${CURRENT}/velvet-quality-assembly.fa 
	bwa aln ${CURRENT}/velvet-quality-assembly.fa ${CURRENT}/${PREFIX}.pe.qc.fq.gz > ${CURRENT}/vq.pe.sai 
	bwa aln ${CURRENT}/velvet-quality-assembly.fa ${CURRENT}/${PREFIX}.se.qc.fq.gz > ${CURRENT}/vq.se.sai 
	bwa samse ${CURRENT}/velvet-quality-assembly.fa ${CURRENT}/vq.pe.sai ${CURRENT}/${PREFIX}.pe.qc.fq.gz > ${CURRENT}/vq.pe.sam 
	bwa samse ${CURRENT}/velvet-quality-assembly.fa ${CURRENT}/vq.se.sai ${CURRENT}/${PREFIX}.se.qc.fq.gz > ${CURRENT}/vq.se.sam 
	samtools faidx ${CURRENT}/velvet-quality-assembly.fa 
	samtools import ${CURRENT}/velvet-quality-assembly.fa.fai ${CURRENT}/vq.pe.sam ${CURRENT}/vq.pe.bam 
	samtools import ${CURRENT}/velvet-quality-assembly.fa.fai ${CURRENT}/vq.se.sam ${CURRENT}/vq.se.bam 
	cat ${CURRENT}/vq.pe.bam ${CURRENT}/vq.se.bam > ${CURRENT}/vq.bam 
	cat ${CURRENT}/vq.pe.sam ${CURRENT}/vq.se.sam > ${CURRENT}/vq.sam 

reads-to-vdigi: ${CURRENT}/${PREFIX}.pe.qc.fq.gz ${CURRENT}/${PREFIX}.se.qc.fq.gz  ${CURRENT}/velvet-diginorm-assembly.fa 
	bwa index ${CURRENT}/velvet-diginorm-assembly.fa
	bwa aln ${CURRENT}/velvet-diginorm-assembly.fa ${CURRENT}/${PREFIX}.pe.qc.fq.gz   > ${CURRENT}/vd.pe.sai 
	bwa aln ${CURRENT}/velvet-diginorm-assembly.fa ${CURRENT}/${PREFIX}.se.qc.fq.gz   > ${CURRENT}/vd.se.sai 
	bwa samse ${CURRENT}/velvet-diginorm-assembly.fa ${CURRENT}/vd.pe.sai ${CURRENT}/${PREFIX}.pe.qc.fq.gz > ${CURRENT}/vd.pe.sam 
	bwa samse ${CURRENT}/velvet-diginorm-assembly.fa ${CURRENT}/vd.se.sai ${CURRENT}/${PREFIX}.se.qc.fq.gz > ${CURRENT}/vd.se.sam 
	samtools faidx ${CURRENT}/velvet-diginorm-assembly.fa 
	samtools import ${CURRENT}/velvet-diginorm-assembly.fa.fai ${CURRENT}/vd.pe.sam ${CURRENT}/vd.pe.bam 
	samtools import ${CURRENT}/velvet-diginorm-assembly.fa.fai ${CURRENT}/vd.se.sam ${CURRENT}/vd.se.bam
	cat ${CURRENT}/vd.pe.sam ${CURRENT}/vd.se.sam > ${CURRENT}/vd.sam 
	cat ${CURRENT}/vd.pe.bam ${CURRENT}/vd.se.bam > ${CURRENT}/vd.bam

reads-to-vpart: ${CURRENT}/${PREFIX}.pe.qc.fq.gz ${CURRENT}/${PREFIX}.se.qc.fq.gz ${CURRENT}/velvet-partition-assembly.fa 
	bwa index ${CURRENT}/velvet-partition-assembly.fa 
	bwa aln ${CURRENT}/velvet-partition-assembly.fa ${CURRENT}/${PREFIX}.pe.qc.fq.gz   > ${CURRENT}/vp.pe.sai 
	bwa aln ${CURRENT}/velvet-partition-assembly.fa ${CURRENT}/${PREFIX}.se.qc.fq.gz   > ${CURRENT}/vp.se.sai 
	bwa samse ${CURRENT}/velvet-partition-assembly.fa ${CURRENT}/vp.pe.sai ${PREFIX}.pe.qc.fq.gz > ${CURRENT}/vp.pe.sam 
	bwa samse ${CURRENT}/velvet-partition-assembly.fa ${CURRENT}/vp.se.sai ${PREFIX}.se.qc.fq.gz > ${CURRENT}/vp.se.sam 
	samtools ${CURRENT}/faidx velvet-partition-assembly.fa 
	samtools import ${CURRENT}/velvet-partition-assembly.fa.fai ${CURRENT}/vp.pe.sam ${CURRENT}/vp.pe.bam 
	samtools import ${CURRENT}/velvet-partition-assembly.fa.fai ${CURRENT}/vp.se.sam ${CURRENT}/vp.se.bam 
	cat ${CURRENT}/vp.pe.sam ${CURRENT}/vp.se.sam >${CURRENT}/vp.sam 
	cat ${CURRENT}/vp.pe.bam ${CURRENT}/vp.se.bam >${CURRENT}/vp.bam 
	

reads-to-iqc: ${CURRENT}/${PREFIX}.pe.qc.fq.gz ${CURRENT}/${PREFIX}.se.qc.fq.gz ${CURRENT}/idba-quality-assembly.fa 
	bwa index ${CURRENT}/idba-quality-assembly.fa 
	bwa aln ${CURRENT}/idba-quality-assembly.fa ${CURRENT}/${PREFIX}.pe.qc.fq.gz   > ${CURRENT}/iq.pe.sai 
	bwa aln ${CURRENT}/idba-quality-assembly.fa ${CURRENT}/${PREFIX}.se.qc.fq.gz   > ${CURRENT}/iq.se.sai 
	bwa samse ${CURRENT}/idba-quality-assembly.fa ${CURRENT}/iq.pe.sai ${CURRENT}/${PREFIX}.pe.qc.fq.gz > ${CURRENT}/iq.pe.sam 
	bwa samse ${CURRENT}/idba-quality-assembly.fa ${CURRENT}/iq.se.sai ${CURRENT}/${PREFIX}.se.qc.fq.gz > ${CURRENT}/iq.se.sam
	samtools faidx ${CURRENT}/idba-quality-assembly.fa 
	samtools import ${CURRENT}/idba-quality-assembly.fa.fai ${CURRENT}/iq.pe.sam ${CURRENT}/iq.pe.bam 
	samtools import ${CURRENT}/idba-quality-assembly.fa.fai ${CURRENT}/iq.se.sam ${CURRENT}/iq.se.bam 
	cat ${CURRENT}/iq.pe.sam ${CURRENT}/iq.se.sam > ${CURRENT}/iq.sam 
	cat ${CURRENT}/iq.pe.bam ${CURRENT}/iq.se.bam > ${CURRENT}/iq.bam 


reads-to-idigi: ${CURRENT}/${PREFIX}.pe.qc.fq.gz ${CURRENT}/${PREFIX}.se.qc.fq.gz ${CURRENT}/idba-diginorm-assembly.fa 
	bwa index ${CURRENT}/idba-diginorm-assembly.fa 
	bwa aln ${CURRENT}/idba-diginorm-assembly.fa ${CURRENT}/${PREFIX}.pe.qc.fq.gz   > ${CURRENT}/id.pe.sai 
	bwa aln ${CURRENT}/idba-diginorm-assembly.fa ${CURRENT}/${PREFIX}.se.qc.fq.gz   > ${CURRENT}/id.se.sai
	bwa samse ${CURRENT}/idba-diginorm-assembly.fa ${CURRENT}/id.pe.sai ${CURRENT}/${PREFIX}.pe.qc.fq.gz > ${CURRENT}/id.pe.sam 
	bwa samse ${CURRENT}/idba-diginorm-assembly.fa ${CURRENT}/id.se.sai ${CURRENT}/${PREFIX}.se.qc.fq.gz > ${CURRENT}/id.se.sam 
	samtools faidx ${CURRENT}/idba-diginorm-assembly.fa 
	samtools import ${CURRENT}/idba-diginorm-assembly.fa.fai ${CURRENT}/id.pe.sam ${CURRENT}/id.pe.bam 
	samtools import ${CURRENT}/idba-diginorm-assembly.fa.fai ${CURRENT}/id.se.sam ${CURRENT}/id.se.bam 
	cat ${CURRENT}/id.pe.sam ${CURRENT}/id.se.sam > ${CURRENT}/id.sam 
	cat ${CURRENT}/id.pe.bam ${CURRENT}/id.se.bam > ${CURRENT}/id.bam 


reads-to-ipart: ${CURRENT}/${PREFIX}.pe.qc.fq.gz ${CURRENT}/${PREFIX}.se.qc.fq.gz ${CURRENT}/idba-partition-assembly.fa  
	bwa index ${CURRENT}/idba-partition-assembly.fa 
	bwa aln ${CURRENT}/idba-partition-assembly.fa ${CURRENT}/${PREFIX}.pe.qc.fq.gz   > ${CURRENT}/ip.pe.sai 
	bwa aln ${CURRENT}/idba-partition-assembly.fa ${CURRENT}/${PREFIX}.se.qc.fq.gz   > ${CURRENT}/ip.se.sai 
	bwa samse ${CURRENT}/idba-partition-assembly.fa ${CURRENT}/ip.pe.sai ${CURRENT}/${PREFIX}.pe.qc.fq.gz > ${CURRENT}/ip.pe.sam 
	bwa samse ${CURRENT}/idba-partition-assembly.fa ${CURRENT}/ip.se.sai ${CURRENT}/${PREFIX}.se.qc.fq.gz > ${CURRENT}/ip.se.sam 
	samtools faidx ${CURRENT}/idba-partition-assembly.fa 
	samtools import ${CURRENT}/idba-partition-assembly.fa.fai ${CURRENT}/ip.pe.sam ${CURRENT}/ip.pe.bam 
	samtools import ${CURRENT}/idba-partition-assembly.fa.fai ${CURRENT}/ip.se.sam ${CURRENT}/ip.se.bam 
	cat ${CURRENT}/ip.pe.sam ${CURRENT}/ip.se.sam > ${CURRENT}/ip.sam 
	cat ${CURRENT}/ip.pe.bam ${CURRENT}/ip.se.bam > ${CURRENT}/ip.bam 

reads-to-sqc:  ${CURRENT}/${PREFIX}.pe.qc.fq.gz ${CURRENT}/${PREFIX}.se.qc.fq.gz ${CURRENT}/spades-quality-assembly.fa 
	bwa index ${CURRENT}/spades-quality-assembly.fa 
	bwa aln ${CURRENT}/spades-quality-assembly.fa ${CURRENT}/${PREFIX}.pe.qc.fq.gz   > ${CURRENT}/sq.pe.sai 
	bwa aln ${CURRENT}/spades-quality-assembly.fa ${CURRENT}/${PREFIX}.se.qc.fq.gz   > ${CURRENT}/sq.se.sai 
	bwa samse ${CURRENT}/spades-quality-assembly.fa ${CURRENT}/sq.pe.sai ${CURRENT}/${PREFIX}.pe.qc.fq.gz > ${CURRENT}/sq.pe.sam 
	bwa samse ${CURRENT}/spades-quality-assembly.fa ${CURRENT}/sq.se.sai ${CURRENT}/${PREFIX}.se.qc.fq.gz > ${CURRENT}/sq.se.sam 
	samtools ${CURRENT}/faidx spades-quality-assembly.fa 
	samtools import ${CURRENT}/spades-quality-assembly.fa.fai ${CURRENT}/sq.pe.sam ${CURRENT}/sq.pe.bam 
	samtools import ${CURRENT}/spades-quality-assembly.fa.fai ${CURRENT}/sq.se.sam ${CURRENT}/sq.se.bam 
	cat ${CURRENT}/sq.pe.sam ${CURRENT}/sq.se.sam > ${CURRENT}/sq.sam 
	cat ${CURRENT}/sq.pe.bam ${CURRENT}/sq.se.bam > ${CURRENT}/sq.bam 

reads-to-sdigi: ${CURRENT}/${PREFIX}.pe.qc.fq.gz ${CURRENT}/${PREFIX}.se.qc.fq.gz ${CURRENT}/spades-diginorm-assembly.fa 
	bwa index ${CURRENT}/spades-diginorm-assembly.fa 
	bwa aln ${CURRENT}/spades-diginorm-assembly.fa ${CURRENT}/${PREFIX}.pe.qc.fq.gz   > ${CURRENT}/sd.pe.sai 
	bwa aln ${CURRENT}/spades-diginorm-assembly.fa ${CURRENT}/${PREFIX}.se.qc.fq.gz   > ${CURRENT}/sd.se.sai 
	bwa samse ${CURRENT}/spades-diginorm-assembly.fa ${CURRENT}/sd.pe.sai ${CURRENT}/${PREFIX}.pe.qc.fq.gz > ${CURRENT}/sd.pe.sam 
	bwa samse ${CURRENT}/spades-diginorm-assembly.fa ${CURRENT}/sd.se.sai ${CURRENT}/${PREFIX}.se.qc.fq.gz > ${CURRENT}/sd.se.sam
	samtools faidx ${CURRENT}/spades-diginorm-assembly.fa 
	samtools import ${CURRENT}/spades-diginorm-assembly.fa.fai ${CURRENT}/sd.pe.sam ${CURRENT}/sd.pe.bam 
	samtools import ${CURRENT}/spades-diginorm-assembly.fa.fai ${CURRENT}/sd.se.sam ${CURRENT}/sd.se.bam
	cat ${CURRENT}/sd.pe.sam ${CURRENT}/sd.se.sam > ${CURRENT}/sd.sam 
	cat ${CURRENT}/sd.pe.bam ${CURRENT}/sd.se.bam > ${CURRENT}/sd.bam 

reads-to-spart:  ${CURRENT}/${PREFIX}.pe.qc.fq.gz ${CURRENT}/${PREFIX}.se.qc.fq.gz ${CURRENT}/spades-partition-assembly.fa 
	bwa index ${CURRENT}/spades-partition-assembly.fa 
	bwa aln ${CURRENT}/spades-partition-assembly.fa ${CURRENT}/${PREFIX}.pe.qc.fq.gz   > ${CURRENT}/sp.pe.sai 
	bwa aln ${CURRENT}/spades-partition-assembly.fa ${CURRENT}/${PREFIX}.se.qc.fq.gz   > ${CURRENT}/sp.se.sai 
	bwa samse ${CURRENT}/spades-partition-assembly.fa ${CURRENT}/sp.pe.sai ${CURRENT}/${PREFIX}.pe.qc.fq.gz > ${CURRENT}/sp.pe.sam 
	bwa samse ${CURRENT}/spades-partition-assembly.fa ${CURRENT}/sp.se.sai ${CURRENT}/${PREFIX}.se.qc.fq.gz > ${CURRENT}/sp.se.sam 
	samtools faidx ${CURRENT}/spades-partition-assembly.fa 
	samtools import ${CURRENT}/spades-partition-assembly.fa.fai ${CURRENT}/sp.pe.sam ${CURRENT}/sp.pe.bam 
	samtools import ${CURRENT}/spades-partition-assembly.fa.fai ${CURRENT}/sp.se.sam ${CURRENT}/sp.se.bam 
	cat ${CURRENT}/sp.pe.sam ${CURRENT}/sp.se.sam > ${CURRENT}/sp.sam
	cat ${CURRENT}/sp.pe.bam ${CURRENT}/sp.se.bam > ${CURRENT}/sp.bam 	

reads-to-mqc:  ${CURRENT}/${PREFIX}.pe.qc.fq.gz ${CURRENT}/${PREFIX}.se.qc.fq.gz ${CURRENT}/megahit-quality-assembly.fa 
	bwa index ${CURRENT}/megahit-quality-assembly.fa 
	bwa aln ${CURRENT}/megahit-quality-assembly.fa ${CURRENT}/${PREFIX}.pe.qc.fq.gz   > ${CURRENT}/mq.pe.sai 
	bwa aln ${CURRENT}/megahit-quality-assembly.fa ${CURRENT}/${PREFIX}.se.qc.fq.gz   > ${CURRENT}/mq.se.sai 
	bwa samse ${CURRENT}/megahit-quality-assembly.fa ${CURRENT}/mq.pe.sai ${CURRENT}/${PREFIX}.pe.qc.fq.gz > ${CURRENT}/mq.pe.sam 
	bwa samse ${CURRENT}/megahit-quality-assembly.fa ${CURRENT}/mq.se.sai ${CURRENT}/${PREFIX}.se.qc.fq.gz > ${CURRENT}/mq.se.sam 
	samtools faidx ${CURRENT}/megahit-quality-assembly.fa 
	samtools import ${CURRENT}/megahit-quality-assembly.fa.fai ${CURRENT}/mq.pe.sam ${CURRENT}/mq.pe.bam 
	samtools import ${CURRENT}/megahit-quality-assembly.fa.fai ${CURRENT}/mq.se.sam ${CURRENT}/mq.se.bam 
	cat ${CURRENT}/mq.pe.sam ${CURRENT}/mq.se.sam > ${CURRENT}/mq.sam 
	cat ${CURRENT}/mq.pe.bam ${CURRENT}/mq.se.bam > ${CURRENT}/mq.bam 

reads-to-mdigi:  ${CURRENT}/${PREFIX}.pe.qc.fq.gz ${CURRENT}/${PREFIX}.se.qc.fq.gz ${CURRENT}/megahit-diginorm-assembly.fa 
	bwa index ${CURRENT}/megahit-diginorm-assembly.fa 
	bwa aln ${CURRENT}/megahit-diginorm-assembly.fa ${CURRENT}/${PREFIX}.pe.qc.fq.gz   > ${CURRENT}/md.pe.sai 
	bwa aln ${CURRENT}/megahit-diginorm-assembly.fa ${CURRENT}/${PREFIX}.se.qc.fq.gz   > ${CURRENT}/md.se.sai 
	bwa samse ${CURRENT}/megahit-diginorm-assembly.fa ${CURRENT}/md.pe.sai ${CURRENT}/${PREFIX}.pe.qc.fq.gz > ${CURRENT}/md.pe.sam 
	bwa samse ${CURRENT}/megahit-diginorm-assembly.fa ${CURRENT}/md.se.sai ${CURRENT}/${PREFIX}.se.qc.fq.gz > ${CURRENT}/md.se.sam 
	samtools faidx ${CURRENT}/megahit-diginorm-assembly.fa 
	samtools import ${CURRENT}/megahit-diginorm-assembly.fa.fai ${CURRENT}/md.pe.sam ${CURRENT}/md.pe.bam 
	samtools import ${CURRENT}/megahit-diginorm-assembly.fa.fai ${CURRENT}/md.se.sam ${CURRENT}/md.se.bam 
	cat ${CURRENT}/md.pe.sam ${CURRENT}/md.se.sam > ${CURRENT}/md.sam 
	cat ${CURRENT}/md.pe.bam ${CURRENT}/md.se.bam > ${CURRENT}/md.bam 

reads-to-mpart:  ${CURRENT}/${PREFIX}.pe.qc.fq.gz ${CURRENT}/${PREFIX}.se.qc.fq.gz ${CURRENT}/megahit-partition-assembly.fa 
	bwa index ${CURRENT}/megahit-partition-assembly.fa 
	bwa aln ${CURRENT}/megahit-partition-assembly.fa ${CURRENT}/${PREFIX}.pe.qc.fq.gz   > ${CURRENT}/mp.pe.sai 
	bwa aln ${CURRENT}/megahit-partition-assembly.fa ${CURRENT}/${PREFIX}.se.qc.fq.gz   > ${CURRENT}/mp.se.sai 
	bwa samse ${CURRENT}/megahit-partition-assembly.fa ${CURRENT}/mp.pe.sai ${CURRENT}/${PREFIX}.pe.qc.fq.gz > ${CURRENT}/mp.pe.sam
	bwa samse ${CURRENT}/megahit-partition-assembly.fa ${CURRENT}/mp.se.sai ${CURRENT}/${PREFIX}.se.qc.fq.gz > ${CURRENT}/mp.se.sam 
	samtools faidx ${CURRENT}/megahit-partition-assembly.fa 
	samtools import ${CURRENT}/megahit-partition-assembly.fa.fai ${CURRENT}/mp.pe.sam ${CURRENT}/mp.pe.bam 
	samtools import ${CURRENT}/megahit-partition-assembly.fa.fai ${CURRENT}/mp.se.sam ${CURRENT}/mp.se.bam 
	cat ${CURRENT}/mp.pe.sam ${CURRENT}/mp.se.sam > ${CURRENT}/mp.sam 
	cat ${CURRENT}/mp.pe.bam ${CURRENT}/mp.pe.bam > ${CURRENT}/mp.bam 

#---------------------------------------------------------------------Count Unalignments---------------------------------------------------------------------
count-unaligned: 
	python ${MYSCRIPTS}/extract-unaligned.py -o ${CURRENT}/vq.pe.unaligned --format fasta ${CURRENT}/vq.pe.bam
	python ${MYSCRIPTS}/extract-unaligned.py -o ${CURRENT}/vq.se.unaligned --format fasta ${CURRENT}/vq.se.bam
	python ${MYSCRIPTS}/extract-unaligned.py -o ${CURRENT}/vd.pe.unaligned --format fasta ${CURRENT}/vd.pe.bam
	python ${MYSCRIPTS}/extract-unaligned.py -o ${CURRENT}/vq.se.unaligned --format fasta ${CURRENT}/vq.se.bam
	python ${MYSCRIPTS}/extract-unaligned.py -o ${CURRENT}/vd.pe.unaligned --format fasta ${CURRENT}/vd.pe.bam
	python ${MYSCRIPTS}/extract-unaligned.py -o ${CURRENT}/vd.se.unaligned --format fasta ${CURRENT}/vd.se.bam
	python ${MYSCRIPTS}/extract-unaligned.py -o ${CURRENT}/vp.pe.unaligned --format fasta ${CURRENT}/vp.pe.bam
	python ${MYSCRIPTS}/extract-unaligned.py -o ${CURRENT}/vp.se.unaligned --format fasta ${CURRENT}/vp.se.bam
	python ${MYSCRIPTS}/extract-unaligned.py -o ${CURRENT}/iq.pe.unaligned --format fasta ${CURRENT}/iq.pe.bam
	python ${MYSCRIPTS}/extract-unaligned.py -o ${CURRENT}/iq.se.unaligned --format fasta ${CURRENT}/iq.se.bam
	python ${MYSCRIPTS}/extract-unaligned.py -o ${CURRENT}/id.pe.unaligned --format fasta ${CURRENT}/id.pe.bam
	python ${MYSCRIPTS}/extract-unaligned.py -o ${CURRENT}/id.se.unaligned --format fasta ${CURRENT}/id.se.bam
	python ${MYSCRIPTS}/extract-unaligned.py -o ${CURRENT}/ip.pe.unaligned --format fasta ${CURRENT}/ip.pe.bam
	python ${MYSCRIPTS}/extract-unaligned.py -o ${CURRENT}/ip.se.unaligned --format fasta ${CURRENT}/ip.se.bam
	python ${MYSCRIPTS}/extract-unaligned.py -o ${CURRENT}/sq.pe.unaligned --format fasta ${CURRENT}/sq.pe.bam
	python ${MYSCRIPTS}/extract-unaligned.py -o ${CURRENT}/sq.se.unaligned --format fasta ${CURRENT}/sq.se.bam
	python ${MYSCRIPTS}/extract-unaligned.py -o ${CURRENT}/sd.pe.unaligned --format fasta ${CURRENT}/sd.pe.bam
	python ${MYSCRIPTS}/extract-unaligned.py -o ${CURRENT}/sd.se.unaligned --format fasta ${CURRENT}/sd.se.bam
	python ${MYSCRIPTS}/extract-unaligned.py -o ${CURRENT}/sp.se.unaligned --format fasta ${CURRENT}/sp.se.bam
	python ${MYSCRIPTS}/extract-unaligned.py -o ${CURRENT}/sp.pe.unaligned --format fasta ${CURRENT}/sp.pe.bam         	
	python ${MYSCRIPTS}/extract-unaligned.py -o ${CURRENT}/mq.pe.unaligned --format fasta ${CURRENT}/mq.pe.bam
	python ${MYSCRIPTS}/extract-unaligned.py -o ${CURRENT}/mq.se.unaligned --format fasta ${CURRENT}/mq.se.bam
	python ${MYSCRIPTS}/extract-unaligned.py -o ${CURRENT}/md.pe.unaligned --format fasta ${CURRENT}/md.pe.bam
	python ${MYSCRIPTS}/extract-unaligned.py -o ${CURRENT}/md.se.unaligned --format fasta ${CURRENT}/md.se.bam
	python ${MYSCRIPTS}/extract-unaligned.py -o ${CURRENT}/mp.pe.unaligned --format fasta ${CURRENT}/mp.pe.bam
	python ${MYSCRIPTS}/extract-unaligned.py -o ${CURRENT}/mp.se.unaligned --format fasta ${CURRENT}/mp.se.bam
	bash ${MYSCRIPTS}/counting.sh 
#----------------------------------------------------------Extracting Unaligned Reads-------------------------------------------------------------------------
extract-unaligned:
	python extract-unaligned-scaffolds.py idba-quality-quast/${NUCMER}/idba-quality-assembly.unaligned idba-quality-assembly.fa > idba-quality-unaligned.fa
	python extract-unaligned-contigs.py velvet-quality-quast/${NUCMER}/velvet-quality-assembly.unaligned velvet-quality-assembly.fa > velvet-quality-unaligned.fa
	python extract-unaligned-contigs.py spades-quality-quast/${NUCMER}/spades-quality-assembly.unaligned spades-quality-assembly.fa > spades-quality-unaligned.fa
	python extract-unaligned-contigs.py megahit-quality-quast/${NUCMER}/megahit-quality-assembly.unaligned megahit-quality-assembly.fa  > megahit-quality-unaligned.fa
	python extract-unaligned-scaffolds.py idba-diginorm-quast/${NUCMER}/idba-diginorm-assembly.unaligned idba-diginorm-assembly.fa > idba-diginorm-unaligned.fa
	python extract-unaligned-contigs.py velvet-diginorm-quast/${NUCMER}/velvet-diginorm-assembly.unaligned velvet-diginorm-assembly.fa > velvet-diginorm-unaligned.fa
	python extract-unaligned-contigs.py spades-diginorm-quast/${NUCMER}/spades-diginorm-assembly.unaligned spades-diginorm-assembly.fa > spades-diginorm-unaligned.fa
	python extract-unaligned-contigs.py megahit-diginorm-quast/${NUCMER}/megahit-diginorm-assembly.unaligned megahit-diginorm-assembly.fa  > megahit-diginorm-unaligned.fa
	python extract-unaligned-scaffolds.py idba-partition-quast/${NUCMER}/idba-partition-assembly.unaligned idba-partition-assembly.fa > idba-partition-unaligned.fa
	python extract-unaligned-contigs.py velvet-partition-quast/${NUCMER}/velvet-partition-assembly.unaligned velvet-partition-assembly.fa > velvet-partition-unaligned.fa
	python extract-unaligned-contigs.py spades-partition-quast/${NUCMER}/spades-partition-assembly.unaligned spades-partition-assembly.fa > spades-partition-unaligned.fa
	python extract-unaligned-contigs.py megahit-partition-quast/${NUCMER}/megahit-partition-assembly.unaligned megahit-partition-assembly.fa  > megahit-partition-unaligned.fa
#------------------------------------------------------------------Mapping reads to unaligned contigs--------------------------------------------------------
reads-to-unaligned-vqc: ${CURRENT}/${PREFIX}.pe.qc.fq.gz ${CURRENT}/${PREFIX}.se.qc.fq.gz ${CURRENT}/velvet-quality-unaligned.fa
	bwa index ${CURRENT}/velvet-quality-unaligned.fa 
	bwa aln ${CURRENT}/velvet-quality-unaligned.fa ${CURRENT}/${PREFIX}.pe.qc.fq.gz   > ${CURRENT}/uvqc.pe.sai 
	bwa aln ${CURRENT}/velvet-quality-unaligned.fa ${CURRENT}/${PREFIX}.se.qc.fq.gz   > ${CURRENT}/uvqc.se.sai 
	bwa samse ${CURRENT}/velvet-quality-unaligned.fa ${CURRENT}/uvqc.pe.sai ${CURRENT}/${PREFIX}.pe.qc.fq.gz > ${CURRENT}/uvqc.pe.sam 
	bwa samse ${CURRENT}/velvet-quality-unaligned.fa ${CURRENT}/uvqc.se.sai ${CURRENT}/${PREFIX}.se.qc.fq.gz > ${CURRENT}/uvqc.se.sam
	samtools faidx ${CURRENT}/velvet-quality-unaligned.fa 
	samtools import ${CURRENT}/velvet-quality-unaligned.fa.fai ${CURRENT}/uvqc.pe.sam ${CURRENT}/uvqc.pe.bam 
	samtools import ${CURRENT}/velvet-quality-unaligned.fa.fai ${CURRENT}/uvqc.se.sam ${CURRENT}/uvqc.se.bam
	samtools view -F 4 ${CURRENT}/uvqc.pe.bam > ${CURRENT}/uvqc-mapped.pe.bam
	samtools view -F 4 ${CURRENT}/uvqc.se.bam > ${CURRENT}/uvqc-mapped.se.bam
	samtools view -c -F 4 ${CURRENT}/uvqc.pe.bam > ${CURRENT}/uvqc-aligned-reads
	samtools view -c -F 4 ${CURRENT}/uvqc.se.bam >> ${CURRENT}/uvqc-aligned-reads
	bash ${MYSCRIPTS}/get-mapped.sh ${CURRENT}/uvqc-mapped.pe.bam > ${CURRENT}/uvqc-reads.fa
	bash ${MYSCRIPTS}/get-mapped.sh ${CURRENT}/uvqc-mapped.se.bam >> ${CURRENT}/uvqc-reads.fa
	bwa index ${CURRENT}/mircea.fa 
	bwa aln ${CURRENT}/mircea.fa ${CURRENT}/uvqc-reads.fa  >${CURRENT}/uvqc.sai
	bwa samse ${CURRENT}/mircea.fa ${CURRENT}/uvqc.sai ${CURRENT}/uvqc-reads.fa > ${CURRENT}/uvqc.sam
	samtools faidx ${CURRENT}/mircea.fa 
	samtools import ${CURRENT}/mircea.fa.fai ${CURRENT}/uvqc.sam ${CURRENT}/uvqc.bam 
	samtools view -c -F 4 ${CURRENT}/uvqc.bam > ${CURRENT}/uvqc-mapped-reads

reads-to-unaligned-iqc: ${CURRENT}/${PREFIX}.pe.qc.fq.gz ${CURRENT}/${PREFIX}.se.qc.fq.gz ${CURRENT}/idba-quality-unaligned.fa
	bwa index ${CURRENT}/idba-quality-unaligned.fa 
	bwa aln ${CURRENT}/idba-quality-unaligned.fa ${CURRENT}/${PREFIX}.pe.qc.fq.gz   > ${CURRENT}/uiqc.pe.sai 
	bwa aln ${CURRENT}/idba-quality-unaligned.fa ${CURRENT}/${PREFIX}.se.qc.fq.gz   > ${CURRENT}/uiqc.se.sai 
	bwa samse ${CURRENT}/idba-quality-unaligned.fa ${CURRENT}/uiqc.pe.sai ${CURRENT}/${PREFIX}.pe.qc.fq.gz > ${CURRENT}/uiqc.pe.sam 
	bwa samse ${CURRENT}/idba-quality-unaligned.fa ${CURRENT}/uiqc.se.sai ${CURRENT}/${PREFIX}.se.qc.fq.gz > ${CURRENT}/uiqc.se.sam
	samtools faidx ${CURRENT}/idba-quality-unaligned.fa 
	samtools import ${CURRENT}/idba-quality-unaligned.fa.fai ${CURRENT}/uiqc.pe.sam ${CURRENT}/uiqc.pe.bam 
	samtools import ${CURRENT}/idba-quality-unaligned.fa.fai ${CURRENT}/uiqc.se.sam ${CURRENT}/uiqc.se.bam
	samtools view -F 4 ${CURRENT}/uiqc.pe.bam > ${CURRENT}/uiqc-mapped.pe.bam 
	samtools view -F 4 ${CURRENT}/uiqc.se.bam > ${CURRENT}/uiqc-mapped.se.bam
	samtools view -c -F 4 ${CURRENT}/uiqc.pe.bam > ${CURRENT}/uiqc-aligned-reads
	samtools view -c -F 4 ${CURRENT}/uiqc.se.bam >> ${CURRENT}/uiqc-aligned-reads
	bash ${MYSCRIPTS}/get-mapped.sh ${CURRENT}/uiqc-mapped.pe.bam > ${CURRENT}/uiqc-reads.fa
	bash ${MYSCRIPTS}/get-mapped.sh ${CURRENT}/uiqc-mapped.se.bam >> ${CURRENT}/uiqc-reads.fa
	bwa index ${CURRENT}/mircea.fa 
	bwa aln ${CURRENT}/mircea.fa ${CURRENT}/uiqc-reads.fa  >${CURRENT}/uiqc.sai
	bwa samse ${CURRENT}/mircea.fa ${CURRENT}/uiqc.sai ${CURRENT}/uiqc-reads.fa > ${CURRENT}/uiqc.sam
	samtools faidx ${CURRENT}/mircea.fa 
	samtools import ${CURRENT}/mircea.fa.fai ${CURRENT}/uiqc.sam ${CURRENT}/uiqc.bam 
	samtools view -c -F 4 ${CURRENT}/uiqc.bam > ${CURRENT}/uiqc-mapped-reads

reads-to-unaligned-sqc: ${CURRENT}/${PREFIX}.pe.qc.fq.gz ${CURRENT}/${PREFIX}.se.qc.fq.gz ${CURRENT}/spades-quality-unaligned.fa
	bwa index ${CURRENT}/spades-quality-unaligned.fa 
	bwa aln ${CURRENT}/spades-quality-unaligned.fa ${CURRENT}/${PREFIX}.pe.qc.fq.gz   > ${CURRENT}/usqc.pe.sai 
	bwa aln ${CURRENT}/spades-quality-unaligned.fa ${CURRENT}/${PREFIX}.se.qc.fq.gz   > ${CURRENT}/usqc.se.sai 
	bwa samse ${CURRENT}/spades-quality-unaligned.fa ${CURRENT}/usqc.pe.sai ${CURRENT}/${PREFIX}.pe.qc.fq.gz > ${CURRENT}/usqc.pe.sam 
	bwa samse ${CURRENT}/spades-quality-unaligned.fa ${CURRENT}/usqc.se.sai ${CURRENT}/${PREFIX}.se.qc.fq.gz > ${CURRENT}/usqc.se.sam
	samtools faidx ${CURRENT}/spades-quality-unaligned.fa 
	samtools import ${CURRENT}/spades-quality-unaligned.fa.fai ${CURRENT}/usqc.pe.sam ${CURRENT}/usqc.pe.bam 
	samtools import ${CURRENT}/spades-quality-unaligned.fa.fai ${CURRENT}/usqc.se.sam ${CURRENT}/usqc.se.bam
	samtools view -F 4 ${CURRENT}/usqc.pe.bam > ${CURRENT}/usqc-mapped.pe.bam 
	samtools view -F 4 ${CURRENT}/usqc.se.bam > ${CURRENT}/usqc-mapped.se.bam
	samtools view -c -F 4 ${CURRENT}/usqc.pe.bam > ${CURRENT}/usqc-aligned-reads 
	samtools view -c -F 4 ${CURRENT}/usqc.se.bam >> ${CURRENT}/usqc-aligned-reads
	bash ${MYSCRIPTS}/get-mapped.sh ${CURRENT}/usqc-mapped.pe.bam > ${CURRENT}/usqc-reads.fa
	bash ${MYSCRIPTS}/get-mapped.sh ${CURRENT}/usqc-mapped.se.bam >> ${CURRENT}/usqc-reads.fa
	bwa index ${CURRENT}/mircea.fa 
	bwa aln ${CURRENT}/mircea.fa ${CURRENT}/usqc-reads.fa  >${CURRENT}/usqc.sai
	bwa samse ${CURRENT}/mircea.fa ${CURRENT}/usqc.sai ${CURRENT}/usqc-reads.fa > ${CURRENT}/usqc.sam
	samtools faidx ${CURRENT}/mircea.fa 
	samtools import ${CURRENT}/mircea.fa.fai ${CURRENT}/usqc.sam ${CURRENT}/usqc.bam 
	samtools view -c -F 4 ${CURRENT}/usqc.bam > ${CURRENT}/usqc-mapped-reads

reads-to-unaligned-mqc: ${CURRENT}/${PREFIX}.pe.qc.fq.gz ${CURRENT}/${PREFIX}.se.qc.fq.gz ${CURRENT}/megahit-quality-unaligned.fa
	bwa index ${CURRENT}/megahit-quality-unaligned.fa 
	bwa aln ${CURRENT}/megahit-quality-unaligned.fa ${CURRENT}/${PREFIX}.pe.qc.fq.gz   > ${CURRENT}/umqc.pe.sai 
	bwa aln ${CURRENT}/megahit-quality-unaligned.fa ${CURRENT}/${PREFIX}.se.qc.fq.gz   > ${CURRENT}/umqc.se.sai 
	bwa samse ${CURRENT}/megahit-quality-unaligned.fa ${CURRENT}/umqc.pe.sai ${CURRENT}/${PREFIX}.pe.qc.fq.gz > ${CURRENT}/umqc.pe.sam 
	bwa samse ${CURRENT}/megahit-quality-unaligned.fa ${CURRENT}/umqc.se.sai ${CURRENT}/${PREFIX}.se.qc.fq.gz > ${CURRENT}/umqc.se.sam
	samtools faidx ${CURRENT}/megahit-quality-unaligned.fa 
	samtools import ${CURRENT}/megahit-quality-unaligned.fa.fai ${CURRENT}/umqc.pe.sam ${CURRENT}/umqc.pe.bam 
	samtools import ${CURRENT}/megahit-quality-unaligned.fa.fai ${CURRENT}/umqc.se.sam ${CURRENT}/umqc.se.bam
	samtools view -F 4 ${CURRENT}/umqc.pe.bam > ${CURRENT}/umqc-mapped.pe.bam 
	samtools view -F 4 ${CURRENT}/umqc.se.bam > ${CURRENT}/umqc-mapped.se.bam
	samtools view -c -F 4 ${CURRENT}/umqc.pe.bam > ${CURRENT}/umqc-aligned-reads 
	samtools view -c -F 4 ${CURRENT}/umqc.se.bam >> ${CURRENT}/umqc-aligned-reads
	bash ${MYSCRIPTS}/get-mapped.sh ${CURRENT}/umqc-mapped.pe.bam > ${CURRENT}/umqc-reads.fa
	bash ${MYSCRIPTS}/get-mapped.sh ${CURRENT}/umqc-mapped.se.bam >> ${CURRENT}/umqc-reads.fa
	bwa index ${CURRENT}/mircea.fa 
	bwa aln ${CURRENT}/mircea.fa ${CURRENT}/umqc-reads.fa  >${CURRENT}/umqc.sai
	bwa samse ${CURRENT}/mircea.fa ${CURRENT}/umqc.sai ${CURRENT}/umqc-reads.fa > ${CURRENT}/umqc.sam
	samtools faidx ${CURRENT}/mircea.fa 
	samtools import ${CURRENT}/mircea.fa.fai ${CURRENT}/umqc.sam ${CURRENT}/umqc.bam 
	samtools view -c -F 4 ${CURRENT}/umqc.bam > ${CURRENT}/umqc-mapped-reads

#-------------------------------------------------Blasting Unligned Reads to Fusa Seeds----------------------------------------------------------------------
unaligned-fusa: fusA.seeds *-unaligned.fa 
	formatdb -i fusA.seeds  -p F 
	blastall -p blastn -d ${DATA}/fusA.seeds -i velvet-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o vqu
	blastall -p blastn -d ${DATA}/fusA.seeds -i velvet-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o vdu
	blastall -p blastn -d ${DATA}/fusA.seeds -i velvet-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o vpu
	blastall -p blastn -d ${DATA}/fusA.seeds -i idba-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o iqu
	blastall -p blastn -d ${DATA}/fusA.seeds -i idba-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o idu
	blastall -p blastn -d ${DATA}/fusA.seeds -i idba-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o ipu
	blastall -p blastn -d ${DATA}/fusA.seeds -i spades-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o squ
	blastall -p blastn -d ${DATA}/fusA.seeds -i spades-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o sdu
	blastall -p blastn -d ${DATA}/fusA.seeds -i spades-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o spu
	blastall -p blastn -d ${DATA}/fusA.seeds -i megahit-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o mqu
	blastall -p blastn -d ${DATA}/fusA.seeds -i megahit-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o mdu
	blastall -p blastn -d ${DATA}/fusA.seeds -i megahit-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o mpu

#-------------------------------------------------Blasting Unaligned Reads to QC reads-----------------------------------------------------------------------
unaligned-to-qc: ${PREFIX}.pe.qc.fq.gz ${PREFIX}.se.qc.fq.gz *-unaligned.fa
	cat ${PREFIX}.pe.qc.fq.gz ${PREFIX}.se.qc.fq.gz >${PREFIX}.qc.fq.gz
	gunzip -c ${PREFIX}.qc.fq.gz > ${PREFIX}.qc
	formatdb -i ${PREFIX}.qc -p F
	blastall -p blastn -d ${PREFIX}.qc -i velvet-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o Qvqu
	blastall -p blastn -d ${PREFIX}.qc -i velvet-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o Qvdu
	blastall -p blastn -d ${PREFIX}.qc -i velvet-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o Qvpu
	blastall -p blastn -d ${PREFIX}.qc -i idba-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o Qiqu
	blastall -p blastn -d ${PREFIX}.qc -i idba-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o Qidu
	blastall -p blastn -d ${PREFIX}.qc -i idba-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o Qipu
	blastall -p blastn -d ${PREFIX}.qc -i spades-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o Qsqu
	blastall -p blastn -d ${PREFIX}.qc -i spades-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o Qsdu
	blastall -p blastn -d ${PREFIX}.qc -i spades-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o Qspu
	blastall -p blastn -d ${PREFIX}.qc -i megahit-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o Qmqu
	blastall -p blastn -d ${PREFIX}.qc -i megahit-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o Qmdu
	blastall -p blastn -d ${PREFIX}.qc -i megahit-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o Qmpu

#------------------------------------------------Blasting Unaligned Reads to Reference-----------------------------------------------------------------------
unaligned-ref: ${DATA}/mircea.fa.gz *-unaligned.fa
	gunzip -c ${DATA}/mircea.fa.gz >${DATA}/mircea.fa
	formatdb -i ${DATA}/mircea.fa  -p F 
	blastall -p blastn -d ${DATA}/mircea.fa -i velvet-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o Refvqu
	blastall -p blastn -d ${DATA}/mircea.fa -i velvet-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o Refvdu
	blastall -p blastn -d ${DATA}/mircea.fa -i velvet-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o Refvp
	blastall -p blastn -d ${DATA}/mircea.fa -i idba-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o Refiqu
	blastall -p blastn -d ${DATA}/mircea.fa -i idba-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o Refidu
	blastall -p blastn -d ${DATA}/mircea.fa -i idba-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o Refipu
	blastall -p blastn -d ${DATA}/mircea.fa -i spades-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o Refsqu
	blastall -p blastn -d ${DATA}/mircea.fa -i spades-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o Refsdu
	blastall -p blastn -d ${DATA}/mircea.fa -i spades-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o Refspu
	blastall -p blastn -d ${DATA}/mircea.fa -i megahit-quality-unaligned.fa -b 2 -v 2 -e 1e-6 -o Refmqu
	blastall -p blastn -d ${DATA}/mircea.fa -i megahit-diginorm-unaligned.fa -b 2 -v 2 -e 1e-6 -o Refmdu
	blastall -p blastn -d ${DATA}/mircea.fa -i megahit-partition-unaligned.fa -b 2 -v 2 -e 1e-6 -o ZZRefmpu	
#--------------------------------------Quasting Unaligned reads to Unaligned IDBA reads ---------------------------------------------------------------------
unaligned-idba-unaligned:
	python ${QUAST}/quast.py -R idba-quality-unaligned.fa -o velvet-quality-unaligned/ velvet-quality-unaligned.fa
	python ${QUAST}/quast.py -R idba-quality-unaligned.fa -o velvet-diginorm-unaligned/ velvet-diginorm-unaligned.fa   
	python ${QUAST}/quast.py -R idba-quality-unaligned.fa -o velvet-partition-unaligned/ velvet-partition-unaligned.fa
	python ${QUAST}/quast.py -R idba-quality-unaligned.fa -o idba-diginorm-unaligned/ idba-diginorm-unaligned.fa
	python ${QUAST}/quast.py -R idba-quality-unaligned.fa -o idba-partition-unaligned/ idba-partition-unaligned.fa
	python ${QUAST}/quast.py -R idba-quality-unaligned.fa -o spades-quality-unaligned/ spades-quality-unaligned.fa
	python ${QUAST}/quast.py -R idba-quality-unaligned.fa -o spades-diginorm-unaligned/ spades-diginorm-unaligned.fa
	python ${QUAST}/quast.py -R idba-quality-unaligned.fa -o spades-partition-unaligned/ spades-partition-unaligned.fa
	python ${QUAST}/quast.py -R idba-quality-unaligned.fa -o megahit-quality-unaligned/ megahit-quality-unaligned.fa
	python ${QUAST}/quast.py -R idba-quality-unaligned.fa -o megahit-diginorm-unaligned/ megahit-diginorm-unaligned.fa 
	python ${QUAST}/quast.py -R idba-quality-unaligned.fa -o megahit-partition-unaligned/ megahit-partition-unaligned.fa

#----------------------------------------------------Trying Different min-contig in QUAST parameters --------------------------------------------------------
change-min-contig:
	$(foreach i,$(mc),python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o vqc-conting-$(i)/ velvet-quality-assembly.fa --min-contig=$(i); ) 
	$(foreach i,$(mc),python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o iqc-conting-$(i)/ idba-quality-assembly.fa --min-contig=$(i); )  
	$(foreach i,$(mc),python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o sqc-conting-$(i)/ spades-quality-assembly.fa --min-contig=$(i); ) 
	$(foreach i,$(mc),python ${QUAST}/quast.py -R ${DATA}/mircea.fa.gz -o mqc-conting-$(i)/ megahit-quality-assembly.fa --min-contig=$(i); )
 
#------------------------------------------------------------Finding Chimeric Reads--------------------------------------------------------------------------
chimeric:  ${DATA}/mircea.fa ${PREFIX}.se.qc.fq.gz ${PREFIX}.pe.qc.fq.gz
	bwa index ${DATA}/mircea.fa 
	bwa mem -M -t 16 ${DATA}/mircea.fa ${PREFIX}.se.qc.fq.gz  > ${PREFIX}-se.sam
	bwa mem -M -t 16 ${DATA}/mircea.fa ${PREFIX}.pe.qc.fq.gz  > ${PREFIX}-pe.sam
	samtools faidx ${DATA}/mircea.fa
	samtools import mircea.fa.fai ${PREFIX}-pe.sam ${PREFIX}-pe.bam
	samtools import mircea.fa.fai ${PREFIX}-se.sam ${PREFIX}-se.bam
	samtools view ${PREFIX}-pe.bam | grep 'SA:'  > ${PREFIX}-pe.chimeric
	samtools view ${PREFIX}-se.bam | grep 'SA:'  > ${PREFIX}-se.chimeric
	bash count-chimeric.sh 

#---------------------------------------------------------------Cleaning ------------------------------------------------------------------------------------	
clean: *.list *.list.unique
	rm *.list 
	rm *.list.unique  
