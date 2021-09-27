#!/bin/bash
mkdir index
mkdir program

cd program
wget https://github.com/broadinstitute/picard/releases/download/2.26.2/picard.jar
wget https://github.com/broadinstitute/gatk/releases/download/4.1.0.0/gatk-4.1.0.0.zip
unzip gatk-4.1.0.0.zip
mv gatk-4.1.0.0/gatk-package-4.1.0.0-local.jar ./
wget https://github.com/dkoboldt/varscan/archive/refs/heads/master.zip
unzip master.zip
cd
cd index
wget https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz
gunzip hg38.fa.gz
wget https://console.cloud.google.com/storage/browser/_details/gcp-public-data--broad-references/hg19/v0/Homo_sapiens_assembly19.fasta
mv Homo_sapiens_assembly19.fasta hg19.fa
samtools faidx hg19.fa
java -jar picard.jar CreateSequenceDictionary R=hg19.fa O=hg19.dict
wget http://hgdownload.soe.ucsc.edu/goldenPath/hg19/liftOver/hg19ToHg38.over.chain.gz

cd
wget http://www.openbioinformatics.org/annovar/download/0wgxR2rIVP/annovar.latest.tar.gz

cd annovar
perl annotate_variation.pl -downdb -webfrom annovar 1000g2015aug humandb -buildver hg38
perl annotate_variation.pl -downdb -webfrom annovar refgene humandb -buildver hg38
