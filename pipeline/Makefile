FULL_REFERENCE=mircea.fa
REFERENCE = mircea.rm13.fa
MYSCRIPTS = ./
NUCMER = /mnt/home/mahmoud4/MUMmer3.23
SPADES = /mnt/home/mahmoud4/SPAdes-3.9.0-Linux/bin
MEGAHIT=/mnt/home/mahmoud4/megahit
TRIM = /opt/software/Trimmomatic/0.32
TOOLKIT =/opt/software/FASTX/0.0.14--GCC-4.4.5/bin
SANDBOX = /opt/software/khmer/2.0--GCC-4.8.2
SCRIPTS = /opt/software/khmer/2.0--GCC-4.8.2/scripts
mc=500

# remove 18 genomes for crimes of strain variation

${REFERENCE}: ${FULL_REFERENCE}
	python ./subtract-names.py genome-remove-list.txt ${FULL_REFERENCE} > ${REFERENCE}

#-----------------------------------------------------------All quality-------------------------------------------------------------------------------------
quality: SRR606249-1.fastq.gz   SRR606249-2.fastq.gz \
	SRR606249.se.qc.fq.gz 
#-------------------------------------------------SPAdes Quality----------------------------------------------------------------------------------------
spades-quality: SRR606249.pe.qc.fq.gz \
	SRR606249.spades.d/scaffolds.fasta \
	spades-quality-assembly.fa 

#-------------------------------------------------IDBA Quality----------------------------------------------------------------------------------------
idba-quality: SRR606249.pe.qc.fq.gz \
	SRR606249.pe.fa \
	SRR606249.idba.d.qc/scaffold.fa \
	idba-quality-assembly.fa 
#------------------------------------------------Megahit Quality-------------------------------------------------------------------------------------------- 
megahit-quality: SRR606249.pe.qc.fq.gz \
	megahit.qc.pe/final.contigs.fa \
	megahit-quality-assembly.fa  
#-------------------------------------------------Run Analysis----------------------------------------------------------------------------------------------
analysis: idba-quality-assembly500.fa spades-quality-assembly500.fa \
	megahit-quality-assembly500.fa \
	mqc500.coords \
	assemblies.stats.QC.AMBIGUOUS.99 \
	assemblies.stats.QC.AMBIGUOUS.95 \
	stats 

#calculate reads coverage 
readcoverage: SRR606249.pe.qc.fq.gz \
	qc-ref.sam \
	unmapped-qc-to-ref \
	SRR606249.qc.coverage
#count the reads that map to the unaligned contigs and not to the reference 
countunmapped: SRR606249.pe.qc.fq.gz megahit-quality-assembly500.fa \
	iq-unmapped.count \
	sq-unmapped.count \
	mq-unmapped.count
#for the unaligned contigs, find their coverage 
unalignedcoverage: SRR606249.pe.qc.fq.gz assemblies.stats.QC.AMBIGUOUS.99 \
	iqc.AM99-mapped-reads \
	iqc.AM99.unmapped.sam \
	iqc.unmapped.out \
	sqc.AM99-mapped-reads \
	sqc.AM99.unmapped.sam \
	sqc.unmapped.out \
	mqc.AM99-mapped-reads \
	mqc.AM99.unmapped.sam \
	mqc.unmapped.out 
 
#run-analysis.sh includes in addition to the above: common-uncovered-coverage.out and mqc500.dist	 
#-----------------------------------------------------------QUALITY STARTS-------------------------------------------------------------------------------
SRR606249.se.qc.fq.gz:   SRR606249-1.fastq.gz   SRR606249-2.fastq.gz
	java -jar ${TRIM}/trimmomatic-0.32.jar PE  SRR606249-1.fastq.gz   SRR606249-2.fastq.gz  s1_pe s1_se s2_pe s2_se ILLUMINACLIP:${TRIM}/adapters/TruSeq2-PE.fa:2:40:15 \
	LEADING:2 TRAILING:2 SLIDINGWINDOW:4:2 MINLEN:25 
	${SCRIPTS}/interleave-reads.py s1_pe s2_pe | gzip -9c > SRR606249.pe.qc.fq.gz 
	cat s1_se s2_se | gzip -9c > SRR606249.se.qc.fq.gz

