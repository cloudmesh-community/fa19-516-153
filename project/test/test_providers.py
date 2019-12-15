import pytest

def test_kubernetes():
	from cloudmesh.cluster.providers import KubernetesCluster
	kube = KubernetesCluster()
	assert False

def test_nomad():
	from cloudmesh.cluster.providers import NomadCluster
	nomad = NomadCluster()
	assert False
