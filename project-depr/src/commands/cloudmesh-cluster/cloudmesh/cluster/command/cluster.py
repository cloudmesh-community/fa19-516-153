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
				cluster kill -n NAME
				cluster info
				cluster info -n NAME
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
			print("option a")
			m.list(arguments)

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