#-------------------------------------------------------------SPADES QUALITY---------------------------------------------------------------------------------
SRR606249.spades.d/scaffolds.fasta: SRR606249.pe.qc.fq.gz SRR606249.se.qc.fq.gz 
	/usr/bin/time -a -o sqc.txt  ${SPADES}/spades.py --meta --pe1-12 SRR606249.pe.qc.fq.gz --pe1-s SRR606249.se.qc.fq.gz -o SRR606249.spades.d

spades-quality-assembly.fa: SRR606249.spades.d/scaffolds.fasta  
	python ${MYSCRIPTS}/multi-rename.py assembly SRR606249.spades.d/scaffolds.fasta  > spades-quality-assembly.fa

#-----------------------------------------------------------------IDBA QUALITY-------------------------------------------------------------------------------
SRR606249.pe.fa: SRR606249.pe.qc.fq.gz 
	fastq-to-fasta.py -n SRR606249.pe.qc.fq.gz >SRR606249.pe.fa 
SRR606249.idba.d.qc/scaffold.fa: SRR606249.pe.fa
	/usr/bin/time -a -o iqc.txt idba_ud --pre_correction -r SRR606249.pe.fa -o SRR606249.idba.d.qc 

idba-quality-assembly.fa: SRR606249.idba.d.qc/scaffold.fa
	python ${MYSCRIPTS}/multi-rename.py assembly SRR606249.idba.d.qc/scaffold.fa > idba-quality-assembly.fa
#---------------------------------------------------------------Megahit Quality------------------------------------------------------------------------------

# @CTB we are specifying -m here...?
megahit.qc.pe/final.contigs.fa: SRR606249.pe.qc.fq.gz  
	#rm -r megahit.qc.pe
	/usr/bin/time  -a  -o megqc.txt python ${MEGAHIT}/megahit -l 101 -m 1e+10 --cpu-only --presets meta-large --12 SRR606249.pe.qc.fq.gz -r SRR606249.se.qc.fq.gz -o megahit.qc.pe 

megahit-quality-assembly.fa: megahit.qc.pe/final.contigs.fa 
	python ${MYSCRIPTS}/multi-rename.py assembly megahit.qc.pe/final.contigs.fa > megahit-quality-assembly.fa	 
#-------------------------------------------------------------------Analysis--------------------------------------------------------------------------------
megahit-quality-assembly500.fa: # idba-quality-assembly.fa  spades-quality-assembly.fa  megahit-quality-assembly.fa 
	python ${MYSCRIPTS}/filter_assembly_mincontig.py idba-quality-assembly.fa 500	
	python ${MYSCRIPTS}/filter_assembly_mincontig.py spades-quality-assembly.fa 500 
	python ${MYSCRIPTS}/filter_assembly_mincontig.py megahit-quality-assembly.fa 500 

mqc500.coords: #megahit-quality-assembly500.fa 
	${NUCMER}/nucmer --coords -p  iqc500  ${REFERENCE}  idba-quality-assembly500.fa
	${NUCMER}/nucmer --coords -p  sqc500  ${REFERENCE}  spades-quality-assembly500.fa
	${NUCMER}/nucmer --coords -p  mqc500  ${REFERENCE}  megahit-quality-assembly500.fa

