# Spark Cluster Management Abstraction Layer

* Anish Mirjankar [fa19-516-153](https://github.com/cloudmesh-community/fa19-516-153)  
* Siddhesh Mirjankar [fa19-516-164](https://github.com/cloudmesh-community/fa19-516-164)

* Insights: <https://github.com/cloudmesh-community/fa19-516-153/graphs/contributors>


:o2: use proper markdown

:o2: remove all html code and use proper markdown

:o2: all most hyperlinks are not working

:o2: we can not review your project dud to the trivial markdown errors. please review your document in the epub not in github we only look at the epub

## Problem

In various enterprise data pipelines, there is a lack of multi-cloud
architecture, often due to services like Spark being natively integrated
into clusters such as AWS Elastic MapReduce.  These data pipelines can
benefit from a provider-agnostic solution that will encompass all their
available options, rather than forcing them to choose a cloud platform
over another.  This can be especially beneficial to data teams that
require dynamic storage solutions and want the flexibility to move
between cloud platforms with ease.
      

## Proposal

We will be exploring options for an implementation of Apache Spark that
can be managed remotely from a multi-cloud orchestration service.  We
will abstract the storage and compute initalization within Spark to run
parameterized jobs from this service.  This will allow the performance
bottlenecks of high-performance data transfer to be contained within the
cluster itself, rather than a data source.


## Action

In order to solve this problem, we will be implementing a Nomad and
[Kubernetes](https://github.com/cloudmesh-community/fa19-516-153/blob/master/project/cloudmesh/images/kubernetes/Kubernetes.md)
cluster, and generating a standalone Spark image that will run
parameterized jobs, utilizing all of the available multi-cloud options
available to the orchestator as well as all of the compute instances. 
We will also be implementing a testing service that will provide the
cluster with the access to compute resources and storage that the jobs
will need to run.


## Solution

The solution is composed of 3 main parts, creating a cluster,
interacting with the cluster, and deploying jobs to the cluster. We are
developing a command, `cms cluster`, that will perform all of these
actions efficiently.

:o2: please review the host command in cloudmesh-inventory. Ideally we
should merge the commands. The reason I could not see what you did is
that you did not use proper markdown, so all your links did not work.
Thus instead of calling the command in inventory cluster I called it
host to simplify the merging. Please remember that merging is part of
this review process. We need that functionality only once.

The following commands will be integrated into the cloudmesh service:

```
cluster create -n NAME -p PROVIDER [HOSTNAMES]
cluster add -n NAME HOSTNAME
cluster remove -n NAME HOSTNAME
cluster kill -n NAME # only cloudmesh - bring every machine involved in server down
cluster info # find all clusters
cluster info -n NAME # find info about given cluster (query the address for either kubernetes or nomad)
cluster submit -n NAME JOB
cluster list
```

[Source](https://github.com/cloudmesh-community/fa19-516-153/project/cloudmesh/cluster/command/cluster.py)


### Interaction

We are interacting with the nomad and kubernetes REST APIs to dynamically modify and interact with the cluster/agent configurations while jobs are running.  For each interaction, cloudmesh queries the appropriate provider's API to perform the action to avoid managing a local state.


### Initialization

Using this mechanism, cloudmesh will be able to simultaneously
initialize and prepare machines in a cluster while building and
deploying the images. The initialization and preparation steps will
submit the requested shell script to each machine added to the cluster:

* [Kubernetes](https://github.com/cloudmesh-community/fa19-516-153/project/cloudmesh/images/kubernetes/build.sh)
* [Nomad](https://github.com/cloudmesh-community/fa19-516-153/project/cloudmesh/images/nomad/build.sh)

We are using the Hadoop Distributed File System (HDFS) of Hadoop v3.2.1
to build docker images of the HDFS services namely Namenode, Datanode,
Nodemanager and Resourcemanager. The following are the Dockerfiles for
each HDFS service.

* [Dockerfile for building a Hadoop Image](https://github.com/cloudmesh-community/fa19-516-153/project/cloudmesh/images/hadoop/Dockerfile) <br/>

* [Dockerfile for Namenode](https://github.com/cloudmesh-community/fa19-516-153/project/cloudmesh/images/hadoop/namenode/Dockerfile) <br/>
* [Shell Script to run Namenode](https://github.com/cloudmesh-community/fa19-516-153/project/cloudmesh/images/hadoop/namenode/run.sh) <br/>

* [Dockerfile for Datanode](https://github.com/cloudmesh-community/fa19-516-153/project/cloudmesh/images/hadoop/datanode/Dockerfile) <br/>
* [Shell Script to run Datanode](https://github.com/cloudmesh-community/fa19-516-153/project/cloudmesh/images/hadoop/datanode/run.sh) <br/>

* [Dockerfile for Nodemanager](https://github.com/cloudmesh-community/fa19-516-153/project/cloudmesh/images/hadoop/nodemanager/Dockerfile) <br/>
* [Shell Script to run Nodemanager](https://github.com/cloudmesh-community/fa19-516-153/project/cloudmesh/images/hadoop/nodemanager/run.sh) <br/>

* [Dockerfile for Resourcemanager](https://github.com/cloudmesh-community/fa19-516-153/project/cloudmesh/images/hadoop/resourcemanager/Dockerfile) <br/>
* [Shell Script to run Resourcemanager](https://github.com/cloudmesh-community/fa19-516-153/project/cloudmesh/images/hadoop/resourcemanager/run.sh) <br/>


### Deployment

When submitting a job to each of these providers, cloudmesh will first
build the requested image:

* [Hadoop](https://github.com/cloudmesh-community/fa19-516-153/project/cloudmesh/images/hadoop/Dockerfile)
* Spark - __TODO__
* [Cloudmesh](https://github.com/cloudmesh-community/fa19-516-153/project/cloudmesh/images/cloudmesh/Dockerfile) - if a remote instance is needed

And submit the jobfile to the cluster using the provider's REST API.


### How to start a Kubernetes Cluster?

Step 1 : Make sure you are in the [hadoop](https://github.com/cloudmesh-community/fa19-516-153/project/cloudmesh/images/kubernetes/Hadoop) directory.

Step 2 : Run docker-compose to aggregate the output of all the dockerfiles.

```bash
$ docker-compose up
```

Step 3 : Run all the build commands in the [Makefile](https://github.com/cloudmesh-community/fa19-516-153/project/cloudmesh/images/kubernetes/Hadoop/Makefile)

```bash
$ make build
```

Step 4 : Run all the run commands in the [Makefile](https://github.com/cloudmesh-community/fa19-516-153/project/cloudmesh/images/kubernetes/Hadoop/Makefile)

```bash
$ make run
```

### Possible Errors

A very common error caused while running this code is
**standard_init_linux.go:211: exec user process caused "exec format
error"**. In order to rectify this error, one must use a Linux or Mac
Machine/VM to run the code. If this code is being run on a Windows
Machine, make sure that the line endings of each file is changed from
Windows(CLRF) to Unix(LF).


Sources:

* [Kubernetes](https://kubernetes.io/docs/setup/#production-environment)
* [Nomad](https://www.nomadproject.io/guides/install/production/index.html)
* [Hadoop](https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/ClusterSetup.html)
