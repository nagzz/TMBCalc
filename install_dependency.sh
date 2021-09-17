
wget https://github.com/broadinstitute/picard/releases/download/2.26.2/picard.jar
wget https://github.com/broadinstitute/gatk/releases/download/4.1.0.0/gatk-4.1.0.0.zip
unzip gatk-4.1.0.0.zip
mv gatk-4.1.0.0/gatk-package-4.1.0.0-local.jar ./
wget https://github.com/dkoboldt/varscan/blob/master/VarScan.v2.4.3.jar

cd annovar
perl annotate_variation.pl -downdb -webfrom annovar 1000g2015aug humandb -buildver hg38
perl annotate_variation.pl -downdb -webfrom annovar refgene humandb -buildver hg38

wget http://hgdownload.soe.ucsc.edu/goldenPath/hg19/liftOver/hg19ToHg38.over.chain.gz
