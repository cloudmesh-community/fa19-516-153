import pytest
import cloudmesh as cms

# set cloud=chameleon
# vm boot -n=NUM
# vm assign ips to number
names = [] # all names that have been created
@pytest.fixture
def test_kubernetes(self):
	# cluster create -n test_kuber -p kubernetes names
	pass


@pytest.fixture
def test_nomad(self):
	# cluster create -n test_kuber -p kubernetes names
	pass