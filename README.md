# TMBCalc

## Installation

# Depencencies

Both if are going to use docker or not you should register on annovar and download the software through the following website:

```
https://annovar.openbioinformatics.org/en/latest/user-guide/download/
```

# Docker
Install docker through 
https://docs.docker.com/get-docker/
Pull the pipeline image using the command

```
   docker pull grete/tmbcalc:latest
```

Run the container inserting in it your project path, your input file folder path if it is not included in the project path and your annovar path.
Example:
```
docker run -v /home/ubuntu/Annovar:/annovar -v /home/ubuntu/project_path:/project_path
```
At this point you should create the index using the script "index_creation.bash" adding the parameters:
- -a with the annovar path 
- -i with the index choose. You can choose among hg19 and hg38.

```
bash index_creation.bash -a annovar -i hg38
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
tar xzf dk.tar.gz
```
Moreover, if you do not own root permission install conda and create a new enviroment before use the file "install_dependency.sh"
If you have not install conda:
https://conda.io/projects/conda/en/latest/user-guide/install/index.html

Now you can install the dependencies specifying 
- -p the folder of the project
- -a the annovar folder
- -i the index that you wanna use. Can be hg19 (GRCh37) or hg38 (GRCh38). If you do not know which one to use, hg38 is the recommended one.
- -pr yes if you have the root permission, no if you do not have it. If you select no all the tools will be installed through conda.
- -jv the java pathway or simply java if you have the version 8 installed in your computer.

Here an example:

```
bash install_dependency.sh -p /home/ubuntu/project_path -a /home/ubuntu/Annovar -i hg38 -pr yes -jv /home/ubuntu/jdkfolder/bin/java
```

This step can take a while since index should be downloaded. 
In the Project path will be created two folder: index and program.



