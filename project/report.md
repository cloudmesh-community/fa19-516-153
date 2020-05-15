# Spark Cluster Management Abstraction Layer
* Anish Mirjankar [fa19-516-153](https://github.com/cloudmesh-community/fa19-516-153)
* Siddhesh Mirjankar [fa19-516-164](https://github.com/cloudmesh-community/fa19-516-164)
* Gregor von Laszewski
* [Insights](https://github.com/cloudmesh-community/fa19-516-153/graphs/contributors)

The following repositories contain the code in this project.
* [cloudmesh-community/fa19-516-153](https://github.com/cloudmesh-community/fa19-516-153)
* [cloudmesh/cloudmesh-cluster](https://github.com/cloudmesh/cloudmesh-cluster)
* [cloudmesh/cloudmesh-spark](https://github.com/cloudmesh/cloudmesh-spark)*
* [cloudmesh/cloudmesh-hadoop](https://github.com/cloudmesh/cloudmesh-hadoop)*
* [cloudmes/cloudmesh-k8](https://github.com/cloudmesh/cloudmesh-k8)*

_*Incomplete due to unmet dependencies in cloudmesh cluster._
Deployments currently have to be made manually using the cluster deploy command and the shell scripts, files, and images stored in
[images](./cloudmesh/images).  

## Introduction
In various enterprise data pipelines, there is a lack of multi-cloud architecture, often due to cloud platforms offering easy-to-use products such as [AWS Elastic MapReduce](https://aws.amazon.com/emr/), [Azure HDInsight](https://azure.microsoft.com/en-us/services/hdinsight/), [Google Dataproc](https://cloud.google.com/dataproc/), or [Oracle Big Data Cloud Service](https://www.oracle.com/big-data/big-data-cloud-service/). Businesses suffer from the lack of the ability to deploy applications to clusters that encompass several cloud platforms and on-premises storage/compute.  These data pipelines can benefit from a provider-agnostic solution that will encompass all their available options, rather than forcing them to choose a cloud platform over another. This can be especially beneficial to data teams that require dynamic storage solutions and want the flexibility to move between cloud platforms with ease. Our solution will integrate a flexible cloud cluster service into the resource management services provided by [Cloudmesh](https://cloudmesh-community.github.io/), in order to provide teams with a better resource with which to easily deploy clusters.

The following process diagram describes how our application will interact with cloud instances, other processes (Docker/Kubernetes, Cloudmesh), and the live Hadoop/Spark instances.
!["Process Diagram"](./diagram.jpg)     
*[Source](https://github.com/cloudmesh-community/fa19-516-153/blob/master/project/diagram.jpg)*

## Progress/Benchmarking
Our team prototyped our product using a combination of Docker and Nomad on OpenStack to orchestrate clusters and deploy applications.  Cloudmesh was used to manage cloud instances, build images, and automate the deployment cycle.  Nomad was initially used due to its ease of use for prototyping and general-purpose application deployment ([source](https://www.hashicorp.com/resources/hashicorp-nomad-vs-kubernetes-comparing-complexity)). Nomad was rejected due to the superiority of the Kubernetes technology stack, which provided a quicker deployment and more effective job management.  Our team is currently working on integrating [Parameterized Stanzas](https://www.nomadproject.io/docs/job-specification/parameterized.html) into the Cloudmesh Kubernetes Deployment in order to complete the replacement of Nomad in our project.

Our team is additionally working on the following cloudmesh commands in order to automate the deployment and requesting of instances based on available resources:
```bash
cluster create LABEL (--vms=NAMES | --n=N) [--cloud=CLOUD]
cluster (add|remove) LABEL (--vms=NAMES | --n=N) [--cloud=CLOUD]
cluster deploy --file=FILE LABEL
cluster terminate LABEL [--kill]
cluster info [LABEL] [--verbose=V]
```
*[Source](https://github.com/cloudmesh-community/fa19-516-153/tree/master/project/cloudmesh/cluster/command/cluster.py)*

## Deploying a Kubernetes Cluster using Cloudmesh
The following capabilities of Cloudmesh were used to provision instances and deploy Kubernetes to [AWS](https://aws.amazon.com/), [Azure](https://azure.microsoft.com/), and [OpenStack](https://www.chameleoncloud.org/):
* [cloudmesh-cloud](https://github.com/cloudmesh/cloudmesh-cloud): Resource provisioning, cloud access
* [cloudmesh-inventory](https://github.com/cloudmesh/cloudmesh-inventory): Resource management, access & security
* [cloudmesh-cluster](https://github.com/cloudmesh/cloudmesh-cluster): Cluster deployment, images

### How to deploy a Kubernetes Cluster?

Step 1: Use a Unix-based CLI to enter the directory [cloudmesh_hadoop](https://github.com/cloudmesh-community/fa19-516-153/tree/master/project/cloudmesh/images/kubernetes/cloudmesh_hadoop). 

Step 2: Clean up docker artifacts.

```bash
make clean
```

Step 3: Initiate the build process in the
[Makefile](https://github.com/cloudmesh-community/fa19-516-153/tree/master/project/cloudmesh/images/kubernetes/cloudmesh_hadoop/Makefile).

```bash
make build
```

Step 4: Run docker-compose to aggregate the output of all the
dockerfiles.

```bash
docker-compose up
```


Step 5: Run all the run commands in the
[Makefile](https://github.com/cloudmesh-community/fa19-516-153/tree/master/project/cloudmesh/images/kubernetes/cloudmesh_hadoop/Makefile)

```bash
make run
```

Step 6: Deploy a Kubernetes Cluster

```bash
docker stack deploy --orchestrator kubernetes -c docker-compose.yml cloudmesh_hadoop
```

Step 7: Remove the Kubernetes Cluster

```bash
docker stack rm cloudmesh_hadoop
```


## References

* [Kubernetes](https://kubernetes.io/docs/setup/#production-environment)
* [Nomad](https://www.nomadproject.io/guides/install/production/index.html)
* [Hadoop](https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/ClusterSetup.html)
