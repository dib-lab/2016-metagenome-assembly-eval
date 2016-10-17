DATA = /mnt/home/mahmoud4/data
WORKDIR = /mnt/research/ged/sherine/run
MYSCRIPTS = /mnt/home/mahmoud4/scripts
NUCMER = contigs_reports/nucmer_output
PREFIX = SRR606249
MEGAHIT=/mnt/home/mahmoud4/megahit
TRIM = /opt/software/Trimmomatic/0.32
TOOLKIT =/opt/software/FASTX/0.0.14--GCC-4.4.5/bin/
#SANDBOX = /opt/software/khmer/khmer-1.4
#SCRIPTS =/opt/software/khmer/khmer-1.4/scripts
SANDBOX = /opt/software/khmer/2.0--GCC-4.8.2
SCRIPTS = /opt/software/khmer/2.0--GCC-4.8.2/scripts
#--------------------------------------------------------------------------------------------------------------------------------
all-protocol: ${DATA}/SRR606429-1.fastq.gz ${DATA}/SRR606429-1.fastq.gz 
	quality
	diginorm
	partition
	velvet-quality
	spades-quality
	idba-quality
	velvet-diginorm
	spades-diginorm
	idba-diginorm
	velvet-partition
	spades-partition
	idba-partition
#--------------------------------------------------------------------------------------------------------------------------------
quality: ${DATA}/${PREFIX}-1.fastq.gz  ${DATA}/${PREFIX}-2.fastq.gz 
	interleaving-1
	interleaving-2
	interleaving-3
	protocol-quality-rename-1
	protocol-quality-rename-2 	
#--------------------------------------------------------------------------------------------------------------------------------
diginorm: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz 
	linking-quality
	protocol-diginorm-C20
	protocol-diginorm-filter
	protocol-diginorm-extract
	protocol-diginorm-C5
	protocol-diginorm-combine-pe-se
#--------------------------------------------------------------------------------------------------------------------------------
partition: ${WORKDIR}/${PREFIX}.pe.kak.qc.fq.gz ${WORKDIR}/${PREFIX}.se.kak.qc.fq.gz 
	linking-diginorm
	protocol-partition-below
	protocol-partition-rename-1
	protocol-partition-run
	protocol-partition-extract
	protocol-partition-rename-2
	protocol-partition-compress
#--------------------------------------------Velvet Quality--------------------------------------------------------
velvet-quality:  ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz 
	velvet-quality-1
	finalize-velvet-quality
#---------------------------------------------IDBA Quality---------------------------------------------------------
idba-quality: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz 
	idba-quality-1
	idba-quality-2
	finalize-idba-quality	
#--------------------------------------------Spades Quality--------------------------------------------------------
spades-quality:  ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz
	spades-quality-1
	spades-quality-2
	finalize-spades-quality
#---------------------------------------------MEGAHIT QUALITY-----------------------------------------
megahit-quality: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz
	megahit-qc-1
	finalize-megahit-quality
#----------------------------------------------Velvet Diginorm---------------------------------------------------------
velvet-diginorm: ${WORKDIR}/${PREFIX}.pe.kak.qc.fq.gz ${WORKDIR}/${PREFIX}.se.kak.qc.fq.gz
	velvet-diginorm-1
	finalize-velvet-diginorm 
#----------------------------------------------IDBA Diginorm----------------------------------------------------------
idba-diginorm: ${WORKDIR}/${PREFIX}.pe.kak.qc.fq.gz ${WORKDIR}/${PREFIX}.se.kak.qc.fq.gz
	idba-diginorm-1
	idba-diginorm-2
	finalize-idba-diginorm 
#----------------------------------------------Spades Diginorm---------------------------------------------------------
spades-diginorm: ${WORKDIR}/${PREFIX}.pe.kak.qc.fq.gz ${WORKDIR}/${PREFIX}.se.kak.qc.fq.gz
	spades-diginorm-1
	spades-diginorm-2
	finalize-spades-diginorm  
#---------------------------------------------Megahit Diginorm----------------------------------------------------------
megahit-diginorm: ${WORKDIR}/${PREFIX}.pe.kak.qc.fq.gz ${WORKDIR}/${PREFIX}.se.kak.qc.fq.gz
	megahit-digi-1
	finalize-megahit-diginorm 
#------------------------------------------------Velvet  Partition-------------------------------------------------------------
velvet-partition:  ${WORKDIR}/normC5k20.kh 
	velvet-partition-1
	velvet-partition-2
	finalize-velvet-partition 
#-------------------------------------------------Spades Partition-------------------------------------------------------------
spades-partition:  ${WORKDIR}/normC5k20.kh  
	spades-partition-1
	spades-partition-2
	spades-partition-3
	finalize-spades-partition 
#--------------------------------------------------IDBA Partition--------------------------------------------------------------
idba-partition:  ${WORKDIR}/normC5k20.kh 
	idba-partition-1
	idba-partition-2
	idba-partition-3
	finalize-idba-partition
#---------------------------------------------------Megahit Partition------------------------------------------------------------
megahit-partition:  ${WORKDIR}/normC5k20.kh 
	megahit-part-1
	megahit-part-2
	finalize-megahit-partition