assemblies.stats.QC.AMBIGUOUS.99: mqc500.coords
	python ${MYSCRIPTS}/analyze_assembly.py  ${REFERENCE}  idba-quality-assembly500.fa  spades-quality-assembly500.fa \
         megahit-quality-assembly500.fa  iqc500.coords  sqc500.coords  mqc500.coords QC.AMBIGUOUS.99 -a True 99 

	python ${MYSCRIPTS}/analyze_assembly.py  ${REFERENCE}  idba-quality-assembly500.fa  spades-quality-assembly500.fa \
         megahit-quality-assembly500.fa  iqc500.coords  sqc500.coords  mqc500.coords QC.BESTHIT.99 -b True 99

	python ${MYSCRIPTS}/analyze_assembly.py  ${REFERENCE}  idba-quality-assembly500.fa  spades-quality-assembly500.fa \
         megahit-quality-assembly500.fa  iqc500.coords  sqc500.coords  mqc500.coords QC.NOOVERLAP.99 -c True 99

assemblies.stats.QC.AMBIGUOUS.95: mqc500.coords
	python ${MYSCRIPTS}/analyze_assembly.py  ${REFERENCE}  idba-quality-assembly500.fa  spades-quality-assembly500.fa \
	megahit-quality-assembly500.fa  iqc500.coords  sqc500.coords  mqc500.coords QC.AMBIGUOUS.95 -a True 95 
	python ${MYSCRIPTS}/analyze_assembly.py  ${REFERENCE}  idba-quality-assembly500.fa  spades-quality-assembly500.fa \
	megahit-quality-assembly500.fa  iqc500.coords  sqc500.coords  mqc500.coords QC.BESTHIT.95 -b True 95
	python ${MYSCRIPTS}/analyze_assembly.py  ${REFERENCE}  idba-quality-assembly500.fa  spades-quality-assembly500.fa \
	megahit-quality-assembly500.fa  iqc500.coords  sqc500.coords  mqc500.coords QC.NOOVERLAP.95 -c True 95

stats: megahit-quality-assembly500.fa 
	python ${MYSCRIPTS}/compute_stats.py idba-quality-assembly500.fa ${REFERENCE} > idba.stats 
	python ${MYSCRIPTS}/compute_stats.py spades-quality-assembly500.fa ${REFERENCE} > spades.stats
	python ${MYSCRIPTS}/compute_stats.py megahit-quality-assembly500.fa ${REFERENCE} > megahit.stats


annotate-prokka: ${REFERENCE} # megahit-quality-assembly500.fa
	prokka ${REFERENCE} --outdir mprokka --prefix testasm --metagenome

parse-prokka: mprokka/testasm.tbl
	${MYSCRIPTS}/parse-prokka.py mprokka/testasm.tbl prokka.out
	${MYSCRIPTS}/analyze_assembly_prokka.py  ${REFERENCE}  idba-quality-assembly500.fa  spades-quality-assembly500.fa \
	megahit-quality-assembly500.fa  iqc500.coords  sqc500.coords  mqc500.coords QC.AMBIGUOUS.99 -a True 99 prokka.out  	



#----------------------------------------------------------------Reads Coverage-----------------------------------------------------------------------------
qc-ref.sam: ${FULL_REFERENCE} SRR606249.pe.qc.fq.gz
	bwa index  ${FULL_REFERENCE} 
	bwa aln  ${FULL_REFERENCE}  SRR606249.pe.qc.fq.gz   >  qc-ref.pe.sai 
	bwa aln  ${FULL_REFERENCE}  SRR606249.se.qc.fq.gz   >  qc-ref.se.sai
	bwa samse ${FULL_REFERENCE}  qc-ref.pe.sai  SRR606249.pe.qc.fq.gz >  qc-ref.pe.sam 
	bwa samse  ${FULL_REFERENCE}  qc-ref.se.sai  SRR606249.se.qc.fq.gz >  qc-ref.se.sam
	samtools faidx  ${FULL_REFERENCE} 
	samtools import  ${FULL_REFERENCE}.fai  qc-ref.pe.sam  qc-ref.pe.bam 
	samtools import  ${FULL_REFERENCE}.fai  qc-ref.se.sam  qc-ref.se.bam 
	samtools merge  qc-ref.bam  qc-ref.pe.bam  qc-ref.se.bam 
	samtools view -h -o  qc-ref.sam  qc-ref.bam

