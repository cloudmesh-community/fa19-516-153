
#
# Ubuntu Dockerfile
#
# https://github.com/cloudmesh/dockerfile/ubuntu
#

# Pull base image.
FROM ubuntu:16.04

# Label
LABEL version="1.5"
LABEL maintainer="laszewski@gmail.com"
LABEL description="ubuntu 16.04 image for the class" 

RUN apt-get -y update
RUN apt-get -y install software-properties-common python-software-properties
RUN add-apt-repository ppa:git-core/ppa
RUN apt-get -y install git

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN add-apt-repository 'deb [arch=amd64,i386] https://cran.rstudio.com/bin/linux/ubuntu xenial/'

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim emacs wget && \
  apt-get install -y python python-dev python-pip python-virtualenv && \
  apt-get install -y libffi-dev libssl-dev libxml2-dev libxslt1-dev libjpeg8-dev zlib1g-dev && \
  apt-get install -y xauth && \
  rm -rf /var/lib/apt/lists/*


# cloudmesh
RUN apt-get install python-gdbm
RUN pip install cloudmesh.common
RUN pip install cloudmesh.cmd5
RUN pip install cloudmesh.sys

# Ansible.
RUN pip install --upgrade pip
RUN pip install ansible

# R.

RUN apt-get -y install r-base
#RUN pip install rpy2
#RUN apt-get -y install libcurl4-openssl-dev
# setup R configs.
#RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile
#RUN Rscript -e "install.packages('ggplot2')"

# Add files.
# ADD root/.bashrc /root/.bashrc
# ADD root/.gitconfig /root/.gitconfig
# ADD root/.scripts /root/.scripts

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]