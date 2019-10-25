
from .meta_cluster import MetaCluster

class KubernetesCluster(metaclass=MetaCluster):
	namehost = None
	def __init__(self, namehost, *args, **kwargs):
		self.namehost= namehost
		super().__init__(*args, namehost=namehost, **kwargs)