unmapped-qc-to-ref: qc-ref.sam 
	samtools view -h -o  qc-ref.pe.sam  qc-ref.pe.bam
	samtools view -h -c -f 4  qc-ref.pe.bam >> unmapped-qc-to-ref 
	samtools view -h -o  qc-ref.se.sam  qc-ref.se.bam
	samtools view -h -c -f 4  qc-ref.se.bam >> unmapped-qc-to-ref

unmapped-qc-to-ref.fq:
	samtools view -f 4 -b qc-ref.bam > unmapped-qc-to-ref.bam
	samtools bam2fq unmapped-qc-to-ref.bam > unmapped-qc-to-ref.fq

# @CTB fix PE issue
mqc-unmapped-reads.fa: unmapped-qc-to-ref.fq
	python ${MEGAHIT}/megahit -l 101 --cpu-only --presets meta-large -r unmapped-qc-to-ref.fq -o mqc-unmapped-reads
	python ${MYSCRIPTS}/multi-rename.py unmapped mqc-unmapped-reads/final.contigs.fa > mqc-unmapped-reads.fa

SRR606249.qc.coverage: qc-ref.sam
	python ${MYSCRIPTS}/coverage-profile.py  ${REFERENCE}  qc-ref.sam  SRR606249.qc.coverage 

#-------------------------------------------------------------READ INCORPORATION---------------------------------------------
iq-unmapped.count:  SRR606249.pe.qc.fq.gz  megahit-quality-assembly500.fa
	bwa index  idba-quality-assembly500.fa 
	bwa aln  idba-quality-assembly500.fa  SRR606249.pe.qc.fq.gz   >  iq.pe.sai 
	bwa aln  idba-quality-assembly500.fa  SRR606249.se.qc.fq.gz   >  iq.se.sai 
	bwa samse  idba-quality-assembly500.fa  iq.pe.sai  SRR606249.pe.qc.fq.gz >  iq.pe.sam 
	bwa samse  idba-quality-assembly500.fa  iq.se.sai  SRR606249.se.qc.fq.gz >  iq.se.sam
	samtools faidx  idba-quality-assembly500.fa 
	samtools import  idba-quality-assembly500.fa.fai  iq.pe.sam  iq.pe.bam 
	samtools import  idba-quality-assembly500.fa.fai  iq.se.sam  iq.se.bam 
	samtools faidx  idba-quality-assembly500.fa 
	samtools import  idba-quality-assembly500.fa.fai  iq.pe.sam  iq.pe.bam 
	samtools import  idba-quality-assembly500.fa.fai  iq.se.sam  iq.se.bam 
	samtools view -c -f 4  iq.pe.bam >  iq-unmapped.count
	samtools view -c -f 4  iq.se.bam >>  iq-unmapped.count 

sq-unmapped.count: SRR606249.pe.qc.fq.gz  megahit-quality-assembly500.fa
	bwa index  spades-quality-assembly500.fa 
	bwa aln  spades-quality-assembly500.fa  SRR606249.pe.qc.fq.gz   >  sq.pe.sai 
	bwa aln  spades-quality-assembly500.fa  SRR606249.se.qc.fq.gz   >  sq.se.sai 
	bwa samse  spades-quality-assembly500.fa  sq.pe.sai  SRR606249.pe.qc.fq.gz >  sq.pe.sam 
	bwa samse  spades-quality-assembly500.fa  sq.se.sai  SRR606249.se.qc.fq.gz >  sq.se.sam 
	samtools faidx  spades-quality-assembly500.fa 
	samtools import  spades-quality-assembly500.fa.fai  sq.pe.sam  sq.pe.bam 
	samtools import  spades-quality-assembly500.fa.fai  sq.se.sam  sq.se.bam 
	samtools view -c -f 4  sq.pe.bam >  sq-unmapped.count
	samtools view -c -f 4  sq.se.bam >>  sq-unmapped.count

