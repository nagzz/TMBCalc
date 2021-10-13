#Before launching the install dependency install Annovar!
#Va bene perchi ha i sudo sennò cercare i corrispettivi di anaconda e creare una divisione tra sudo e anaconda come paramentro
#Parametro per CrossMap
#Path per dove creare index e programmi
#Creareindex si o no? dipende dall'utente, magari li ha
#!/bin/bash

PROJ_PATH=$path

mkdir $PROJ_PATH/index
mkdir $PROJ_PATH/program

if($perm == "yes") then; #Controlla se ho scritto l'if giusto
sudo apt install -y samtools
sudo apt install -y bowtie2
sudo apt install -y awscli
sudo apt install -y python3-pip
sudo apt install -y unzip
sudo pip3 install CrossMap
else
  conda install
  #installazioni conda - inserire nella guida da dove si installa anaconda
fi

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