#----------------------------------------------------------------QUALITY STARTS-------------------------------------------------------------------------------
interleaving-1: ${DATA}/${PREFIX}-1.fastq.gz  ${DATA}/${PREFIX}-2.fastq.gz
	java -jar ${TRIM}/trimmomatic-0.32.jar PE ${DATA}/${PREFIX}-1.fastq.gz  ${DATA}/${PREFIX}-2.fastq.gz  s1_pe s1_se s2_pe s2_se ILLUMINACLIP:${TRIM}/adapters/TruSeq2-PE.fa:2:30:12 
	${SCRIPTS}/interleave-reads.py s1_pe s2_pe | gzip -9c > ${WORKDIR}/${PREFIX}.pe.fq.gz
	cat s1_se s2_se | gzip -9c > ${WORKDIR}/${PREFIX}.se.fq.gz

interleaving-2: ${WORKDIR}/${PREFIX}.se.fq.gz ${WORKDIR}/${PREFIX}.pe.fq.gz
	gunzip -c ${WORKDIR}/${PREFIX}.pe.fq.gz | ${TOOLKIT}/fastq_quality_filter -Q33 -q 30 -p 50 | gzip -9c > ${WORKDIR}/${PREFIX}.pe.qc.fq.gz 
	gunzip -c ${WORKDIR}/${PREFIX}.se.fq.gz | ${TOOLKIT}/fastq_quality_filter -Q33 -q 30 -p 50 | gzip -9c > ${WORKDIR}/${PREFIX}.se.qc.fq.gz

interleaving-3: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz
	extract-paired-reads.py ${WORKDIR}/${PREFIX}.pe.qc.fq.gz 

protocol-quality-rename-1: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz.pe
	./qc-rename-1.sh 
	touch protocol-quality-rename-1


protocol-quality-rename-2: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz.se
	./qc-rename-2.sh 
	touch protocol-quality-rename-2

#----------------------------------------------------------------VELVET QUALITY ------------------------------------------------------------------------------
velvet-quality-1: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz  
	./velvet-qc.sh 
	touch velvet-quality-1

finalize-velvet-quality: ${WORKDIR}/${PREFIX}.velvet.qc.*.d/contigs.fa 
	python ${SANDBOX}/sandbox/calc-best-assembly.py ${WORKDIR}/${PREFIX}.velvet.qc.*.d/contigs.fa -o ${WORKDIR}/velvet-quality-best.fa
	python ${SANDBOX}/sandbox/multi-rename.py assembly  ${WORKDIR}/velvet-quality-best.fa > ${WORKDIR}/velvet-quality-assembly.fa

#--------------------------------------------------------------SPADES QUALITY---------------------------------------------------------------------------------
spades-quality-1: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz
	./spades-qc.sh \
	touch spades-quality-1

spades-quality-2:  ${WORKDIR}/${PREFIX}.pe.qc.fq.gz
	/usr/bin/time -a -o ${WORKDIR}/sqc.txt spades.py --sc --pe1-12 ${WORKDIR}/${PREFIX}.pe.qc.fq.gz -o ${WORKDIR}/${PREFIX}.spades.d 

finalize-spades-quality: ${WORKDIR}/${PREFIX}.spades.d/contigs.fasta
	python ${SANDBOX}/sandbox/calc-best-assembly.py ${WORKDIR}/${PREFIX}.spades.d/contigs.fasta -o ${WORKDIR}/spades-quality-best.fa
	python ${SANDBOX}/sandbox/multi-rename.py assembly ${WORKDIR}/spades-quality-best.fa > ${WORKDIR}/spades-quality-assembly.fa
#------------------------------------------------------------------IDBA QUALITY-------------------------------------------------------------------------------
idba-quality-1: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz
	./idba-qc.sh && touch idba-quality-1

idba-quality-2: ${WORKDIR}/${PREFIX}.pe.fa
	/usr/bin/time -a -o ${WORKDIR}/iqc.txt idba_ud --pre_correction -r ${WORKDIR}/${PREFIX}.pe.fa -o ${WORKDIR}/${PREFIX}.idba.d.qc 

finalize-idba-quality: ${WORKDIR}/${PREFIX}.idba.d.qc/scaffold.fa
	python ${SANDBOX}/sandbox/calc-best-assembly.py ${WORKDIR}/${PREFIX}.idba.d.qc/scaffold.fa -o ${WORKDIR}/idba-quality-best.fa 
	python ${SANDBOX}/sandbox/multi-rename.py assembly ${WORKDIR}/idba-quality-best.fa > ${WORKDIR}/idba-quality-assembly.fa

#----------------------------------------------------------------Megahit Quality------------------------------------------------------------------------------
megahit-qc-1: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz
	/usr/bin/time  -a  -o ${WORKDIR}/megqc.txt python ${MEGAHIT}/megahit -l 101 -m 1e+10 --cpu-only -r ${WORKDIR}/${PREFIX}.pe.qc.fq.gz -o ${WORKDIR}/megahit.qc.pe \
	/usr/bin/time  -a  -o ${WORKDIR}/megqc.txt python ${MEGAHIT}/megahit -l 101 -m 1e+10 --cpu-only -r ${WORKDIR}/${PREFIX}.se.qc.fq.gz -o ${WORKDIR}/megahit.qc.se
finalize-megahit-quality:  ${WORKDIR}/megahit.qc.pe/final.contigs.fa ${WORKDIR}/megahit.qc.se/final.contigs.fa 
	python ${SANDBOX}/sandbox/calc-best-assembly.py ${WORKDIR}/megahit.qc.?e/final.contigs.fa -o ${WORKDIR}/megahit-quality-best.fa
	python ${SANDBOX}/sandbox/multi-rename.py assembly ${WORKDIR}/megahit-quality-best.fa > ${WORKDIR}/megahit-quality-assembly.fa        