mq-unmapped.count: SRR606249.pe.qc.fq.gz megahit-quality-assembly500.fa
	bwa index  megahit-quality-assembly500.fa 
	bwa aln  megahit-quality-assembly500.fa  SRR606249.pe.qc.fq.gz   >  mq.pe.sai 	
	bwa aln  megahit-quality-assembly500.fa  SRR606249.se.qc.fq.gz   >  mq.se.sai 
	bwa samse  megahit-quality-assembly500.fa  mq.pe.sai  SRR606249.pe.qc.fq.gz >  mq.pe.sam 
	bwa samse  megahit-quality-assembly500.fa  mq.se.sai  SRR606249.se.qc.fq.gz >  mq.se.sam 
	samtools faidx  megahit-quality-assembly500.fa 
	samtools import  megahit-quality-assembly500.fa.fai  mq.pe.sam  mq.pe.bam 
	samtools import  megahit-quality-assembly500.fa.fai  mq.se.sam  mq.se.bam 
	samtools view -c -f 4  mq.pe.bam >  mq-unmapped.count
	samtools view -c -f 4  mq.se.bam >>  mq-unmapped.count

#--------------------------------------------------------Unaligned Coverage Profile--------------------------------------------------------------------
iqc.AM99-mapped-reads: ${REFERENCE} assemblies.stats.QC.AMBIGUOUS.99
	cat iqc500.QC.AMBIGUOUS.99.unaligned > iqc.AM99.fa   
	bwa index  iqc.AM99.fa
	bwa aln  iqc.AM99.fa  SRR606249.pe.qc.fq.gz  >  iqc.AM99.pe.sai
	bwa aln  iqc.AM99.fa  SRR606249.se.qc.fq.gz  >  iqc.AM99.se.sai
	bwa samse  iqc.AM99.fa  iqc.AM99.pe.sai  SRR606249.pe.qc.fq.gz  >  iqc.AM99.pe.sam
	bwa samse  iqc.AM99.fa  iqc.AM99.se.sai  SRR606249.se.qc.fq.gz  >  iqc.AM99.se.sam
	samtools faidx  iqc.AM99.fa
	samtools import  iqc.AM99.fa.fai  iqc.AM99.pe.sam  iqc.AM99.pe.bam 
	samtools import  iqc.AM99.fa.fai  iqc.AM99.se.sam  iqc.AM99.se.bam
	samtools view -h -F 4  iqc.AM99.pe.bam >  iqc.AM99.mapped.pe.bam
	samtools view -h -F 4  iqc.AM99.se.bam >  iqc.AM99.mapped.se.bam
	samtools view -c -F 4  iqc.AM99.pe.bam >  iqc.AM99.aligned.reads
	samtools view -c -F 4  iqc.AM99.se.bam >>  iqc.AM99.aligned.reads
	bash ${MYSCRIPTS}/get-mapped.sh  iqc.AM99.mapped.pe.bam >  iqc.AM99.mappedreads.fa
	bash ${MYSCRIPTS}/get-mapped.sh  iqc.AM99.mapped.se.bam >>  iqc.AM99.mappedreads.fa
	bwa index  ${REFERENCE}
	bwa aln ${REFERENCE}  iqc.AM99.mappedreads.fa  > iqc.AM99.sai
	bwa samse ${REFERENCE}  iqc.AM99.sai  iqc.AM99.mappedreads.fa >  iqc.AM99.sam
	samtools faidx ${REFERENCE}
	samtools import ${REFERENCE}.fai  iqc.AM99.sam  iqc.AM99.bam
	samtools view -c -F 4  iqc.AM99.bam >  iqc.AM99-mapped-reads

