#!/bin/sh

SCRIPT=./subtract_mapped_reads.sh
DIR=.

BAMFILE[1]=sdb.HEP.NONE.MOCK.bam
BAMFILE[2]=sdb.HEP.NONE.SEND.bam
BAMFILE[3]=sdb.HEP.RIBO.MOCK.bam
BAMFILE[4]=sdb.HEP.RIBO.SEND.bam

BAMFILE[5]=sdb.HUH.NONE.MOCK.bam
BAMFILE[6]=sdb.HUH.NONE.SEND.bam
BAMFILE[7]=sdb.HUH.RIBO.MOCK.bam
BAMFILE[8]=sdb.HUH.RIBO.SEND.bam

BAMFILE[9]=sdb.JUR.NONE.MOCK.bam
BAMFILE[10]=sdb.JUR.NONE.SEND.bam
BAMFILE[11]=sdb.JUR.RIBO.MOCK.bam
BAMFILE[12]=sdb.JUR.RIBO.SEND.bam

R1FILE[1]=trim.pair.cutadapt.1HEPG2_S1_R1_001.fastq.gz
R1FILE[2]=trim.pair.cutadapt.2HEPG2SEV_S2_R1_001.fastq.gz
R1FILE[3]=trim.pair.cutadapt.1HEPG2RIBO_S7_R1_001.fastq.gz
R1FILE[4]=trim.pair.cutadapt.2HEPG2SEVRIBO_S8_R1_001.fastq.gz

R1FILE[5]=trim.pair.cutadapt.3HUH7_S3_R1_001.fastq.gz
R1FILE[6]=trim.pair.cutadapt.4HUH7SEV_S4_R1_001.fastq.gz
R1FILE[7]=trim.pair.cutadapt.3HUH7RIBO_S9_R1_001.fastq.gz
R1FILE[8]=trim.pair.cutadapt.4HUH7SEVRIBO_S10_R1_001.fastq.gz

R1FILE[9]=trim.pair.cutadapt.5JURKAT_S5_R1_001.fastq.gz
R1FILE[10]=trim.pair.cutadapt.6JURKATSEV_S6_R1_001.fastq.gz
R1FILE[11]=trim.pair.cutadapt.5JURKATRIBO_S11_R1_001.fastq.gz
R1FILE[12]=trim.pair.cutadapt.6JURKATCELLSSEVRIBOR_S12_R1_001.fastq.gz

FF=$SGE_TASK_ID

MYBAM=${BAMFILE[${FF}]}
MYR1=${R1FILE[${FF}]}
MYR2=` echo ${MYR1} | sed 's/_R1_/_R2_/'  `

CMD="./subtract_mapped_reads.sh ${DIR} ${MYR1} ${MYR2} ${MYBAM} nonsdb "
echo ${CMD}
${CMD}
