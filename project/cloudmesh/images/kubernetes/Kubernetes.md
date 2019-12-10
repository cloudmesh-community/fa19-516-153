## Kubernetes

Kubernetes is an open-source system that automates the scaling, management and deployment of containerized applications based on the CPU, 
memory or some custom metrics. It groups the containers into logical units so that it can manage the containers easily. The Kubernetes API
provides a feature of extensibility to the containers that run on Kubernetes. This extensibility allows the user to work with Kubernetes
on different workloads. Kubernetes works with a wide range of container tools. One such tool is Docker.

Kubernetes manages resources in the form of Objects. The key objects of Kubernetes are :

* Pods : <br/>
A pod is the basic scheduling unit in Kubernetes. It consistes of one or more containers that can share resources and are co-located on 
the host machine. Each pod has a unique IP address. Due to this IP address, applications are able to use ports without the risk of any 
conflict. This IP address is the means of communication between containers located in different pods. Containers in the same pod are able 
to communicate with each other on the localhost.

* Replica Sets : <br/>
Replica Sets are a mechanism that helps Kubernetes identify all the pods that are required to execute an application successfully. It 
maintains the number of instances that have been declared for a given pod to use.

* Services : <br/>
A Kubernetes service is a collection of pods working together in order to run an application. A label selector defines the collection of 
pods that consitute a service. Kubernetes can discover services either by using environmental variables or by using Kubernetes DNS. When 
Kubernetes discovers a service, an IP address and a DNS name is assigned to the service. A service is exposed inside a cluster by default. 
In order to enable the clients to use the pods, a service can also be exposed outside a cluster if need be.

* Volumes : <br/>
A Kubernetes volume stores the container data. Unlike file systems, the stored data will not be wiped out from a Kubernetes volume 
whenever the pod is restarted. The container data is stored in the Kubernetes volume as long as the lifetime the pod. The pod configuration 
defines specific mount points within the container. The Kubernetes volume is mounted at these mount points. Sometimes, the same volume can 
be mounted at different points by different containers.

* Namespaces : <br/>
Non-overlapping spaces into which the Kubernetes resources are partitioned are called Kubernetes namespaces. Namespaces are intended to be 
used in environments where there are many users working in multiple teams. It even separates the different environments such as development, 
test, and production.

* ConfigMaps and Secrets : <br/>
ConfigMaps and Secrets are Kubernetes features that allow changes to be made to the configuration information of an application without 
actually needing to build the application. Every single instance of the application will have access to the data from configmaps and 
secrets. This data is only sent to a node if it is required by the pod on that node. Kubernetes stores this data in the memory of the node. 
Once the pod that is using the data from configmaps and secrets is deleted, the data stored in the memory of the nodes is deleted as well. 
The pod can access this data in the form of environment variables or from the container filesystem visible only from within the pod. The 
content of the data in a secret is base64 encoded which is not the case in configmaps.

* StatefulSets : <br/>
StatefulSets are controllers that ensure that the pod instances are unique and ordered. Using Kubernetes StatefulSets ensures that even if 
the pod is restarted, the state of the application is still preserved. The state may be needed to be redistributed if the application is 
scaled either up or down.

* DaemonSets : <br/>
DaemonSets are a Kubernetes feature that enables implementation of pod scheduling such that a pod runs on every single node in the cluster.
DaemonSets are used for collection of logs and various storage services.

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

This [Dockerfile](cloudmesh/images/hadoop/Dockerfile) builds a Hadoop v3.2.1 image when the command **docker build -t [IMAGE NAME] .** is executed

## What is Hadoop?

Apache Hadoop is an open source software that makes use of the networking of many computers in order to solve massive data related problems. 
Its MapReduce programming model is responsible for the big data's distributed storage and processing. The motive behind the design of all 
Hadoop modules is "hardware failures are common occurrences and should be automatically handled by the framework".

## What is Hadoop Distributed File System?

Hadoop Distributed File System (HDFS) is a file system written in Java for the Hadoop Framework. The main advantage of HDFS is that it is 
portable and scalable. Like other file systems, HDFS also provides Shell commands and Java application programming interface (API) methods.
The HDFS services used with Kubernetes in this project are.

