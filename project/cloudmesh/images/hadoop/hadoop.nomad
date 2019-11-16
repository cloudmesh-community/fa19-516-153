job {
	task "hadoop-namenode" {
		image="uhopper/hadoop-namenode",
		resources {
			cpu=2,
			memory=1028
		}
	}
}