# docker-stacks/r-notebook [https://github.com/jupyter/docker-stacks/tree/master/r-notebook]
# https://hub.docker.com/r/jupyter/r-notebook/dockerfile

FROM gnasello/datascience-env:latest

USER root

# Install CellProfiler
# https://github.com/CellProfiler/CellProfiler/wiki/Conda-Installation

RUN apt-get update && \ 
    apt install -yq g++

ADD cellprofiler_environment.yml .
RUN conda env create -f cellprofiler_environment.yml  && \ 
    rm cellprofiler_environment.yml

# add conda environment to jupyter lab
# [https://stackoverflow.com/questions/53004311/how-to-add-conda-environment-to-jupyter-lab]
RUN /opt/conda/envs/cprofiler/bin/ipython kernel install --user --name=cprofiler


# Download Ilastik software 
# https://www.ilastik.org/documentation/basics/installation.html

RUN apt-get update && \ 
    apt-get install -y libgl1-mesa-dev

WORKDIR "/ilastik"
RUN wget https://files.ilastik.org/ilastik-1.3.3post3-Linux.tar.bz2 && \
    tar xjf ilastik-1.*-Linux.tar.bz2 && \
    echo "alias il='bash /ilastik/ilastik-1.*-Linux/run_ilastik.sh'" >> ~/.bashrc


# Install Fiji.

# From OpenJDK Java 7 JRE Dockerfile
# http://dockerfile.github.io/#/java
# https://github.com/dockerfile/java
# https://github.com/dockerfile/java/tree/master/openjdk-7-jre
RUN \
  apt-get update && \
  apt-get install -y openjdk-11-jdk && \
  rm -rf /var/lib/apt/lists/*
# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64

# Regular instructions for installing imagej [https://www.scivision.dev/install-imagej-linux/]
WORKDIR /imagej
RUN wget https://downloads.imagej.net/fiji/latest/fiji-linux64.zip && \
    unzip fiji*.zip -d . && \
    rm fiji*.zip && \
    echo "alias imagej='/imagej/Fiji.app/ImageJ-linux64'" >> ~/.bashrc && \
    echo "alias fiji='/imagej/Fiji.app/ImageJ-linux64'" >> ~/.bashrc
# Install DeepCell-imagej-plugin
# [https://github.com/vanvalenlab/kiosk-imageJ-plugin]
RUN wget https://github.com/vanvalenlab/kiosk-imageJ-plugin/releases/download/0.3.2/Kiosk_ImageJ-0.3.2.jar && \
    mv Kiosk*.jar Fiji.app/plugins/
# Install Ilastik-imagej-plugin
RUN wget https://sites.imagej.net/Ilastik/plugins/ilastik4ij-1.8.2.jar-20210407103536 && \
    unzip ilastik* && \
    jar cf ilastik4ij-1.8.2.jar META-INF/* org/* && \
    mv ilastik4ij-1.8.2.jar Fiji.app/plugins/ && \
    rm -r META-INF/ org/ ilastik* 