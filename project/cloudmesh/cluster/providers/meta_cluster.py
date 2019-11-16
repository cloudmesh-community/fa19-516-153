import types
import sys


class MetaCluster(type):
	"""
	Object definition:
	- test
	"""

	def __new__(cls, clsname, superclasses, attributedict):
		assert all([name in attributedict for name in ['add']])
		
		print("clsname: ", clsname)
		print("superclasses: ", superclasses)
		print("attributedict: ", attributedict)
		return type.__new__(cls, clsname, superclasses, attributedict)

	"Provider singleton"
	_instances = {}

	def __call__(cls, *args, **kwargs):
		if cls not in cls._instances:
			cls._instances[cls] = super(MetaCluster, cls).__call__(*args, **kwargs)
		return cls._instances[cls]
