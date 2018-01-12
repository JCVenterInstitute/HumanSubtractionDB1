# HumanSubtractionDB1
A host subtraction database for virus discovery in human cell line sequencing data

## SDB1.fasta.gz

The SDB1 subtraction database designed for three human cell lines: Jurkat, HepG2, HuH7.

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