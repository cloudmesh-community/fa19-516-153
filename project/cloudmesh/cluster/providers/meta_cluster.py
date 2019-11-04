import types
import sys

class MetaCluster(type):
	def __new__(cls, name, bases, attr:dict):
		required_attr = [
			'add', 'remove', 'cluster_info', 'list', 'namehost'
		]

		if required_attr not in attr.keys():
			print(f"{required_attr} not in {attr}.  FIX!!!", file=sys.stderr)

	def __call__(cls, attr,):
		"""

		"""
		print("Running method {}".format(attr), file=sys.stderr)
		