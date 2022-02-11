# docker-stacks/r-notebook [https://github.com/jupyter/docker-stacks/tree/master/r-notebook]
# https://hub.docker.com/r/jupyter/r-notebook/dockerfile

FROM gnasello/datascience-env:latest

USER root

# Install CellProfiler
# https://github.com/CellProfiler/CellProfiler/wiki/Conda-Installation

RUN apt-get update && \ 
    apt install -yq g++

ADD cellprofiler_environment.yml .
RUN conda env create -f cellprofiler_environment.yml  

ADD cellprofiler_command.sh /
RUN echo "alias cp='bash /cellprofiler_command.sh'" >> ~/.bashrc

# Download Ilastik software 
# https://www.ilastik.org/documentation/basics/installation.html

RUN apt-get update && \ 
    apt-get install -y libgl1-mesa-dev

WORKDIR "/ilastik"
RUN wget https://files.ilastik.org/ilastik-1.3.3post3-Linux.tar.bz2 && \
    tar xjf ilastik-1.*-Linux.tar.bz2 && \
    echo "alias il='bash /ilastik/ilastik-1.*-Linux/run_ilastik.sh'" >> ~/.bashrc