1. Namenode : <br/>
Hadoop Namenode acts like a Master Node which tracks files and manages the file system. It contains the information about the number of blocks,
locations in which data and its replications are stored and various other information. The client directly connects with the Namenode.

The Dockerfile used to build a Namenode image is :
```
#Referred https://github.com/big-data-europe/docker-hadoop/blob/master/namenode/Dockerfile

#Getting base hadoop image
FROM bde2020/hadoop-base
#FROM cloudmesh/docker-hadoop

#Checking the health of the container
HEALTHCHECK CMD curl -f http://localhost:9870/ || exit 1

#Providing values for future environment variables
ENV HDFS_CONF_dfs_namenode_name_dir=file:///hadoop/dfs/name

#Creating a directory inside the docker image
RUN mkdir -p /hadoop/dfs/name

#Creating a volume for the docker image each time a container is started
VOLUME /hadoop/dfs/name

#Copying the file into the docker image
COPY run.sh /root/run.sh

#Changing the access persmissions of the file
RUN chmod a+x /root/run.sh

#Informing docker that the container listens on port 9870 at runtime
EXPOSE 9870 8020

#FROM ubuntu

#Updating the apt package index
#RUN apt-get update

#Installing dos2unix
#RUN apt-get install dos2unix

#Dealing with docker line endings
#RUN dos2unix ./entrypoint.sh && apt-get --purge remove -y dos2unix && rm -rf /var/lib/apt/lists/*

#Running the run.sh file during container creation
CMD "/root/run.sh"
```

