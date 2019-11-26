job {
	task "hadoop-namenode" {
		image="cloudmesh/docker-hadoop-namenode",
		resources {
			cpu=2,
			memory=1028
		}
	},
	
}