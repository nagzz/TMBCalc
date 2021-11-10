# TMBCalc
Download conda
Download java version 8
Download annovar
Download the databases cosmic and dbsnp

## Installation

# Docker
Install docker through 
https://docs.docker.com/get-docker/
Pull the pipeline image using the command

```
   docker pull grete/tmbcalc:latest
```

# Withouth Docker

If you do not want to use docker you can install the dependencis of the pipeline yourself.
You need to install java 8 to make some of the software working. 
You have two possibility:
```
sudo apt install -y openjdk-8-jre 
```
OR
```
https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz
tar xzf openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz
```
Moreover, if you do not own root permission install conda and create a new enviroment before use the file "install_dependency.sh"
If you have not install conda:
https://conda.io/projects/conda/en/latest/user-guide/install/index.html

Both if are you using docker or not you should register on annovar and download the software through the following website:

```
https://annovar.openbioinformatics.org/en/latest/user-guide/download/
```

Now you can install the dependencies specifying 
- -p the folder of the project
- -a the annovar folder
- -i the index that you wanna use. Can be hg19 (GRCh37) or hg38 (GRCh38). If you do not know which one to use, hg38 is the recommended one.
- -pr yes if you have the root permission, no if you do not have it. If you select no all the tools will be installed through conda.
- -jv the java pathway or simply java if you have the version 8 installed in your computer.

```
bash install_dependency.sh -p
```

