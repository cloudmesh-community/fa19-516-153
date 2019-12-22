# Spark Cluster Management Abstraction Layer

* Anish Mirjankar [fa19-516-153](https://github.com/cloudmesh-community/fa19-516-153)  
* Siddhesh Mirjankar [fa19-516-164](https://github.com/cloudmesh-community/fa19-516-164)

* Insights: <https://github.com/cloudmesh-community/fa19-516-153/graphs/contributors>

:o2: what is progress

:o2: use proper markdown

:o2: remove all html code and use proper markdown

:o2: all most hyperlinks are not working

:o2: we can not review your project dud to the trivial markdown errors.
please review your document in the epub not in github we only look at
the epub

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
[Kubernetes](https://github.com/cloudmesh-community/fa19-516-153/tree/master/project/cloudmesh/images/kubernetes/Kubernetes.md)
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

## Progress

* Successfully deployed a Hadoop using a Nomad Cluster
* Integrated the deployment with Cloudmesh. Automation is left.
* Successfully deployed a Hadoop using a Kubernetes Cluster
* Need to integrate and automate the deployment with Cloudmesh

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

# only cloudmesh - bring every machine involved in server down
cluster kill -n NAME 

cluster info # find all clusters

# find info about given cluster (query the address for 
# either kubernetes or nomad)
cluster info -n NAME 
cluster submit -n NAME JOB
cluster list
```

[Source](https://github.com/cloudmesh-community/fa19-516-153/tree/master/project/cloudmesh/cluster/command/cluster.py)


### Interaction

We are interacting with the nomad and kubernetes REST APIs to
dynamically modify and interact with the cluster/agent configurations
while jobs are running.  For each interaction, cloudmesh queries the
appropriate provider's API to perform the action to avoid managing a
local state.


### Initialization

Using this mechanism, cloudmesh will be able to simultaneously
initialize and prepare machines in a cluster while building and
deploying the images. The initialization and preparation steps will
submit the requested shell script to each machine added to the cluster:

* [Kubernetes](https://github.com/cloudmesh-community/fa19-516-153/tree/master/project/cloudmesh/images/kubernetes/build.sh)
* [Nomad](https://github.com/cloudmesh-community/fa19-516-153/tree/master/project/cloudmesh/images/nomad/build.sh)

We are using the Hadoop Distributed File System (HDFS) of Hadoop v3.2.1
to build docker images of the HDFS services namely Namenode, Datanode,
Nodemanager and Resourcemanager. The following are the Dockerfiles for
each HDFS service.

* [Dockerfile for building a Hadoop Image](https://github.com/cloudmesh-community/fa19-516-153/tree/master/project/cloudmesh/images/kubernetes/cloudmesh_hadoop/base/Dockerfile) <br/>

* [Dockerfile for Namenode](https://github.com/cloudmesh-community/fa19-516-153/tree/master/project/cloudmesh/images/kubernetes/cloudmesh_hadoop/namenode/Dockerfile) <br/>
* [Shell Script to run Namenode](https://github.com/cloudmesh-community/fa19-516-153/tree/master/project/cloudmesh/images/kubernetes/cloudmesh_hadoop/namenode/run.sh) <br/>

* [Dockerfile for Datanode](https://github.com/cloudmesh-community/fa19-516-153/tree/master/project/cloudmesh/images/kubernetes/cloudmesh_hadoop/datanode/Dockerfile) <br/>
* [Shell Script to run Datanode](https://github.com/cloudmesh-community/fa19-516-153/tree/master/project/cloudmesh/images/kubernetes/cloudmesh_hadoop/datanode/run.sh) <br/>

* [Dockerfile for Nodemanager](https://github.com/cloudmesh-community/fa19-516-153/tree/master/project/cloudmesh/images/kubernetes/cloudmesh_hadoop/nodemanager/Dockerfile) <br/>
* [Shell Script to run Nodemanager](https://github.com/cloudmesh-community/fa19-516-153/tree/master/project/cloudmesh/images/kubernetes/cloudmesh_hadoop/nodemanager/run.sh) <br/>

* [Dockerfile for Resourcemanager](https://github.com/cloudmesh-community/fa19-516-153/tree/master/project/cloudmesh/images/kubernetes/cloudmesh_hadoop/resourcemanager/Dockerfile) <br/>
* [Shell Script to run Resourcemanager](https://github.com/cloudmesh-community/fa19-516-153/tree/master/project/cloudmesh/images/kubernetes/cloudmesh_hadoop/resourcemanager/run.sh) <br/>

* [Dockerfile for Historyserver](https://github.com/cloudmesh-community/fa19-516-153/tree/master/project/cloudmesh/images/kubernetes/cloudmesh_hadoop/historyserver/Dockerfile) <br/>
* [Shell Script to run Historyserver](https://github.com/cloudmesh-community/fa19-516-153/tree/master/project/cloudmesh/images/kubernetes/cloudmesh_hadoop/historyserver/run.sh) <br/>

### Deployment

When submitting a job to each of these providers, cloudmesh will first
build the requested image:

* [Hadoop](https://github.com/cloudmesh-community/fa19-516-153/tree/master/project/cloudmesh/images/kubernetes/cloudmesh_hadoop/base/Dockerfile)
* Spark - __TODO__
* [Cloudmesh](https://github.com/cloudmesh-community/fa19-516-153/tree/master/project/cloudmesh/images/cloudmesh/Dockerfile) - if a remote instance is needed

And submit the jobfile to the cluster using the provider's REST API.


### How to deploy a Kubernetes Cluster?

Step 1: Make sure you are in the [cloudmesh_hadoop](https://github.com/cloudmesh-community/fa19-516-153/tree/master/project/cloudmesh/images/kubernetes/cloudmesh_hadoop)
directory and open **Gitbash**. 

Step 2: Open  and clean up docker

```bash
make clean
```

Step 3: Run all the build commands in the
[Makefile](https://github.com/cloudmesh-community/fa19-516-153/tree/master/project/cloudmesh/images/kubernetes/cloudmesh_hadoop/Makefile)

```bash
make build
```

Step 4: Run docker-compose to aggregate the output of all the
dockerfiles.

```bash
docker-compose up
```


Step 5: Run all the run commands in the [Makefile](https://github.com/cloudmesh-community/fa19-516-153/tree/master/project/cloudmesh/images/kubernetes/cloudmesh_hadoop/Makefile)

```bash
make run
```

Step 6: Deploy a Kubernetes Cluster

```bash
docker stack deploy --orchestrator kubernetes -c docker-compose.yml hadoop
```


### Deployment on Nomad
Nomad is a cluster and resource management service primarily used for prototyping and is currently running on the HashiCorp ecosystem (Vagrant, Consul, Terraform, etc.) The primary use-case for nomad is quick protyping and rapid integration of new servers into a docker-based protocol.  One strong benefit of nomad is its job parameterization functions - allowing images to be rapidly deployed through the API based on a minimal set of constraints.

Nomad is designed around a single software package which is to be installed on a Debian 9+ VM for optimal use.  [Nomad Installation](http://github.com/cloudmesh-community/fa19-516-153/tree/master/project/cloudmesh/images/nomad/build.sh)

First, a nomad agent will be deployed:
```sh
nomad agent -dev		# for local development environment OR
nomad agent -client		# for cluster client agent OR
nomad agent -server		# for cluster server agent
```
This will ensure that nomad is running and searching for all peers in the network.

If peers do not exist in the nomad network, the user must instruct the nomad agent to look for servers.  This can be controlled by the `-servers` option.
```sh
nomad agent -{type} -servers "host1:port,host2:port,..."
```

 Once a nomad agent/cluster is generated, a jobfile must be deployed to this cluster.  This can be performed by running the command:
 ```sh
 nomad job run JOBFILE_PATH						# if the cluster is locally held or the NOMAD_ADDR env variable is set OR
 nomad job run -address={addr} JOBFILE_PATH		# if the cluster is remotely held
 ```

The nomad api can be easily accessed on a custom nomad port or the default port 4646.  This api will control all machines connected to the same cluster.


#### Deploying Hadoop to the Nomad Cluster
The Hadoop ecosystem may be deployed to a nomad cluster using docker-based components.
The following images will need to be built and deployed to a container repository or transferred to all nomad servers.

```sh
cd ~/cloudmesh/images/hadoop
docker build -t hadoop-base ./base
docker build -t hadoop-namenode ./namenode
docker build -t hadoop-datanode ./datanode
docker build -t hadoop-resourcemanager ./resourcemanager
docker build -t hadoop-nodemanager ./nodemanager
docker build -t hadoop-historyserver ./historyserver
docker build -t hadoop-submit ./submit
```

Each image will be run in a task in the format:
```
task "{task_name}" {
	image="{image_name}"
}
```

## References

* [Kubernetes](https://kubernetes.io/docs/setup/#production-environment)
* [Nomad](https://www.nomadproject.io/guides/install/production/index.html)
* [Hadoop](https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/ClusterSetup.html)