iqc.AM99.unmapped.sam:  iqc.AM99-mapped-reads
	samtools view -h -f 4  iqc.AM99.bam >  iqc.AM99.unmapped.bam 
	bash ${MYSCRIPTS}/get-unmapped.sh  iqc.AM99.unmapped.bam >  iqc.AM99.unmappedreads.fa 
	bwa index iqc.AM99.fa
	bwa aln iqc.AM99.fa iqc.AM99.unmappedreads.fa  > iqc.AM99.unmapped.sai
	bwa samse  iqc.AM99.fa iqc.AM99.unmapped.sai  iqc.AM99.unmappedreads.fa >  iqc.AM99.unmapped.sam

iqc.unmapped.out: iqc.AM99.unmapped.sam
	python ${MYSCRIPTS}/coverage-profile.py iqc.AM99.fa iqc.AM99.unmapped.sam iqc.unmapped.out     



sqc.AM99-mapped-reads: ${REFERENCE} assemblies.stats.QC.AMBIGUOUS.99 
	cat sqc500.QC.AMBIGUOUS.99.unaligned  > sqc.AM99.fa         
	bwa index  sqc.AM99.fa
	bwa aln  sqc.AM99.fa  SRR606249.pe.qc.fq.gz  >  sqc.AM99.pe.sai
	bwa aln  sqc.AM99.fa  SRR606249.se.qc.fq.gz  >  sqc.AM99.se.sai
	bwa samse  sqc.AM99.fa  sqc.AM99.pe.sai  SRR606249.pe.qc.fq.gz  >  sqc.AM99.pe.sam 
	bwa samse  sqc.AM99.fa  sqc.AM99.se.sai  SRR606249.se.qc.fq.gz  >  sqc.AM99.se.sam
	samtools faidx  sqc.AM99.fa
	samtools import  sqc.AM99.fa.fai  sqc.AM99.pe.sam  sqc.AM99.pe.bam 
	samtools import  sqc.AM99.fa.fai  sqc.AM99.se.sam  sqc.AM99.se.bam
	samtools view -h -F 4  sqc.AM99.pe.bam >  sqc.AM99.mapped.pe.bam
	samtools view -h -F 4  sqc.AM99.se.bam >  sqc.AM99.mapped.se.bam
	samtools view -c -F 4  sqc.AM99.pe.bam >  sqc.AM99.aligned.reads   
	samtools view -c -F 4  sqc.AM99.se.bam >>  sqc.AM99.aligned.reads 
	bash ${MYSCRIPTS}/get-mapped.sh  sqc.AM99.mapped.pe.bam >  sqc.AM99.mappedreads.fa
	bash ${MYSCRIPTS}/get-mapped.sh  sqc.AM99.mapped.se.bam >>  sqc.AM99.mappedreads.fa
	bwa index ${REFERENCE}
	bwa aln ${REFERENCE}  sqc.AM99.mappedreads.fa  > sqc.AM99.sai
	bwa samse ${REFERENCE}  sqc.AM99.sai  sqc.AM99.mappedreads.fa >  sqc.AM99.sam
	samtools faidx ${REFERENCE}
	samtools import ${REFERENCE}.fai  sqc.AM99.sam  sqc.AM99.bam
	samtools view -c -F 4  sqc.AM99.bam >  sqc.AM99-mapped-reads

sqc.AM99.unmapped.sam:   sqc.AM99-mapped-reads
	samtools view -h -f 4  sqc.AM99.bam >  sqc.AM99.unmapped.bam 
	bash ${MYSCRIPTS}/get-unmapped.sh  sqc.AM99.unmapped.bam >  sqc.AM99.unmappedreads.fa 	
	bwa index sqc.AM99.fa
	bwa aln sqc.AM99.fa sqc.AM99.unmappedreads.fa  > sqc.AM99.unmapped.sai
	bwa samse sqc.AM99.fa sqc.AM99.unmapped.sai  sqc.AM99.unmappedreads.fa >  sqc.AM99.unmapped.sam