#------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------READ INCORPORATION---------------------------------------------
reads-to-iqc: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz ${WORKDIR}/idba-quality-assembly500.fa 
	bwa index ${WORKDIR}/idba-quality-assembly500.fa 
	bwa aln ${WORKDIR}/idba-quality-assembly500.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz   > ${WORKDIR}/iq.pe.sai 
	bwa aln ${WORKDIR}/idba-quality-assembly500.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz   > ${WORKDIR}/iq.se.sai 
	bwa samse ${WORKDIR}/idba-quality-assembly500.fa ${WORKDIR}/iq.pe.sai ${WORKDIR}/${PREFIX}.pe.qc.fq.gz > ${WORKDIR}/iq.pe.sam 
	bwa samse ${WORKDIR}/idba-quality-assembly500.fa ${WORKDIR}/iq.se.sai ${WORKDIR}/${PREFIX}.se.qc.fq.gz > ${WORKDIR}/iq.se.sam
	samtools faidx ${WORKDIR}/idba-quality-assembly500.fa 
	samtools import ${WORKDIR}/idba-quality-assembly500.fa.fai ${WORKDIR}/iq.pe.sam ${WORKDIR}/iq.pe.bam 
	samtools import ${WORKDIR}/idba-quality-assembly500.fa.fai ${WORKDIR}/iq.se.sam ${WORKDIR}/iq.se.bam 
	samtools faidx ${WORKDIR}/idba-quality-assembly500.fa 
	samtools import ${WORKDIR}/idba-quality-assembly500.fa.fai ${WORKDIR}/iq.pe.sam ${WORKDIR}/iq.pe.bam 
	samtools import ${WORKDIR}/idba-quality-assembly500.fa.fai ${WORKDIR}/iq.se.sam ${WORKDIR}/iq.se.bam 
	samtools view -c -f 4 ${WORKDIR}/iq.pe.bam > ${WORKDIR}/iq-unmapped.count
	samtools view -c -f 4 ${WORKDIR}/iq.se.bam >> ${WORKDIR}/iq-unmapped.count 

reads-to-sqc:  ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz ${WORKDIR}/spades-quality-assembly500.fa 
	bwa index ${WORKDIR}/spades-quality-assembly500.fa 
	bwa aln ${WORKDIR}/spades-quality-assembly500.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz   > ${WORKDIR}/sq.pe.sai 
	bwa aln ${WORKDIR}/spades-quality-assembly500.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz   > ${WORKDIR}/sq.se.sai 
	bwa samse ${WORKDIR}/spades-quality-assembly500.fa ${WORKDIR}/sq.pe.sai ${WORKDIR}/${PREFIX}.pe.qc.fq.gz > ${WORKDIR}/sq.pe.sam 
	bwa samse ${WORKDIR}/spades-quality-assembly500.fa ${WORKDIR}/sq.se.sai ${WORKDIR}/${PREFIX}.se.qc.fq.gz > ${WORKDIR}/sq.se.sam 
	samtools faidx ${WORKDIR}/spades-quality-assembly500.fa 
	samtools import ${WORKDIR}/spades-quality-assembly500.fa.fai ${WORKDIR}/sq.pe.sam ${WORKDIR}/sq.pe.bam 
	samtools import ${WORKDIR}/spades-quality-assembly500.fa.fai ${WORKDIR}/sq.se.sam ${WORKDIR}/sq.se.bam 
	samtools view -c -f 4 ${WORKDIR}/sq.pe.bam > ${WORKDIR}/sq-unmapped.count
	samtools view -c -f 4 ${WORKDIR}/sq.se.bam >> ${WORKDIR}/sq-unmapped.count

reads-to-mqc:  ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz ${WORKDIR}/megahit-quality-assembly500.fa 
	bwa index ${WORKDIR}/megahit-quality-assembly500.fa 
	bwa aln ${WORKDIR}/megahit-quality-assembly500.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz   > ${WORKDIR}/mq.pe.sai 
	bwa aln ${WORKDIR}/megahit-quality-assembly500.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz   > ${WORKDIR}/mq.se.sai 
	bwa samse ${WORKDIR}/megahit-quality-assembly500.fa ${WORKDIR}/mq.pe.sai ${WORKDIR}/${PREFIX}.pe.qc.fq.gz > ${WORKDIR}/mq.pe.sam 
	bwa samse ${WORKDIR}/megahit-quality-assembly500.fa ${WORKDIR}/mq.se.sai ${WORKDIR}/${PREFIX}.se.qc.fq.gz > ${WORKDIR}/mq.se.sam 
	samtools faidx ${WORKDIR}/megahit-quality-assembly500.fa 
	samtools import ${WORKDIR}/megahit-quality-assembly500.fa.fai ${WORKDIR}/mq.pe.sam ${WORKDIR}/mq.pe.bam 
	samtools import ${WORKDIR}/megahit-quality-assembly500.fa.fai ${WORKDIR}/mq.se.sam ${WORKDIR}/mq.se.bam 
	samtools view -c -f 4 ${WORKDIR}/mq.pe.bam > ${WORKDIR}/mq-unmapped.count
	samtools view -c -f 4 ${WORKDIR}/mq.se.bam >> ${WORKDIR}/mq-unmapped.count

