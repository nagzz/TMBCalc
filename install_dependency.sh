wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.11.1/sratoolkit.2.11.1-ubuntu64.tar.gz
tar xzf sratoolkit.2.11.1-ubuntu64.tar.gz

mkdir s34
cd sratoolkit.2.11.1-ubuntu64/bin
#./vdb-config -i
./prefetch --ngc ~/prj_29701.ngc SRR443397   #--max-size 100G
mv ~/SRR/sra/SRR443397_dbGaP-*.sra  ~/SRR/sra/SRR443397.sra
./sam-dump --ngc ~/prj_29701.ngc ~/SRR/sra/SRR443397.sra --output-file ~/s34/SRR443397.sam
cd
aws s3 cp s3://unictbcd/SRR443381/557455_ordered.bam s34/
aws s3 cp s3://unictbcd/SRR443381/557455_ordered.bai s34/
mkdir s34/output
mkdir s34/output/bam_normal
mv s34/557455_ordered.bai s34/output/bam_normal/
mv s34/557455_ordered.bam s34/output/bam_normal/
mv s34/SRR443397.sam s34/557455_tumor.sam
bash pipeline_tum.bash -f file/s34.txt
ls
#sam-dump SRR5799988 | samtools view -bS - > GSM2692389.bam
#sam-dump C:\Users\Desktop\sratoolkit.2.10.8-win64\bin\ncbi\SRA\sra\GSM2692389.sra | samtools view -bS - > GSM2692389.bam
#Install crossmap



cd sratoolkit.2.11.1-ubuntu64/bin
#./vdb-config -i
./prefetch --ngc ~/prj_29701.ngc SRR443397   #--max-size 100G
mv ~/SRR/sra/SRR443397_dbGaP-*.sra  ~/SRR/sra/SRR443397.sra
./sam-dump --ngc ~/prj_29701.ngc ~/SRR/sra/SRR443397.sra --output-file ~/s78/SRR443397.sam
cd
mv s78/SRR443397.sam s78/557467_normal.sam
bash pipeline_nor.bash -f file/s78.txt

wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.11.1/sratoolkit.2.11.1-ubuntu64.tar.gz
tar xzf sratoolkit.2.11.1-ubuntu64.tar.gz
sudo apt install -y samtools
sudo apt install -y bowtie2
sudo apt install -y awscli
# aws s3 cp s3://unictbcd/sra_metadata_e225f7a4-9631-4989-9e73-47f418b1cbca.csv ./
# aws s3 cp s3://unictbcd/sra_metadata_752098e1-5c7d-4443-a1f3-e71df1581892.csv ./


#!/bin/bash
mkdir index
mkdir program

wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.11.1/sratoolkit.2.11.1-ubuntu64.tar.gz
tar xzf sratoolkit.2.11.1-ubuntu64.tar.gz
sudo apt install -y samtools
sudo apt install -y bowtie2
sudo apt install -y awscli
sudo apt install -y python3-pip
sudo apt install -y unzip
sudo pip3 install CrossMap

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
sudo apt install -y openjdk-8-jre
java -jar ~/program/picard.jar CreateSequenceDictionary R=hg19.fa O=hg19.dict
java -jar ~/program/picard.jar CreateSequenceDictionary R=hg38.fa O=hg38.dict
wget http://hgdownload.soe.ucsc.edu/goldenPath/hg19/liftOver/hg19ToHg38.over.chain.gz
cd
cd program
wget http://www.openbioinformatics.org/annovar/download/0wgxR2rIVP/annovar.latest.tar.gz
tar xzf annovar.latest.tar.gz

cd annovar
perl annotate_variation.pl -downdb -webfrom annovar 1000g2015aug humandb -buildver hg38
perl annotate_variation.pl -downdb -webfrom annovar refgene humandb -buildver hg38
perl annotate_variation.pl -downdb -webfrom annovar esp6500siv2_all humandb -buildver hg38
ls
