## Kubernetes

Kubernetes is an open-source system that automates the scaling, management and deployment of containerized applications based on the CPU, 
memory or some custom metrics. It groups the containers into logical units so that it can manage the containers easily. The Kubernetes API
provides a feature of extensibility to the containers that run on Kubernetes. This extensibility allows the user to work with Kubernetes
on different workloads. Kubernetes works with a wide range of container tools. One such tool is Docker.

Kubernetes manages resources in the form of Objects. The key objects of Kubernetes are :

* Pods : <br/>
A pod is the basic scheduling unit in Kubernetes. It consistes of one or more containers that can share resources and are co-located on the 
host machine. Each pod has a unique IP address. Due to this IP address, applications are able to use ports without the risk of any conflict.
This IP address is the means of communication between containers located in different pods. Containers in the same pod are able to communicate
with each other on the localhost.

* Replica Sets : <br/>
Replica Sets are a mechanism that helps Kubernetes identify all the pods that are required to execute an application successfully. It maintains 
the number of instances that have been declared for a given pod to use.

* Services : <br/>
A Kubernetes service is a collection of pods working together in order to run an application. A label selector defines the collection of pods 
that consitute a service. Kubernetes can discover services either by using environmental variables or by using Kubernetes DNS. When Kubernetes
discovers a service, an IP address and a DNS name is assigned to the service. A service is exposed inside a cluster by default. In order to enable 
the clients to use the pods, a service can also be exposed outside a cluster if need be.

## What is Docker?

Docker is a service that uses operating system level virtualization in order to deliver software in the form of containers. Docker 
containers can run on any Linux server. This feature provides flexibility. Docker containers can run on both public and private clouds. 
They can also run on-premises. This feature provides portability. Docker is composed of three main components namely

* Software : <br/>
Docker has a software called **Docker Daemon** that manages Docker containers and the container objects.

* Objects : <br/>
Docker objects are the different kinds of entities that are used to assemble an application in Docker. The different classes under which 
Docker objects are categorized are images, containers, and services.

* Registries : <br/>
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

https://blog.kumina.nl/2018/04/the-benefits-and-business-value-of-kubernetes/ <br/>
https://en.wikipedia.org/wiki/Kubernetes <br/>
https://docs.docker.com/engine/reference/builder/ <br/>
https://en.wikipedia.org/wiki/Docker_(software) <br/>
https://docs.docker.com/v17.12/engine/reference/commandline/docker/ <br/>