#-----------------------------------------------------------------Reads Coverage Profile----------------------------------------------------------------
reads-to-reference: ${WORKDIR}/${PREFIX}.pe.qc.fq.gz ${WORKDIR}/${PREFIX}.se.qc.fq.gz ${WORKDIR}/mircea.fa
	bwa index ${WORKDIR}/mircea.fa 
	bwa aln ${WORKDIR}/mircea.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz   > ${WORKDIR}/qc-ref.pe.sai 
	bwa aln ${WORKDIR}/mircea.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz   > ${WORKDIR}/qc-ref.se.sai
	bwa samse ${WORKDIR}/mircea.fa ${WORKDIR}/qc-ref.pe.sai ${WORKDIR}/${PREFIX}.pe.qc.fq.gz > ${WORKDIR}/qc-ref.pe.sam 
	bwa samse ${WORKDIR}/mircea.fa ${WORKDIR}/qc-ref.se.sai ${WORKDIR}/${PREFIX}.se.qc.fq.gz > ${WORKDIR}/qc-ref.se.sam
	samtools faidx ${WORKDIR}/mircea.fa 
	samtools import ${WORKDIR}/mircea.fa.fai ${WORKDIR}/qc-ref.pe.sam ${WORKDIR}/qc-ref.pe.bam 
	samtools import ${WORKDIR}/mircea.fa.fai ${WORKDIR}/qc-ref.se.sam ${WORKDIR}/qc-ref.se.bam 
	samtools merge ${WORKDIR}/qc-ref.bam ${WORKDIR}/qc-ref.pe.bam ${WORKDIR}/qc-ref.se.bam 
	samtools view -h -o ${WORKDIR}/qc-ref.sam ${WORKDIR}/qc-ref.bam

count-unmapped-reads: 
	samtools view -h -o ${WORKDIR}/qc-ref.pe.sam ${WORKDIR}/qc-ref.pe.bam
	samtools view -h -c -f 4 ${WORKDIR}/qc-ref.pe.bam >> unmapped-qc-to-ref 
	samtools view -h -o ${WORKDIR}/qc-ref.se.sam ${WORKDIR}/qc-ref.se.bam
	samtools view -h -c -f 4 ${WORKDIR}/qc-ref.se.bam >> unmapped-qc-to-ref 
      	

coverage-profile: ${WORKDIR}/mircea.fa ${WORKDIR}/qc-ref.sam
	python ${MYSCRIPTS}/cov.py ${WORKDIR}/mircea.fa ${WORKDIR}/qc-ref.sam ${WORKDIR}/${PREFIX}.qc.coverage 

#--------------------------------------------------------Unaligned Coverage Profile--------------------------------------------------------------------
iqc-unaligned:  ${WORKDIR}/iqc.AM99.pe.bam ${WORKDIR}/iqc.AM99.se.bam ${WORKDIR}/iqc.AM99.fa
	samtools view -h -f 4 ${WORKDIR}/iqc.AM99.bam > ${WORKDIR}/iqc.AM99.unmapped.bam 
	bash ${MYSCRIPTS}/get-unmapped.sh ${WORKDIR}/iqc.AM99.unmapped.bam > ${WORKDIR}/iqc.AM99.unmappedreads.fa 
	bwa index ${WORKDIR}/iqc.AM99.fa
	bwa aln ${WORKDIR}/iqc.AM99.fa ${WORKDIR}/iqc.AM99.unmappedreads.fa  >${WORKDIR}/iqc.AM99.unmapped.sai
	bwa samse ${WORKDIR}/iqc.AM99.fa ${WORKDIR}/iqc.AM99.unmapped.sai ${WORKDIR}/iqc.AM99.unmappedreads.fa > ${WORKDIR}/iqc.AM99.unmapped.sam

iqc-unaligned-cov: 
	python ${MYSCRIPTS}/cov.py ${WORKDIR}/iqc.AM99.fa ${WORKDIR}/iqc.AM99.unmapped.sam iqc.unmapped.out > ${WORKDIR}/iqc.Am99.unmapped.coverage 	


sqc-unaligned:  ${WORKDIR}/sqc.AM99.pe.bam ${WORKDIR}/sqc.AM99.se.bam ${WORKDIR}/sqc.AM99.fa
	samtools view -h -f 4 ${WORKDIR}/sqc.AM99.bam > ${WORKDIR}/sqc.AM99.unmapped.bam 
	bash ${MYSCRIPTS}/get-unmapped.sh ${WORKDIR}/sqc.AM99.unmapped.bam > ${WORKDIR}/sqc.AM99.unmappedreads.fa 
	bwa index ${WORKDIR}/sqc.AM99.fa
	bwa aln ${WORKDIR}/sqc.AM99.fa ${WORKDIR}/sqc.AM99.unmappedreads.fa  >${WORKDIR}/sqc.AM99.unmapped.sai
	bwa samse ${WORKDIR}/sqc.AM99.fa ${WORKDIR}/sqc.AM99.unmapped.sai ${WORKDIR}/sqc.AM99.unmappedreads.fa > ${WORKDIR}/sqc.AM99.unmapped.sam

sqc-unaligned-cov: 
	python ${MYSCRIPTS}/cov.py ${WORKDIR}/sqc.AM99.fa ${WORKDIR}/sqc.AM99.unmapped.sam sqc.unmapped.out > ${WORKDIR}/sqc.Am99.unmapped.coverage      


mqc-unaligned:  ${WORKDIR}/mqc.AM99.pe.bam ${WORKDIR}/mqc.AM99.se.bam ${WORKDIR}/mqc.AM99.fa
	samtools view -h -f 4 ${WORKDIR}/mqc.AM99.bam > ${WORKDIR}/mqc.AM99.unmapped.bam 
	bash ${MYSCRIPTS}/get-unmapped.sh ${WORKDIR}/mqc.AM99.unmapped.bam > ${WORKDIR}/mqc.AM99.unmappedreads.fa 
	bwa index ${WORKDIR}/mqc.AM99.fa
	bwa aln ${WORKDIR}/mqc.AM99.fa ${WORKDIR}/mqc.AM99.unmappedreads.fa  >${WORKDIR}/mqc.AM99.unmapped.sai
	bwa samse ${WORKDIR}/mqc.AM99.fa ${WORKDIR}/mqc.AM99.unmapped.sai ${WORKDIR}/mqc.AM99.unmappedreads.fa > ${WORKDIR}/mqc.AM99.unmapped.sam

