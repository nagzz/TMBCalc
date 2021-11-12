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

#!/bin/bash

PATH_ANNOVAR=$annovar

if [ $index == "hg19" ]; then
  cd index
  wget https://genome-idx.s3.amazonaws.com/bt/hg19.zip
  unzip hg19.zip
  wget http://hgdownload.cse.ucsc.edu/goldenpath/hg19/bigZips/hg19.fa.gz
  gunzip hg19.fa.gz
  samtools faidx hg19.fa
  java -jar /program/picard.jar CreateSequenceDictionary R=hg19.fa O=hg19.dict
  cd ..
  cd $PATH_ANNOVAR/humandb
  wget https://ftp.ncbi.nlm.nih.gov/snp/latest_release/VCF/GCF_000001405.25.gz #o scaricare su annovar o lasciarlo dov'è
  wget https://ftp.ncbi.nlm.nih.gov/snp/latest_release/VCF/GCF_000001405.25.gz.tbi
  gunzip GCF_000001405.25.gz
  mv GCF_000001405.25 GCF_000001405.hg19
  mv GCF_000001405.hg19
  cd ..
else
  cd index
  wget https://genome-idx.s3.amazonaws.com/bt/GRCh38_noalt_as.zip
  unzip GRCh38_noalt_as.zip
  mv GRCh38_noalt_as hg38
  cd hg38
  rename 's/^GRCh38_noalt_as\./hg38./' GRCh38_noalt_as.*
  cd ..
  wget https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz
  gunzip hg38.fa.gz
  samtools faidx hg38.fa
  java -jar /program/picard.jar CreateSequenceDictionary R=hg38.fa O=hg38.dict
  rm GRCh38_noalt_as.zip
  cd ..
  cd $PATH_ANNOVAR/humandb
  wget https://ftp.ncbi.nlm.nih.gov/snp/latest_release/VCF/GCF_000001405.39.gz
  wget https://ftp.ncbi.nlm.nih.gov/snp/latest_release/VCF/GCF_000001405.39.gz.tbi
  gunzip GCF_000001405.39.gz
  mv GCF_000001405.39 GCF_000001405.hg38
  mv GCF_000001405.hg38 $PATH_ANNOVAR/humandb
  cd ..
fi

cd $PATH_ANNOVAR
perl annotate_variation.pl -downdb -webfrom annovar 1000g2015aug humandb -buildver $index
perl annotate_variation.pl -downdb -webfrom annovar refgene humandb -buildver $index
perl annotate_variation.pl -downdb -webfrom annovar esp6500siv2_all humandb -buildver $index
perl annotate_variation.pl -downdb -webfrom annovar cosmic70 humandb -buildver $index