sqc.unmapped.out: sqc.AM99.unmapped.sam 
	python ${MYSCRIPTS}/coverage-profile.py sqc.AM99.fa sqc.AM99.unmapped.sam sqc.unmapped.out      


mqc.AM99-mapped-reads: ${REFERENCE} assemblies.stats.QC.AMBIGUOUS.99 
	cat mqc500.QC.AMBIGUOUS.99.unaligned  >mqc.AM99.fa 
	bwa index  mqc.AM99.fa
	bwa aln  mqc.AM99.fa  SRR606249.pe.qc.fq.gz  >  mqc.AM99.pe.sai
	bwa aln  mqc.AM99.fa  SRR606249.se.qc.fq.gz  >  mqc.AM99.se.sai
	bwa samse  mqc.AM99.fa  mqc.AM99.pe.sai  SRR606249.pe.qc.fq.gz  >  mqc.AM99.pe.sam
	bwa samse  mqc.AM99.fa  mqc.AM99.se.sai  SRR606249.se.qc.fq.gz  >  mqc.AM99.se.sam
	samtools faidx  mqc.AM99.fa
	samtools import  mqc.AM99.fa.fai  mqc.AM99.pe.sam  mqc.AM99.pe.bam
	samtools import  mqc.AM99.fa.fai  mqc.AM99.se.sam  mqc.AM99.se.bam
	samtools view -h -F 4  mqc.AM99.pe.bam >  mqc.AM99.mapped.pe.bam
	samtools view -h -F 4  mqc.AM99.se.bam >  mqc.AM99.mapped.se.bam
	samtools view -c -F 4  mqc.AM99.pe.bam >  mqc.AM99.aligned.reads
	samtools view -c -F 4  mqc.AM99.se.bam >>  mqc.AM99.aligned.reads
	bash ${MYSCRIPTS}/get-mapped.sh  mqc.AM99.mapped.pe.bam >  mqc.AM99.mappedreads.fa
	bash ${MYSCRIPTS}/get-mapped.sh  mqc.AM99.mapped.se.bam >>  mqc.AM99.mappedreads.fa
	bwa index ${REFERENCE}
	bwa aln ${REFERENCE}  mqc.AM99.mappedreads.fa  > mqc.AM99.sai
	bwa samse ${REFERENCE}  mqc.AM99.sai  mqc.AM99.mappedreads.fa >  mqc.AM99.sam
	samtools faidx ${REFERENCE}
	samtools import ${REFERENCE}.fai  mqc.AM99.sam  mqc.AM99.bam
	samtools view -c -F 4  mqc.AM99.bam >  mqc.AM99-mapped-reads

mqc.AM99.unmapped.sam:   mqc.AM99-mapped-reads
	samtools view -h -f 4  mqc.AM99.bam >  mqc.AM99.unmapped.bam 
	bash ${MYSCRIPTS}/get-unmapped.sh  mqc.AM99.unmapped.bam >  mqc.AM99.unmappedreads.fa 
	bwa index mqc.AM99.fa
	bwa aln mqc.AM99.fa mqc.AM99.unmappedreads.fa  > mqc.AM99.unmapped.sai
	bwa samse mqc.AM99.fa mqc.AM99.unmapped.sai  mqc.AM99.unmappedreads.fa >  mqc.AM99.unmapped.sam

mqc.unmapped.out: mqc.AM99.unmapped.sam
	python ${MYSCRIPTS}/coverage-profile.py mqc.AM99.fa mqc.AM99.unmapped.sam mqc.unmapped.out   

#awk '$1 >=5 {sum += $2} END {print sum}' backup/all.unmapped.coverage
#awk '{sum += $2} END {print sum}' backup/all.unmapped.coverage 

