#!/bin/bash


usage() {
  echo "Usage: $0 [-fq1/-fastq1]
  [-fq1/-fastq2]
  [-nm1/-normal1]
  [-nm2/-normal2]" 1>&2
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
  -fastq1 | -fq1)
    fastq1="$2"
    echo "The value provided for annovar path is $fastq1"
    shift
    ;;
  -fastq1 | -fq2)
    fastq2="$2"
    echo "The value provided for annovar path is $fastq2"
    shift
    ;;
  -normal1 | -nm1)
    normal1="$2"
    echo "The value provided for annovar path is $normal1"
    shift
    ;;
  -normal2 | -nm2)
    normal2="$2"
    echo "The value provided for annovar path is $normal2"
    shift
    ;;
  *)
    exit_abnormal_usage "Error: invalid parameter \"$1\"."
    shift
    ;;
  esac
  shift
done

gunzip $fastq1
gunzip $fastq2
gunzip $normal1
gunzip $normal2
