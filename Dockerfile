FROM ubuntu
RUN apt-get update --fix-missing
RUN apt-get -y install wget
RUN apt-get -y install unzip
RUN apt-get -y install bowtie2
RUN apt-get update --fix-missing
RUN apt-get -y install python3-pip
# RUN pip3 install --user --upgrade cutadapt
RUN apt-get -y install cutadapt
RUN apt-get -y install curl
RUN apt-get -y install tar
RUN apt-get -y install samtools
RUN apt-get -y install bedtools
RUN apt-get -y install fastqc
RUN curl -fsSL https://github.com/FelixKrueger/TrimGalore/archive/0.6.6.tar.gz -o trim_galore.tar.gz
RUN tar xvzf trim_galore.tar.gz
RUN apt-get -y install software-properties-common
# Install OpenJDK-8
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y ant && \
    apt-get clean;

# Fix certificate issues
RUN apt-get update && \
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;
# Setup JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME
RUN wget https://github.com/broadinstitute/gatk/releases/download/4.1.0.0/gatk-4.1.0.0.zip
RUN unzip gatk-4.1.0.0.zip
RUN wget https://github.com/broadinstitute/picard/releases/download/2.26.2/picard.jar
RUN apt-get -y install grep
RUN wget https://github.com/dkoboldt/varscan/archive/refs/heads/master.zip
RUN DEBIAN_FRONTEND=noninteractive apt install -y tzdata
RUN apt-get -y install r-base
RUN apt-get -y install pandoc
RUN apt-get -y install libxml2-dev
RUN apt-get -y install libcurl4-openssl-dev
RUN apt-get -y install libssl-dev
RUN R -e "install.packages('dplyr', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('filesstrings', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('data.table', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('RCurl', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('stringr', repos='http://cran.rstudio.com/')"
RUN pip3 install cython
RUN pip3 install CrossMap
RUN pip3 install CrossMap --upgrade
RUN apt-get install rename
RUN apt-get update --fix-missing
RUN mkdir program
RUN unzip master.zip
RUN mv varscan-master/VarScan.v2.4.3.jar program/
RUN mv gatk-4.1.0.0/gatk-package-4.1.0.0-local.jar program/
RUN mv picard.jar program/
RUN mv TrimGalore-0.6.6 program/
RUN mkdir index
RUN apt-get -y install nano
RUN apt-get -y install apt-utils --fix-missing
RUN rm gatk-4.1.0.0.zip
COPY Pipeline.bash /
COPY index_creation.bash /

#Inserire rimozione


ENTRYPOINT [ "bash" ]