mqc-unaligned-cov: 
	python ${MYSCRIPTS}/cov.py ${WORKDIR}/mqc.AM99.fa ${WORKDIR}/mqc.AM99.unmapped.sam mqc.unmapped.out > ${WORKDIR}/mqc.Am99.unmapped.coverage      

	#awk '$1 >=5 {sum += $2} END {print sum}' backup/all.unmapped.coverage
	#awk '{sum += $2} END {print sum}' backup/all.unmapped.coverage	
#------------------------------------------------------------Finding Chimeric Reads--------------------------------------------------------------------------
chimeric:  ${DATA}/mircea.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz ${WORKDIR}/${PREFIX}.pe.qc.fq.gz
	bwa index ${DATA}/mircea.fa 
	bwa mem -M -t 16 ${DATA}/mircea.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz  > ${PREFIX}-se.sam
	bwa mem -M -t 16 ${DATA}/mircea.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz  > ${PREFIX}-pe.sam
	samtools faidx ${DATA}/mircea.fa
	samtools import mircea.fa.fai ${PREFIX}-pe.sam ${PREFIX}-pe.bam
	samtools import mircea.fa.fai ${PREFIX}-se.sam ${PREFIX}-se.bam
	samtools view ${PREFIX}-pe.bam | grep 'SA:'  > ${PREFIX}-pe.chimeric
	samtools view ${PREFIX}-se.bam | grep 'SA:'  > ${PREFIX}-se.chimeric
	bash ${MYSCRIPTS}/count-chimeric.sh


partial-analysis:
	awk '$$3 < ${partial.cutoff}' ${WORKDIR}/iqc.QC.BESTHIT99.aligned.partial |wc -l > ${WORKDIR}/iqc.QC.BESTHIT99.aligned.partial.filtered
	awk '$$3 < ${partial.cutoff}' ${WORKDIR}/sqc.QC.BESTHIT99.aligned.partial |wc -l > ${WORKDIR}/iqc.QC.BESTHIT99.aligned.partial.filtered
	awk '$$3 < ${partial.cutoff}' ${WORKDIR}/mqc.QC.BESTHIT99.aligned.partial |wc -l > ${WORKDIR}/iqc.QC.BESTHIT99.aligned.partial.filtered
	awk '$$3 < ${partial.cutoff}'${WORKDIR}/iqc.QC.AMBIGIOUS99.aligned.partial |wc -l > ${WORKDIR}/iqc.QC.AMBIGIOUS99.aligned.partial.filtered
	awk '$$3 < ${partial.cutoff} '${WORKDIR}/sqc.QC.AMBIGIOUS99.aligned.partial |wc -l > ${WORKDIR}/sqc.QC.AMBIGIOUS99.aligned.partial.filtered
	awk '$$3 < ${partial.cutoff} '${WORKDIR}/mqc.QC.AMBIGIOUS99.aligned.partial |wc -l > ${WORKDIR}/mqc.QC.AMBIGIOUS99.aligned.partial.filtered


coverage-analysis: 
	sort -rn -k 3 ${WORKDIR}/iqc.QC.BESTHIT99.count.covered > ${WORKDIR}/iqc.QC.BESTHIT99.count.covered.sorted 
	sort -rn -k 3 ${WORKDIR}/sqc.QC.BESTHIT99.count.covered > ${WORKDIR}/sqc.QC.BESTHIT99.count.covered.sorted 	
	sort -rn -k 3 ${WORKDIR}/mqc.QC.BESTHIT99.count.covered > ${WORKDIR}/mqc.QC.BESTHIT99.count.covered.sorted 
	sort -rn -k 3 ${WORKDIR}/iqc.QC.AMBIGIOUS99.count.covered > ${WORKDIR}/iqc.QC.AMBIGIOUS99.count.covered.sorted 
	sort -rn -k 3 ${WORKDIR}/sqc.QC.AMBIGIOUS99.count.covered > ${WORKDIR}/sqc.QC.AMBIGIOUS99.count.covered.sorted 
	sort -rn -k 3 ${WORKDIR}/mqc.QC.AMBIGIOUS99.count.covered > ${WORKDIR}/mqc.QC.AMBIGIOUS99.count.covered.sorted 


#Unalignment Analysis: We used the unaligned contigs(from our script) and align reads to them. 
#We extract the reads that are aligned (those reads contribute to unalignment) and map them to reference genome
#to see whether they exist in the reference or not 

