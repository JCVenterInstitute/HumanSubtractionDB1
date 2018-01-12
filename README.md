# HumanSubtractionDB1
A host subtraction database for virus discovery in human cell line sequencing data

## SDB1.fasta.gz

The SDB1 subtraction database designed for three human cell lines: Jurkat, HepG2, HuH7.
Use GNU gunzip to extract the FASTA file.

## Scripts

Scripts for the analysis of data from an experiment on human cell lines infected with Sendai virus.

* fastq-filter-by-name.pl - Reads FASTQ and list of names. Writes smaller FASTQ missing named reads. 
* SendaiExperiment/run_trimmomatic.sh - Trimmed the reads.
* SendaiExperiment/run_bowtie_align_to_sdb.sh - Mapped the reads to SDB.
* SendaiExperiment/subtract_mapped_reads.sh - Create FASTQ of the unmapped reads. Invokes fastq-filter-by-name.pl
* SendaiExperiment/generate_unmapped_reads.sh - Invoke subtract_mapped_reads on each set of reads.

## Demo

A small demonstration of the subtraction pipeline.

* subtraction.HUH7.contigs.fasta - A sample database of host sequences.
* Demo_R1_reads.HuH7.SeV.RiboDepleted.fastq - A sample of R1 reads containing host + virus.
* Demo_R2_reads.HuH7.SeV.RiboDepleted.fastq - A	sample of R2 reads containing host + virus.
* run_Demo_subtraction.sh - A script that extracts non-host heads. 

The script requires a parameter: the path to the scripts directory.
The script uses other scripts: run_trimmomatic.sh, fastq-filter-by-name.pl.
The script assumes installed software: bowtie2-build, bowtie2, samtools, trimmomatic (and its adapter file).
The script indexes the database, maps the reads, lists the mapped read names, creates fastq of unmapped reads.