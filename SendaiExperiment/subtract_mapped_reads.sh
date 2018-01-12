#!/bin/sh

if [ $# != 5 ]; then echo "Usage: $0 <scripthome> <R1> <R2> <BAM> <out>"; exit 1; fi
DIR=$1
IN_R1=$2
IN_R2=$3
IN_BAM=$4
OUT_PREFIX=$5
OUT_R1=${OUT_PREFIX}.${IN_R1}
OUT_R2=${OUT_PREFIX}.${IN_R2}

HERE=`pwd`
echo "CURRENT DIRECTORY ${HERE}"
echo "THIS SCRIPT $0"
if [ "${DIR}" == "." ]; then
    echo "ERROR SCRIPT MUST BE INVOKED WITH ABSOLUTE PATH"
    exit 2
fi
echo "LOCATION FOR SCRIPTS ${DIR}"
SAMTOOLS=/usr/local/bin/samtools
FILTER=fastq-filter-by-name.pl
echo SAMTOOLS $SAMTOOLS
echo FILTER $FILTER

echo "GET READS FROM ${IN_R1} AND ${IN_R2}"
echo "GET MAPS FROM ${IN_BAM}"
echo "WRITE READS TO ${OUT_R1} AND ${OUT_R2}"

# This filter requires mapQ>=5 on both reads.
# For a bowtie2 mapping, hardly any reads pass.
# This assumes sorted inputs only writes the second.
#    awk '{if ($5>=5) {if ($1==p) print $1; p=$1;}}' \

# This filter requires the "each properly aligned" flag.
# In bowtie2 output, this matches intutiion.
# It requires both reads map to same transcript.
# It allows very few mismatches or indels.
# If pairs share an ID, this will write the ID twice
# (put the perl script will uniqify it by using a hash).
#    awk 'BEGIN {mask=02;} {if (and($2,mask)>0) print $1;}}' \

# For subtraction, we found that any filter is too restrictive.

echo "SAMTOOLS TO EXTRACT MAPPED READ IDs..."
TMP_IDS_FILE="tmp.${IN_BAM}.ids"
echo BAM1   # start a new file with R1 IDs
${SAMTOOLS} view ${IN_BAM} | cut -f 1 >  ${TMP_IDS_FILE}
echo -n $?; echo " exit status"

# This script assumes R1 and R2 of a pair have the same ID.
# If either R1 or R2 mapped, then the ID is saved, and both reads will get subtracted.
# For read pairs with distinct names like 1234/1 and 1234/2,
# user must strip the suffixes from the deflines.

EXCLUDE="-v"  # option to exclude the named reads
echo MAKE ${OUT_R1}
gunzip -c ${IN_R1} | ${DIR}/${FILTER} ${EXCLUDE} ${TMP_IDS_FILE} > ${OUT_R1}
echo -n $?; echo " exit status"
echo MAKE ${OUT_R2}
gunzip -c ${IN_R2} | ${DIR}/${FILTER} ${EXCLUDE} ${TMP_IDS_FILE} > ${OUT_R2}
echo -n $?; echo " exit status"
echo DONE
