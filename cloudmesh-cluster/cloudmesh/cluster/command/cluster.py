from __future__ import print_function
from cloudmesh.shell.command import command
from cloudmesh.shell.command import PluginCommand
from cloudmesh.cluster.api.manager import Manager
from cloudmesh.common.console import Console
from cloudmesh.common.util import path_expand
from pprint import pprint
from cloudmesh.common.debug import VERBOSE


class ClusterCommand(PluginCommand):

	# noinspection PyUnusedLocal
	@command
	def do_cluster(self, args, arguments):
		"""
		::

		  Usage:
				cluster create -n NAME -p PROVIDER [HOSTNAMES]
				cluster add -n NAME HOSTNAME
				cluster remove -n NAME HOSTNAME
				cluster kill -n NAME # only cloudmesh - bring every machine involved in server down
				cluster info # find all clusters
				cluster info -n NAME # find info about given cluster (query the address for either kubernetes or nomad)
				cluster list 

		  This command allows you to create and interact with an available cluster.

		  Arguments:
			  NAME   	A cluster name/id
			  HOSTNAME	A machine hostname
			  PROVIDER	One of {Nomad, Kubernetes}

		  Options:
			  -n, --name    	specify name
			  -p, --provider	specify provider

		"""
		# arguments.NAME = arguments.get('==name') or arguments['-n'] or None
		# arguments.PROVIDER = arguments['--provider'] or arguments['-p'] or None

		VERBOSE(arguments)

		m = Manager()

		if arguments.create:
			### own computer
			## TODO connect to the given hostnames (add it to vm list) watch out for mixed cloud
			## TODO install nomad image on each host
			## TODO deploy to main nomad server main_host:4646
			## generate consul address dynamic pointing to server host
			print("option a")
			m.list(arguments)

		# for every one of the options we interact with nomad consul address - api
		elif arguments.add:
			print("option b")
			m.list(arguments)

		elif arguments.remove:
			print("option b")
			m.list(arguments)

		elif arguments.kill:
			print("option b")
			m.list(arguments)

		return ""
