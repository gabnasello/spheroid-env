# docker-stacks/r-notebook [https://github.com/jupyter/docker-stacks/tree/master/r-notebook]
# https://hub.docker.com/r/jupyter/r-notebook/dockerfile

FROM gnasello/datascience-env:latest

# Install CellProfiler
# https://github.com/CellProfiler/CellProfiler/wiki/Conda-Installation

USER root

RUN apt-get update && \ 
    apt install -yq g++

ADD cellprofiler_environment.yml .
RUN conda env create -f cellprofiler_environment.yml  

ADD cellprofiler_command.sh /
RUN echo "alias cp='bash /cellprofiler_command.sh'" >> ~/.bashrc

USER jovyan