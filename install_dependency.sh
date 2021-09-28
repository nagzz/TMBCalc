sudo apt install samtools
sudo apt install bowtie2
sudo apt install awscli
aws s3 cp s3://unictbcd/sra_metadata_e225f7a4-9631-4989-9e73-47f418b1cbca.csv ./
aws s3 cp s3://unictbcd/sra_metadata_752098e1-5c7d-4443-a1f3-e71df1581892.csv ./


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
samtools faidx hg38.fa
wget https://storage.googleapis.com/gcp-public-data--broad-references/hg19/v0/Homo_sapiens_assembly19.fasta
mv Homo_sapiens_assembly19.fasta hg19.fa
samtools faidx hg19.fa
java -jar ~/program/picard.jar CreateSequenceDictionary R=hg19.fa O=hg19.dict
wget http://hgdownload.soe.ucsc.edu/goldenPath/hg19/liftOver/hg19ToHg38.over.chain.gz

cd
wget http://www.openbioinformatics.org/annovar/download/0wgxR2rIVP/annovar.latest.tar.gz
tar xzf annovar.latest.tar.gz

cd program/annovar
perl annotate_variation.pl -downdb -webfrom annovar 1000g2015aug humandb -buildver hg38
perl annotate_variation.pl -downdb -webfrom annovar refgene humandb -buildver hg38
perl annotate_variation.pl -downdb -webfrom annovar esp6500siv2_all humandb -buildver hg38
