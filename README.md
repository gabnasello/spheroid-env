# Create a Docker Image for basic data science

## How it works

- The ```Dockerfile``` creates a Docker Image based on  [gabnasello/datascience-en](https://hub.docker.com/repository/docker/gnasello/datascience-env).
- It adds CellProfiler virtual environment via [conda](https://github.com/CellProfiler/CellProfiler/wiki/Conda-Installation)

## Create a new image

First, clone the repo:

```git clone https://github.com/gabnasello/spheroid-env.git``` 

and run the following command to build the image (you might need sudo privileges):

```docker build --no-cache -t spheroid-env:latest .```

Then you can follow the instructions in the [Docker repository](https://hub.docker.com/repository/docker/gnasello/spheroid-env) to use the virtual environment.

Enjoy data science!