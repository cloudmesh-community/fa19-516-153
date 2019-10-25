# Spark Cluster Management Abstraction Layer
Anish Mirjankar [fa19-516-153](https://github.com/cloudmesh-community/fa19-516-153)  
Siddhesh Mirjankar [fa19-516-164](https://github.com/cloudmesh-community/fa19-516-164)

Insights: <https://github.com/cloudmesh-community/fa19-516-153/graphs/contributors>

## Problem

In various enterprise data pipelines, there is a lack of multi-cloud
architecture, often due to services like Spark being natively integrated into
clusters such as AWS Elastic MapReduce.  These data pipelines can benefit from
a provider-agnostic solution that will encompass all their available options,
rather than forcing them to choose a cloud platform over another.  This can be
especially beneficial to data teams that require dynamic storage solutions and 
want the flexibility to move between cloud platforms with ease. 
      


## Proposal

We will be exploring options for an implementation of Apache Spark that can be
managed remotely from a multi-cloud orchestration service.  We will abstract the
storage and compute initalization within Spark to run parameterized jobs from
this service.  This will allow the performance bottlenecks of high-performance
data transfer to be contained within the cluster itself, rather than a data
source.



## Action

In order to solve this problem, we will be implementing a Nomad and Kubernetes cluster, and
generating a standalone Spark image that will run parameterized jobs,
utilizing all of the available multi-cloud options available to the orchestator
as well as all of the compute instances.  We will also be implementing a testing
service that will provide the cluster with the access to compute resources and
storage that the jobs will need to run.


## Solution

The solution is composed of 3 main parts, creating a cluster, interacting with the cluster, and deploying jobs to the cluster.  
We are developing a command, `cms cluster`, that will perform all of these actions efficiently. 

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
[Source](cloudmesh/cluster/command/cluster.py)

### Interaction

We are interacting with the nomad and kubernetes REST APIs to dynamically modify and interact with the cluster/agent configurations while jobs are running.  For each interaction, cloudmesh queries the appropriate provider's API to perform the action to avoid managing a local state.


### Initialization

Using this mechanism, cloudmesh will be able to simultaneously initialize and prepare machines in a cluster while building and deploying the images.  
The initialization and preparation steps will submit the requested shell script to each machine added to the cluster:
 - [Kubernetes](cloudmesh/images/kubernetes/walkthrough.sh)
 - [Nomad](cloudmesh/images/nomad/build.sh)

### Deployment
When submitting a job to each of these providers, cloudmesh will first build the requested image:
 - [Hadoop](cloudmesh/images/hadoop/Dockerfile)
 - Spark - __TODO__
 - [Cloudmesh](cloudmesh/images/cloudmesh/Dockerfile) - if a remote instance is needed

And submit the jobfile to the cluster using the provider's REST API.


Sources:
- [Kubernetes](https://kubernetes.io/docs/setup/#production-environment)
- [Nomad](https://www.nomadproject.io/guides/install/production/index.html)
- [Hadoop](https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/ClusterSetup.html)