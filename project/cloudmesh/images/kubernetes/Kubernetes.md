## Kubernetes

Kubernetes is an open-source system that automates the scaling, management and deployment of containerized applications. 
It groups the containers into logical units so that it can manage the containers easily.

## What is Docker?

Docker is a service that uses operating system level virtualization in order to deliver software in the form of containers. Docker 
containers can run on any Linux server. This feature provides flexibility. Docker containers can run on both public and private clouds. 
They can also run on-premises. This feature provides portability. Docker is composed of three main components namely

* Software :
Docker has a software called **Docker Daemon** that manages Docker containers and the container objects.

* Objects :
Docker objects are the different kinds of entities that are used to assemble an application in Docker. The different classes under which 
Docker objects are categorized are images, containers, and services.

* Registries :
A Docker registry is a repository that stores Docker images. Docker clients usually connect to these repositories in order to **pull** 
images for their own use or in order to **push** images that they have built to the repository. Registries can be public or private.

## What is a Container?

A container is a stand-alone, executable package of a piece of software. A container contains all the code that an application 
requires to run smoothly. Containers ensure that everything that needs to be executed, is executed efficiently from one 
computing environment to another. Containers are usually isolated from one another and each container contains its own software. 
Containers can communicate with each other using channels. All containers are run by a single operating-system kernel. Due to this, 
they are more lightweight than virtual machines. This lightweight property of containers allows a single server or a virtual machine 
to simultaneously run several containers.

## What is a Dockerfile?

Dockerfile is a set of instructions that, when executed, assembles an image. By using the **docker build** command, users can 
execute these instructions in succession in order to build a docker image. The build is run by the Docker daemon and not by the 
command line interface. A user can tag their image and give it a specific name by using the **-t** option along with docker 
build. By using the **docker run** command, users can create a container specifically for using the docker image just built.

An example of a Dockerfile is :

```
FROM debian:jessie-slim
FROM debian:sid

ENV DEBIAN_FRONTEND = noninteractive

#RUN dpkg-reconfigure debconf

FROM ubuntu

RUN apt-get update 
	
RUN apt-get install --fix-missing -y software-properties-common 

RUN add-apt-repository ppa:openjdk-r/ppa 
	
RUN apt-get update 

RUN apt-get install --fix-missing -y -f openjdk-8-jre

# Stable hadoop install
ENV HADOOP_VERSION 3.2.1
#ENV HADOOP_VERSION 2.7.5

ENV HADOOP_URL https://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
# for old versions ENV HADOOP_URL https://archive.apache.org/dist/hadoop/core/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz

RUN set -x 

RUN apt-get update 

RUN apt-get install curl -y

RUN curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz 

RUN curl -fSL "$HADOOP_URL.asc" -o /tmp/hadoop.tar.gz.asc 

RUN apt-get install -y wget

RUN wget -O /tmp/KEYS https://dist.apache.org/repos/dist/release/hadoop/common/KEYS

RUN gpg --import /tmp/KEYS

RUN gpg --verify /tmp/hadoop.tar.gz.asc 

RUN tar -xvf /tmp/hadoop.tar.gz -C /opt/ 

RUN rm /tmp/hadoop.tar.gz*

RUN ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop

COPY ./config /etc/hadoop/.

RUN mkdir /opt/hadoop-$HADOOP_VERSION/logs

RUN mkdir /hadoop-data

ENV HADOOP_PREFIX=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV MULTIHOMED_NETWORK=1
ENV USER=root
ENV PATH $HADOOP_PREFIX/bin/:$PATH

WORKDIR /root
COPY entrypoint.sh ./entrypoint.sh
RUN chmod a+x ./entrypoint.sh

RUN apt-get install dos2unix

RUN dos2unix ./entrypoint.sh && apt-get --purge remove -y dos2unix && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["./entrypoint.sh"] 
```

## References

https://docs.docker.com/engine/reference/builder/
https://en.wikipedia.org/wiki/Docker_(software)
https://docs.docker.com/v17.12/engine/reference/commandline/docker/


