
import subprocess

command = "git clone https://github.com/cloudmesh/cloudmesh-common.git"
output = subprocess.check_output(command,
										 shell=True,
										 stderr=subprocess.STDOUT,
										 )

