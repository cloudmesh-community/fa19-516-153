from __future__ import print_function
from cloudmesh.shell.command import command, map_parameters, PluginCommand
from cloudmesh.cluster.api.manager import Manager
from cloudmesh.common.console import Console
from cloudmesh.common.util import path_expand
from pprint import pprint
from cloudmesh.common.debug import VERBOSE
from cloudmesh.common.Shell import Shell
import datetime

class ClusterCommand(PluginCommand):

	# noinspection PyUnusedLocal
	@command
	def do_cluster(self, args, arguments):
		"""
		::

		  Usage:
		  		cluster
				cluster create --provider=PROVIDER --deploy=FILE NAME
				cluster add --name=NAME NAME
				cluster remove --name=NAME NAME
				cluster deploy --name=NAME FILE
				cluster kill NAME
				cluster list
				cluster info NAME


		  This command allows you to create and interact with an available cluster.

		  Arguments:
			  NAME   	A name/id of a cluster or machine
			  PROVIDER	One of {Nomad, Kubernetes}
			  FILE		Jobfile for given provider

		  Options:
			  --name    	specify name
			  --provider	specify provider
			  --deploy		specify application to deploy (jobfile)

		"""
		map_parameters(arguments,
                 'name',
				 'provider',
				 'deploy'
                 )

		clusters = {}

		vm_boot = """
		/bin/bash cms vm boot \
			--name=amirjankar-hadoop \
			--output=json \
			--n=3
		"""
		if arguments.create:
			Console.info(f"Creating cluster {arguments.NAME}...")
			if not arguments.NAME:
				raise ValueError("Enter a name for the cluster.")
			name = arguments.NAME
			clusters[name] = {
				'created_at': datetime.datetime.now().strftime("%Y-%m-%D %H:%M:%S"),
				'machines': []
			}
			VERBOSE(clusters)


		elif arguments.add:
			Console.info(f"Attempting to add {arguments.NAME} from {arguments.name}")
			cluster_name, machine_name = arguments.name, arguments.NAME
			if cluster_name not in clusters.keys():
				VERBOSE(clusters)
				raise ValueError(f"{cluster_name} doesn't exist. Create cluster with cms cluster create.")
			
			if machine_name in clusters[cluster_name]['machines']:
				VERBOSE(clusters)
				raise ValueError(f"{machine_name} already in {cluster_name}")

			clusters[cluster_name]['machines'].append(machine_name)
			VERBOSE(f"Successfully added {machine_name} to {cluster_name}.")

		elif arguments.remove:
			Console.info(f"Attempting to remove {arguments.NAME} from {arguments.name}")

		elif arguments.deploy:
			Console.info(f"Attempting to deploy {arguments.FILE} from {arguments.name}")

		elif arguments.kill:
			Console.info(f"Attempting to kill {arguments.NAME}")
			Shell()
		elif arguments.list:
			VERBOSE(clusters)

		elif arguments.info:
			Console.info(f"Retriving info for cluster {arguments.NAME}")

			
		return ""