This [Dockerfile](https://github.com/cloudmesh-community/fa19-516-153/blob/master/project/cloudmesh/images/hadoop/namenode/Dockerfile) builds a Hadoop v3.2.1 Namenode image when the command **docker build -t [IMAGE NAME] .** is executed
<br/>

2. Datanode : <br/>
Hadoop Datanode stores the actual data in the HDFS in the form of blocks. The Datanode acts as a Slave Node and is responsible for the client 
to read and write. Every three seconds, the Datanode sends a 'heartbeat message' to the Namenode in order to convey that it is alive. Due to 
this, if the Namenode does not receive a heartbeat message from the Datanode within three seconds, it will assume the Datanode to be dead and 
will begin the replication processes on another Datanode.

The Dockerfile used to build a Datanode image is :
```
#Referred https://github.com/big-data-europe/docker-hadoop/blob/master/datanode/Dockerfile

#Getting base hadoop image
FROM bde2020/hadoop-base
#FROM cloudmesh/docker-hadoop

#Checking the health of the container
HEALTHCHECK CMD curl -f http://localhost:9864/ || exit 1

#Providing values for future environment variables
ENV HDFS_CONF_dfs_datanode_data_dir=file:///hadoop/dfs/data

#Creating a directory inside the docker image
RUN mkdir -p /hadoop/dfs/data

#Creating a volume for the docker image each time a container is started
VOLUME /hadoop/dfs/data

#Copying the file into the docker image
COPY run.sh /root/run.sh

#Changing the access persmissions of the file
RUN chmod a+x /root/run.sh

#Informing docker that the container listens on port 9864 at runtime
EXPOSE 9864

#FROM ubuntu

#Updating the apt package index
RUN apt-get update

#Installing dos2unix
RUN apt-get install dos2unix

#Dealing with docker line endings
RUN dos2unix /root/run.sh && apt-get --purge remove -y dos2unix && rm -rf /var/lib/apt/lists/*

#Running the run.sh file during container creation
CMD ["/root/run.sh"]
```

This [Dockerfile](https://github.com/cloudmesh-community/fa19-516-153/blob/master/project/cloudmesh/images/hadoop/datanode/Dockerfile) builds a Hadoop v3.2.1 Datanode image when the command **docker build -t [IMAGE NAME] .** is executed
<br/>

3. Nodemanager : <br/>
Hadoop NodeManager launches and manages containers on a node. The AppMaster specifies the tasks to be executed by the containers. The 
Nodmanager runs services in order to determine whether the node and the disks are healthy or not. If the Nodemanager determines that a 
particular node is not healthy, then it communicates this information to the Hadoop Resourcemanager which stops assigning containers to 
that particular node.

The Dockerfile used to build a Nodemanager image is :
```
#Referred https://github.com/big-data-europe/docker-hadoop/blob/master/nodemanager/Dockerfile

#Getting base hadoop image
FROM bde2020/hadoop-base
#FROM cloudmesh/docker-hadoop

#Checking the health of the container
HEALTHCHECK CMD curl -f http://localhost:8042/ || exit 1

#Copying the file into the docker image
COPY run.sh /root/run.sh

#Changing the access persmissions of the file
RUN chmod a+x /root/run.sh

#Informing docker that the container listens on port 8042 at runtime
EXPOSE 8042

#Running the run.sh file during container creation
CMD ["/root/run.sh"]
```

This [Dockerfile](https://github.com/cloudmesh-community/fa19-516-153/blob/master/project/cloudmesh/images/hadoop/nodemanager/Dockerfile) builds a Hadoop v3.2.1 Nodemanager image when the command **docker build -t [IMAGE NAME] .** is executed

4. Resourcemanager : <br/>
Hadoop Resourcemanager manages the distributed applications that run on a Hadoop system by arbitrating the resources of all the available 
clusters. It works in coordination with the Nodemanager. It stops assigning containers to a particular node if the Nodemanager finds that 
node to be unhealthy.

The Dockerfile used to build a Resourcemanager image is :
```
#Referred https://github.com/big-data-europe/docker-hadoop/blob/master/resourcemanager/Dockerfile

#Getting base hadoop image
FROM bde2020/hadoop-base
#FROM cloudmesh/docker-hadoop

#Checking the health of the container
HEALTHCHECK CMD curl -f http://localhost:8088/ || exit 1

#Copying the file into the docker image
COPY run.sh /root/run.sh

#Changing the access persmissions of the file
RUN chmod a+x /root/run.sh

#Informing docker that the container listens on port 8088 at runtime
EXPOSE 8088

#Running the run.sh file during container creation
CMD ["/root/run.sh"]
```

This [Dockerfile](https://github.com/cloudmesh-community/fa19-516-153/blob/master/project/cloudmesh/images/hadoop/resourcemanager/Dockerfile) builds a Hadoop v3.2.1 Resourcemanager image when the command **docker build -t [IMAGE NAME] .** is executed

## How to start a Kubernetes Cluster?

Step 1 : Make sure you are in the [hadoop](https://github.com/cloudmesh-community/fa19-516-153/tree/master/project/cloudmesh/images/kubernetes/Hadoop) directory.

Step 2 : Run docker-compose to aggregate the output of all the dockerfiles.
```
docker-compose up
```

Step 3 : Run all the build commands in the [Makefile](https://github.com/cloudmesh-community/fa19-516-153/tree/master/project/cloudmesh/images/kubernetes/Hadoop/Makefile)
```
make build
```

Step 4 : Run all the run commands in the [Makefile](https://github.com/cloudmesh-community/fa19-516-153/tree/master/project/cloudmesh/images/kubernetes/Hadoop/Makefile)
```
make run
```

## Possible Errors

A very common error caused while running this code is **standard_init_linux.go:211: exec user process caused "exec format error"**. In order to rectify 
this error, one must use a Linux or Mac Machine/VM to run the code. If this code is being run on a Windows Machine, make sure that the line endings of 
each file is changed from Windows(CLRF) to Unix(LF).

## References

https://blog.kumina.nl/2018/04/the-benefits-and-business-value-of-kubernetes/ <br/>
https://en.wikipedia.org/wiki/Kubernetes <br/>
https://docs.docker.com/engine/reference/builder/ <br/>
https://en.wikipedia.org/wiki/Docker_(software) <br/>
https://docs.docker.com/v17.12/engine/reference/commandline/docker/ <br/>
https://en.wikipedia.org/wiki/Apache_Hadoop <br/>
https://hadoop.apache.org/docs/r2.8.0/hadoop-yarn/hadoop-yarn-site/NodeManager.html <br/>
https://blog.cloudera.com/apache-hadoop-yarn-resourcemanager/