unaligned-analysis-AMI-iqc: 

	cat iqc500.QC.AMBIGIOUS500.99.unaligned > iqc.AM99.fa   
	bwa index ${WORKDIR}/iqc.AM99.fa
	bwa aln ${WORKDIR}/iqc.AM99.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz  > ${WORKDIR}/iqc.AM99.pe.sai
	bwa aln ${WORKDIR}/iqc.AM99.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz  > ${WORKDIR}/iqc.AM99.se.sai
	bwa samse ${WORKDIR}/iqc.AM99.fa ${WORKDIR}/iqc.AM99.pe.sai ${WORKDIR}/${PREFIX}.pe.qc.fq.gz  > ${WORKDIR}/iqc.AM99.pe.sam
	bwa samse ${WORKDIR}/iqc.AM99.fa ${WORKDIR}/iqc.AM99.se.sai ${WORKDIR}/${PREFIX}.se.qc.fq.gz  > ${WORKDIR}/iqc.AM99.se.sam
	samtools faidx ${WORKDIR}/iqc.AM99.fa
	samtools import ${WORKDIR}/iqc.AM99.fa.fai ${WORKDIR}/iqc.AM99.pe.sam ${WORKDIR}/iqc.AM99.pe.bam 
	samtools import ${WORKDIR}/iqc.AM99.fa.fai ${WORKDIR}/iqc.AM99.se.sam ${WORKDIR}/iqc.AM99.se.bam
	samtools view -h -F 4 ${WORKDIR}/iqc.AM99.pe.bam > ${WORKDIR}/iqc.AM99.mapped.pe.bam
	samtools view -h -F 4 ${WORKDIR}/iqc.AM99.se.bam > ${WORKDIR}/iqc.AM99.mapped.se.bam
	samtools view -c -F 4 ${WORKDIR}/iqc.AM99.pe.bam > ${WORKDIR}/iqc.AM99.aligned.reads
	samtools view -c -F 4 ${WORKDIR}/iqc.AM99.se.bam >> ${WORKDIR}/iqc.AM99.aligned.reads
	bash ${MYSCRIPTS}/get-mapped.sh ${WORKDIR}/iqc.AM99.mapped.pe.bam > ${WORKDIR}/iqc.AM99.mappedreads.fa
	bash ${MYSCRIPTS}/get-mapped.sh ${WORKDIR}/iqc.AM99.mapped.se.bam >> ${WORKDIR}/iqc.AM99.mappedreads.fa
	bwa index ${WORKDIR}/mircea.fa 
	bwa aln ${WORKDIR}/mircea.fa ${WORKDIR}/iqc.AM99.mappedreads.fa  >${WORKDIR}/iqc.AM99.sai
	bwa samse ${WORKDIR}/mircea.fa ${WORKDIR}/iqc.AM99.sai ${WORKDIR}/iqc.AM99.mappedreads.fa > ${WORKDIR}/iqc.AM99.sam
	samtools faidx ${WORKDIR}/mircea.fa 
	samtools import ${WORKDIR}/mircea.fa.fai ${WORKDIR}/iqc.AM99.sam ${WORKDIR}/iqc.AM99.bam 
	samtools view -c -F 4 ${WORKDIR}/iqc.AM99.bam > ${WORKDIR}/iqc.AM99-mapped-reads	



unaligned-analysis-AMI-sqc:

	cat sqc500.QC.AMBIGIOUS500.99.unaligned > sqc.AM99.fa 	
	bwa index ${WORKDIR}/sqc.AM99.fa
	bwa aln ${WORKDIR}/sqc.AM99.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz  > ${WORKDIR}/sqc.AM99.pe.sai
	bwa aln ${WORKDIR}/sqc.AM99.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz  > ${WORKDIR}/sqc.AM99.se.sai
	bwa samse ${WORKDIR}/sqc.AM99.fa ${WORKDIR}/sqc.AM99.pe.sai ${WORKDIR}/${PREFIX}.pe.qc.fq.gz  > ${WORKDIR}/sqc.AM99.pe.sam 
	bwa samse ${WORKDIR}/sqc.AM99.fa ${WORKDIR}/sqc.AM99.se.sai ${WORKDIR}/${PREFIX}.se.qc.fq.gz  > ${WORKDIR}/sqc.AM99.se.sam
	samtools faidx ${WORKDIR}/sqc.AM99.fa
	samtools import ${WORKDIR}/sqc.AM99.fa.fai ${WORKDIR}/sqc.AM99.pe.sam ${WORKDIR}/sqc.AM99.pe.bam 
	samtools import ${WORKDIR}/sqc.AM99.fa.fai ${WORKDIR}/sqc.AM99.se.sam ${WORKDIR}/sqc.AM99.se.bam
	samtools view -h -F 4 ${WORKDIR}/sqc.AM99.pe.bam > ${WORKDIR}/sqc.AM99.mapped.pe.bam
	samtools view -h -F 4 ${WORKDIR}/sqc.AM99.se.bam > ${WORKDIR}/sqc.AM99.mapped.se.bam
	samtools view -c -F 4 ${WORKDIR}/sqc.AM99.pe.bam > ${WORKDIR}/sqc.AM99.aligned.reads	
	samtools view -c -F 4 ${WORKDIR}/sqc.AM99.se.bam >> ${WORKDIR}/sqc.AM99.aligned.reads 
	bash ${MYSCRIPTS}/get-mapped.sh ${WORKDIR}/sqc.AM99.mapped.pe.bam > ${WORKDIR}/sqc.AM99.mappedreads.fa 
	bash ${MYSCRIPTS}/get-mapped.sh ${WORKDIR}/sqc.AM99.mapped.se.bam >> ${WORKDIR}/sqc.AM99.mappedreads.fa
	bwa index ${WORKDIR}/mircea.fa 
	bwa aln ${WORKDIR}/mircea.fa ${WORKDIR}/sqc.AM99.mappedreads.fa  >${WORKDIR}/sqc.AM99.sai
	bwa samse ${WORKDIR}/mircea.fa ${WORKDIR}/sqc.AM99.sai ${WORKDIR}/sqc.AM99.mappedreads.fa > ${WORKDIR}/sqc.AM99.sam
	samtools faidx ${WORKDIR}/mircea.fa 
	samtools import ${WORKDIR}/mircea.fa.fai ${WORKDIR}/sqc.AM99.sam ${WORKDIR}/sqc.AM99.bam 
	samtools view -c -F 4 ${WORKDIR}/sqc.AM99.bam > ${WORKDIR}/sqc.AM99-mapped-reads        