#-----------------------------------------------------Common Uncovered Coverage-----------------------------------------------------------------------------
common-uncovered-coverage.out: qc-ref.sam  assemblies.stats.QC.AMBIGUOUS.99
	python ${MYSCRIPTS}/common-uncovered-coverage.py ${REFERENCE} qc-ref.sam QC.AMBIGUOUS.99.uncovered.bases common-uncovered-coverage.out 

#------------------------------------------------------------Kmer Abundance---------------------------------------------------------------------------------
mqc500.dist: SRR606249.pe.qc.fq.gz megahit-quality-assembly500.fa
	gunzip -c SRR606249.pe.qc.fq.gz > SRR606249.pe.qc.fastq 
	gunzip -c SRR606249.se.qc.fq.gz > SRR606249.se.qc.fastq  
	python ${SCRIPTS}/load-into-counting.py -x 2e9 -N 4 -k 20 qc.counts.kh SRR606249.pe.qc.fastq SRR606249.se.qc.fastq 
	python ${SCRIPTS}/abundance-dist.py -s qc.counts.kh ${REFERENCE} SRR606249.qc.dist -s
	cat SRR606249.pe.qc.fastq SRR606249.se.qc.fastq  > SRR606249-qc.fastq 
	python ${SCRIPTS}/abundance-dist.py qc.counts.kh SRR606249-qc.fastq qc.dist -s
	cat idba-quality-assembly500.fa spades-quality-assembly500.fa megahit-quality-assembly500.fa > qc-assembly500.fa 
	python ${SCRIPTS}/abundance-dist.py -s qc.counts.kh qc-assembly500.fa qc500.dist -s
	python ${SCRIPTS}/abundance-dist.py -s qc.counts.kh idba-quality-assembly500.fa  iqc500.dist -s
	python ${SCRIPTS}/abundance-dist.py -s qc.counts.kh spades-quality-assembly500.fa  sqc500.dist -s
	python ${SCRIPTS}/abundance-dist.py -s qc.counts.kh megahit-quality-assembly500.fa mqc500.dist -s

### sourmash stuff / Jaccard comparison foo

sigs: SRR606249.sig mircea.fa.sig faecalis.fa.sig nucleatum.fa.sig \
	thermophilus.fa.sig vulgaris.fa.sig xenovorans.fa.sig \
	idba-quality-assembly500.fa.sig \
	megahit-quality-assembly500.fa.sig \
	spades-quality-assembly500.fa.sig

SRR606245.sig:
	sourmash compute --scaled 10000 -k 21,31,41,51 SRR606245.fastq.gz -o SRR606245.sig

SRR606249.sig:
	sourmash compute --scaled 10000 -k 21,31,41,51 SRR606249.[ps]e.qc.fq.gz -o SRR606249.sig

SRR606249-abund.sig:
	cat SRR606249.[ps]e.qc.fq.gz | sourmash compute --scaled 10000 -k 21,31,41,51 - -o SRR606249-abund.sig --track-abundance

mircea.fa.sig:
	sourmash compute --scaled 10000 -k 21,31,41,51 mircea.fa -o mircea.fa.sig

idba-quality-assembly500.fa.sig: #idba-quality-assembly500.fa
	sourmash compute --scaled 10000 -k 21,31,41,51 idba-quality-assembly500.fa -o idba-quality-assembly500.fa.sig

megahit-quality-assembly500.fa.sig: #megahit-quality-assembly500.fa
	sourmash compute --scaled 10000 -k 21,31,41,51 megahit-quality-assembly500.fa -o megahit-quality-assembly500.fa.sig

spades-quality-assembly500.fa.sig: #spades-quality-assembly500.fa
	sourmash compute --scaled 10000 -k 21,31,41,51 spades-quality-assembly500.fa -o spades-quality-assembly500.fa.sig

megahit-assembly-unmapped.fa.sig: mqc-unmapped-reads.fa
	sourmash compute --scaled 10000 -k 21,31,41,51 mqc-unmapped-reads.fa -o mqc-unmapped-reads.fa.sig
