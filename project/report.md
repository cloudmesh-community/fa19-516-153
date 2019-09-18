# :o2: TITLE MISSING

:o2: NAme and hid missing

## Problem

In various enterprise data pipelines, there is a lack of multi-cloud
architecture, often due to services like Spark being natively integrated into
clusters such as AWS Elastic MapReduce.  These data pipelines can benefit from
a provider-agnostic solution that will encompass all their available options,
rather than forcing them to choose a cloud platform over another.  This can be
especially beneficial to data teams that require dynamic storage solutions and 
want the flexibility to move between cloud platforms with ease. 
      


## Proposal

I will be exploring options for an implementation of Apache Spark that can be
managed remotely from a multi-cloud orchestration service.  I will abstract the
storage and compute initalization within Spark to run parameterized jobs from
this service.  This will allow the performance bottlenecks of high-performance
data transfer to be contained within the cluster itself, rather than a data
source.



## Action

In order to solve this problem, I will be implementing a Nomad cluster, and
generating a standalone Spark image that will run parameterized jobs,
utilizing all of the available multi-cloud options available to the orchestator
as well as all of the compute instances.  I will also be implementing a testing
service that will provide the cluster with the access to compute resources and
storage that the jobs will need to run.

## Comments :o2:

LICENSE

* Apache

develop 

* abstract API
* generate abstarct interface do deply a cluster (my be nomad on the backend, could be other technology)
* develop REST API with conexion introspection (we will teach you). e.g. Work on an abstarction API that can be used in the commandline implementation and the REST service


propose cloudmesh command(s) to 

* Develop a proposed command in docopts from the commandline
* deploy nomad cluster
* generate spark image
* manage parameterized jobs

Testing

* develop pytests to test them and benchmark deployment (teardown) and execution of the pipeline sepeartely.
* Develop this report further with an Architecture diagram

Document

* use proper markdown ;-)
* add bibtex refernces ... in report.bib and use in your document


