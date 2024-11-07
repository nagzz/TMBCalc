#!/bin/bash

usage() {
  echo "Usage: $0 [-a/-annovar path of annovar]
  [-i/-index choose between hg19 or hg38]" 1>&2
}

exit_abnormal_code() {
  echo "$1" 1>&2
  exit $2
}

exit_abnormal_usage() {
  echo "$1" 1>&2
  usage
  exit 1
}

exit_abnormal() {
  usage
  exit 1
}

while [ -n "$1" ]; do
  case "$1" in
  -annovar | -a)
    annovar="$2"
    echo "The value provided for annovar path is $annovar"
    shift
    ;;
  -index | -i)
    index="$2"
    echo "The value provided for index is $index"
    if ! { [ "$index" = "hg19" ] || [ "$index" = "hg38" ]; }; then
      exit_abnormal_usage "Error: index value must be equal to hg19 or hg38."
    fi
    shift
    ;;
  *)
    exit_abnormal_usage "Error: invalid parameter \"$1\"."
    shift
    ;;
  esac
  shift
done

PATH_ANNOVAR=$annovar

if [ $index == "hg19" ]; then
  cd index
  wget https://genome-idx.s3.amazonaws.com/bt/hg19.zip
  unzip hg19.zip
  mkdir hg19
  mv hg19.* hg19/
  wget http://hgdownload.cse.ucsc.edu/goldenpath/hg19/bigZips/hg19.fa.gz
  gunzip hg19.fa.gz
  samtools faidx hg19.fa
  java -jar /program/picard.jar CreateSequenceDictionary R=hg19.fa O=hg19.dict
  cd ..
  cd $PATH_ANNOVAR/humandb
  wget https://ftp.ncbi.nlm.nih.gov/snp/organisms/human_9606_b151_GRCh37p13/VCF/00-All.vcf.gz
  wget https://ftp.ncbi.nlm.nih.gov/snp/organisms/human_9606_b151_GRCh37p13/VCF/00-All.vcf.gz.tbi
  gunzip 00-All.vcf.gz
  mv 00-All.vcf snp151_hg19.vcf
  mv 00-All.vcf.gz.tbi snp151_hg19.vcf.gz.tbi
  cd ..
else
  cd index
  wget https://genome-idx.s3.amazonaws.com/bt/GRCh38_noalt_as.zip
  unzip GRCh38_noalt_as.zip
  mv GRCh38_noalt_as hg38
  cd hg38
  rename 's/^GRCh38_noalt_as\./hg38./' GRCh38_noalt_as.*
  cd ..
  wget https://www.encodeproject.org/files/GRCh38_no_alt_analysis_set_GCA_000001405.15/@@download/GRCh38_no_alt_analysis_set_GCA_000001405.15.fasta.gz
  gunzip GRCh38_no_alt_analysis_set_GCA_000001405.15.fasta.gz
  mv GRCh38_no_alt_analysis_set_GCA_000001405.15.fasta hg38.fa
  samtools faidx hg38.fa
  java -jar /program/picard.jar CreateSequenceDictionary R=hg38.fa O=hg38.dict
  rm GRCh38_noalt_as.zip
  cd ..
  cd $PATH_ANNOVAR/humandb
  wget https://ftp.ncbi.nlm.nih.gov/snp/organisms/human_9606_b151_GRCh38p7/VCF/00-All.vcf.gz
  wget https://ftp.ncbi.nlm.nih.gov/snp/organisms/human_9606_b151_GRCh38p7/VCF/00-All.vcf.gz.tbi
  gunzip 00-All.vcf.gz
  mv 00-All.vcf snp151_hg38.vcf
  mv 00-All.vcf.gz.tbi snp151_hg38.vcf.gz.tbi
  cd ..
fi

cd $PATH_ANNOVAR
perl annotate_variation.pl -downdb -webfrom annovar 1000g2015aug humandb -buildver $index
perl annotate_variation.pl -downdb -webfrom annovar refgene humandb -buildver $index
perl annotate_variation.pl -downdb -webfrom annovar esp6500siv2_all humandb -buildver $index
perl annotate_variation.pl -downdb -webfrom annovar cosmic70 humandb -buildver $index