unaligned-analysis-AMI-mqc:

	cat mqc500.QC.AMBIGIOUS500.99.unaligned > mqc.AM99.fa   
	bwa index ${WORKDIR}/mqc.AM99.fa
	bwa aln ${WORKDIR}/mqc.AM99.fa ${WORKDIR}/${PREFIX}.pe.qc.fq.gz  > ${WORKDIR}/mqc.AM99.pe.sai
	bwa aln ${WORKDIR}/mqc.AM99.fa ${WORKDIR}/${PREFIX}.se.qc.fq.gz  > ${WORKDIR}/mqc.AM99.se.sai
	bwa samse ${WORKDIR}/mqc.AM99.fa ${WORKDIR}/mqc.AM99.pe.sai ${WORKDIR}/${PREFIX}.pe.qc.fq.gz  > ${WORKDIR}/mqc.AM99.pe.sam
	bwa samse ${WORKDIR}/mqc.AM99.fa ${WORKDIR}/mqc.AM99.se.sai ${WORKDIR}/${PREFIX}.se.qc.fq.gz  > ${WORKDIR}/mqc.AM99.se.sam
	samtools faidx ${WORKDIR}/mqc.AM99.fa
	samtools import ${WORKDIR}/mqc.AM99.fa.fai ${WORKDIR}/mqc.AM99.pe.sam ${WORKDIR}/mqc.AM99.pe.bam
	samtools import ${WORKDIR}/mqc.AM99.fa.fai ${WORKDIR}/mqc.AM99.se.sam ${WORKDIR}/mqc.AM99.se.bam
	samtools view -h -F 4 ${WORKDIR}/mqc.AM99.pe.bam > ${WORKDIR}/mqc.AM99.mapped.pe.bam
	samtools view -h -F 4 ${WORKDIR}/mqc.AM99.se.bam > ${WORKDIR}/mqc.AM99.mapped.se.bam
	samtools view -c -F 4 ${WORKDIR}/mqc.AM99.pe.bam > ${WORKDIR}/mqc.AM99.aligned.reads
	samtools view -c -F 4 ${WORKDIR}/mqc.AM99.se.bam >> ${WORKDIR}/mqc.AM99.aligned.reads
	bash ${MYSCRIPTS}/get-mapped.sh ${WORKDIR}/mqc.AM99.mapped.pe.bam > ${WORKDIR}/mqc.AM99.mappedreads.fa
	bash ${MYSCRIPTS}/get-mapped.sh ${WORKDIR}/mqc.AM99.mapped.se.bam >> ${WORKDIR}/mqc.AM99.mappedreads.fa
	bwa index ${WORKDIR}/mircea.fa
	bwa aln ${WORKDIR}/mircea.fa ${WORKDIR}/mqc.AM99.mappedreads.fa  >${WORKDIR}/mqc.AM99.sai
	bwa samse ${WORKDIR}/mircea.fa ${WORKDIR}/mqc.AM99.sai ${WORKDIR}/mqc.AM99.mappedreads.fa > ${WORKDIR}/mqc.AM99.sam
	samtools faidx ${WORKDIR}/mircea.fa
	samtools import ${WORKDIR}/mircea.fa.fai ${WORKDIR}/mqc.AM99.sam ${WORKDIR}/mqc.AM99.bam
	samtools view -c -F 4 ${WORKDIR}/mqc.AM99.bam > ${WORKDIR}/mqc.AM99-mapped-reads

#-----------------------------------------------------------------Minimum Contig Experiment------------------------------------------------------------------
idba-quality-mincontig: ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly.fa  
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly.fa 250 
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly.fa 500 
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly.fa 1000 
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly.fa 2000
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly.fa 3000


spades-quality-mincontig: ${DATA}/mircea.fa ${WORKDIR}/spades-quality-assembly.fa
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${DATA}/mircea.fa ${WORKDIR}/spades-quality-assembly.fa 250 
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${DATA}/mircea.fa ${WORKDIR}/spades-quality-assembly.fa 500 
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${DATA}/mircea.fa ${WORKDIR}/spades-quality-assembly.fa 1000 
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${DATA}/mircea.fa ${WORKDIR}/spades-quality-assembly.fa 2000
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${DATA}/mircea.fa ${WORKDIR}/spades-quality-assembly.fa 3000

megahit-quality-mincontig: ${DATA}/mircea.fa ${WORKDIR}/megahit-quality-assembly.fa 
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${DATA}/mircea.fa ${WORKDIR}/megahit-quality-assembly.fa 250 
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${DATA}/mircea.fa ${WORKDIR}/megahit-quality-assembly.fa 500 
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${DATA}/mircea.fa ${WORKDIR}/megahit-quality-assembly.fa 1000 
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${DATA}/mircea.fa ${WORKDIR}/megahit-quality-assembly.fa 2000
	python ${MYSCRIPTS}/filter_assembly_mincontig.py ${DATA}/mircea.fa ${WORKDIR}/megahit-quality-assembly.fa 3000

