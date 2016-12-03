# Brief Explanation for Output Files

## Analysis output 

- assemblies.stats.QC.AMBIGUOUS.99: Contains the analysis using Ambiguous approach and 99% identity and 500 minimum contig cutoff 
- assemblies.stats.QC.BESTHIT5.99:  Contains the analysis using Best hit approach and 99% identity and 500 minimum contig cutoff (the 5 after besthit should be removed; in PR#2)
- assemblies.stats.QC.NOOVERLAP.99: Contains the analysis using No Misassemblies approach and 99% identity and 500 minimum contig cutoff

- All files dot **aligned**: Contains a list of fully aligned contigs. The last line has the total no. of bases in these aligned contigs. 
- All files dot **aligned.partial**: Contains a list of the partial aligned contigs; the length of the contig, the length of the alignment, and the length of the unaligned. 
- All files dot **unaligned**: Contains unaligned contigs. The last line has the total no. of bases in these unaligned contigs. 

- All files dot **count.covered**: Contains the counts of uniquely covered bases of the corresponding assembler. It contians the genome name, number of uniquely covered bases, and the total length of the genome. 

- All files dot **count.uncovered**: Contains the counts of uniquely uncovered bases of the corresponding assembler. It contians the genome name, number of uniquely covered bases, and the total length of the genome.     

- QC.AMBIGUOUS.99.uncovered.bases : Contains the bases indeces of the common uncovered bases using identity 99%. This will be the input to **common-uncovered-coverage.py** 

- assemblies.stats.QC.AMBIGUOUSMINCONTIG.IDENTITY: Contains the analysis using Ambiguous approach and IDENTITY % and MINCONTIG cutoff 

 
## Coverage profiles 

- common-uncovered-coverage.out : Contains the coverage profile of common uncovered bases 

- ecoli.qc.coverage: Contains coverage profile of quality filtered reads 


##  Mapping analysis 

- All files dot **aligned.reads** : Count of reads aligned to unaligned contigs 

- All files dot **mappedreads.fa** : Reads that mapped to unaligned contigs of the corresponding assembler. 

- All file dash **mapped-reads**: Count of reads that mapped to unaligned contigs and to the reference. 

- All files dot **unmappedreads.fa** : Reads mapped to the unaligned contigs but do not map to the reference.

- All files dot **unmapped.out**: Coverage of reads mapped to unaligned contigs but not to the reference in the unaligned contigs. 


## Prokka analysis 

- prokka.out: prokka coordinates of genes 

- prokka-analysis.out : Count of genes found in the assembly and the reference 


## N50/NG0 analysis 

- All files dot **stats** : contains N50/NG50 metrics of the corresponding assembler 


## Kmer abundance and De Bruijn graph connectivity 

- ecoli.qc.dist: kmer abundance in reference 

- qc.dist : kmer abundance in quality filtered reads 

- qc500.dist: kmer abundance in all assemblies 

- iqc500.dist, sqc500.dist, mqc500.dist: kmer abundance in IDBAUD, SPAdes, Megahit assemblies espectively 


## Time and Memory cost 

- iqc.txt, sqc,txt, megqc.txt shows the time and memory cost for IDBAUD, SPAdes, and Megahit respectively 

 
