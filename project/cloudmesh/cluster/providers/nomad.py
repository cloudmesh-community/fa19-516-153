import cloudmesh as cms

from .meta_cluster import MetaCluster

class NomadCluster(metaclass=MetaCluster):

	instances = []

	def add(self, names:list):
		# first node is server
		# rest are clients
		for i, node in enumerate(names):
			#cms vm script --name=node nomad/build.sh
			if i==0:
				self._generate_server(node)
				break
			self._generate_client(node)
		return True

	@staticmethod
	def _generate_client(instance):
		"""
		Creates a nomad client node
		"""
		# cms vm script --name=instance nomad/build-client.sh
		pass

	@staticmethod
	def _generate_server(instance):
		"""
		Creates a nomad server
		"""
		# cms vm script --name=instance nomad/build-server.sh
		pass