run-nucmer:
	${WORKDIR}/idba-quality-assembly2000.fa ${WORKDIR}/idba-quality-assembly3000.fa ${WORKDIR}/spades-quality-assembly250.fa  \
	${WORKDIR}/spades-quality-assembly500.fa ${WORKDIR}/spades-quality-assembly1000.fa ${WORKDIR}/spades-quality-assembly3000.fa \
	${WORKDIR}/megahit-quality-assembly250.fa ${WORKDIR}/megahit-quality-assembly500.fa ${WORKDIR}/megahit-quality-assembly1000.fa \
	${WORKDIR}/megahit-quality-assembly2000.fa ${WORKDIR}/megahit-quality-assembly3000.fa
	
	${NUCMER}/nucmer --coords -p ${WORKDIR}/iqc250  ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly250.fa 
	${NUCMER}/nucmer --coords -p ${WORKDIR}/iqc500  ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly500.fa 	
	${NUCMER}/nucmer --coords -p ${WORKDIR}/iqc1000  ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly1000.fa
	${NUCMER}/nucmer --coords -p ${WORKDIR}/iqc2000 ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly2000.fa
	${NUCMER}/nucmer --coords -p ${WORKDIR}/iqc3000 ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly3000.fa 
		
	${NUCMER}/nucmer --coords -p ${WORKDIR}/sqc250  ${DATA}/mircea.fa ${WORKDIR}/spades-quality-assembly250.fa      
	${NUCMER}/nucmer --coords -p ${WORKDIR}/sqc500  ${DATA}/mircea.fa ${WORKDIR}/spades-quality-assembly500.fa
	${NUCMER}/nucmer --coords -p ${WORKDIR}/sqc1000  ${DATA}/mircea.fa ${WORKDIR}/spades-quality-assembly1000.fa
	${NUCMER}/nucmer --coords -p ${WORKDIR}/sqc2000 ${DATA}/mircea.fa ${WORKDIR}/spades-quality-assembly2000.fa
	${NUCMER}/nucmer --coords -p ${WORKDIR}/sqc3000 ${DATA}/mircea.fa ${WORKDIR}/spades-quality-assembly3000.fa
		
	${NUCMER}/nucmer --coords -p ${WORKDIR}/sqc250  ${DATA}/mircea.fa ${WORKDIR}/megahit-quality-assembly250.fa
	${NUCMER}/nucmer --coords -p ${WORKDIR}/sqc500  ${DATA}/mircea.fa ${WORKDIR}/megahit-quality-assembly500.fa
	${NUCMER}/nucmer --coords -p ${WORKDIR}/sqc1000  ${DATA}/mircea.fa ${WORKDIR}/megahit-quality-assembly1000.fa
	${NUCMER}/nucmer --coords -p ${WORKDIR}/sqc2000 ${DATA}/mircea.fa ${WORKDIR}/megahit-quality-assembly2000.fa
	${NUCMER}/nucmer --coords -p ${WORKDIR}/sqc3000 ${DATA}/mircea.fa ${WORKDIR}/megahit-quality-assembly3000.fa


	

run-analysis:
	python ${MYSCRIPTS}/analyze_assembly.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly500.fa ${WORKDIR}/spades-quality-assembly500.fa \
	${WORKDIR}/megahit-quality-assembly500.fa ${WORKDIR}/iqc500.coords ${WORKDIR}/sqc500.coords ${WORKDIR}/mqc500.coords \
	QC.AMBIGIOUS500.99 -a True 99 ${WORKDIR}/indeces.out 
	
	python ${MYSCRIPTS}/analyze_assembly.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly500.fa ${WORKDIR}/spades-quality-assembly500.fa \
	${WORKDIR}/megahit-quality-assembly500.fa ${WORKDIR}/iqc500.coords ${WORKDIR}/sqc500.coords ${WORKDIR}/mqc500.coords \
	QC.BESTHIT500.99 -b True 99 ${WORKDIR}/indeces.out  
	
	python ${MYSCRIPTS}/analyze_assembly.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly500.fa ${WORKDIR}/spades-quality-assembly500.fa \
        ${WORKDIR}/megahit-quality-assembly500.fa ${WORKDIR}/iqc500.coords ${WORKDIR}/sqc500.coords ${WORKDIR}/mqc500.coords \
        QC.NOOVERLAPS500.99 -c True 99 ${WORKDIR}/indeces.out 
	
	python ${MYSCRIPTS}/analyze_assembly.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly500.fa ${WORKDIR}/spades-quality-assembly500.fa \
	${WORKDIR}/megahit-quality-assembly500.fa ${WORKDIR}/iqc500.coords ${WORKDIR}/sqc500.coords ${WORKDIR}/mqc500.coords \
	QC.AMBIGIOUS500.95 -a True 95 ${WORKDIR}/indeces.out 
	
	python ${MYSCRIPTS}/analyze_assembly.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly500.fa ${WORKDIR}/spades-quality-assembly500.fa \
	${WORKDIR}/megahit-quality-assembly500.fa ${WORKDIR}/iqc500.coords ${WORKDIR}/sqc500.coords ${WORKDIR}/mqc500.coords \
	QC.BESTHIT500.95 -b True 95 ${WORKDIR}/indeces.out 
	
	python ${MYSCRIPTS}/analyze_assembly.py ${DATA}/mircea.fa ${WORKDIR}/idba-quality-assembly500.fa ${WORKDIR}/spades-quality-assembly500.fa \
	${WORKDIR}/megahit-quality-assembly500.fa ${WORKDIR}/iqc500.coords ${WORKDIR}/sqc500.coords ${WORKDIR}/mqc500.coords \
	QC.NOOVERLAPS500.95 -c True 95 ${WORKDIR}/indeces.out 
    	
#---------------------------------------------------------------Cleaning ------------------------------------------------------------------------------------	
clean: *.list *.list.unique
	rm *.list 
	rm *.list.unique  
