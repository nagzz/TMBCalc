# TMBCalc

The TMBCalc pipeline has been implemented in Bash and R. It allows the calculation of the TMB, yielding as output: (i) all the mutations implicated in the TMB calculation; (ii) the TMB value itself. 
The pipeline consists of four modules plus TMB calculation:
- Alignment
- Bam Processing
- Variant Calling
- Annotation 
- TMB Calculation

# Installation

## Depencencies

Both if are going to use docker or not you should register on annovar and download the software through the following website:

```
https://annovar.openbioinformatics.org/en/latest/user-guide/download/
```

## With Docker
Install docker through 
https://docs.docker.com/get-docker/

Pull the pipeline image using the command

```
   docker pull grete/tmbcalc:latest
```

Run the container inserting in it: your project path, your input file folder path (if it is not already included in the project path) and your annovar path.
Example:
```
docker run -v /home/ubuntu/Annovar:/annovar -v /home/ubuntu/project_path:/project_path
```
At this point you should create the index using the script "index_creation.bash" adding the parameters:
- -a with the annovar path 
- -i with the index choose. You can choose among hg19 and hg38.

```
bash index_creation.bash -a /annovar/ -i hg38
```

## Withouth Docker

If you do not want to use docker you can install the dependencis of the pipeline yourself.
You need to install java 8 to make some of the software working. 
You have two possibility:
```
sudo apt install -y openjdk-8-jre 
```
OR
```
https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz
tar xzf dk.tar.gz
```
Moreover, if you do not own root permission install conda and create a new enviroment before use the file "install_dependency.sh"
Conda can be installed from:
https://conda.io/projects/conda/en/latest/user-guide/install/index.html

Now you can install the dependencies specifying 
- -p the folder of the project
- -a the annovar folder
- -i the index that you wanna use. Can be hg19 (GRCh37) or hg38 (GRCh38). If you do not know which one to use, hg38 is the recommended one.
- -pr yes if you have the root permission, no if you do not have it. If you select no all the tools will be installed through conda.
- -jv the java pathway or simply the word "java" if you have the version 8 installed in your computer.

Here an example:

```
bash install_dependency.sh -p /home/ubuntu/project_path -a /home/ubuntu/Annovar -i hg38 -pr yes -jv /home/ubuntu/jdkfolder/bin/java
```

This step can take a while since index should be downloaded. It will also create the folders index and program in your project path.

### Pipeline usage

The pipeline needs several parameters:
- -t the tumor sample name withouth the extension and the number in case of paired end
- -n the normal sample name withouth the extension and the number in case of paired end
- -tp sample type, you can choose between fastq or bam
- -pr yes if you have paired-end samples, no if samples are single-end
- -i the input files folder
- -id the human index choosen. It can be hg19 or hg38.
- -ifl the path of the folder where the index have been downloaded
- -p the path of the folder where the program have been downloaded
- -j open jdk or java path
- -th threads number, put 1 if you are not sure.
- -e exome length in Megabase

```
bash Pipeline.bash -t tumor_sample_name -n normal_sample_name -tp bam -i /home/ubuntu/input -pr no -id hg38 -ifl /index/ -p /program/ -j /usr/lib/jvm/java-8-openjdk-amd64/bin/java -th 1 -e 30
```

# Output

You will find several outputs in the folder "txt" placed in your path project folder.
First of all, the TMB value txt file where you will find the value calculated with the exome size supplied.
Secondly, you will find a txt called with your tumor name plus ".variant_function" with all the mutations that contribute to the TMB calculation with their specific function. 

