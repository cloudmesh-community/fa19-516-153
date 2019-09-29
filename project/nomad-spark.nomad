job "nomad-spark" {
    region = "global"
    datacenters = ["dc1"]
    type = "service"

    task "namenode" {

    }

    group "workers" {
        count = 10
        task "datanode" {
            
        }
    }

    task "resourcemanager" {

    }

    task "nodemanager" {

    }

    task "cloudmesh" {
        config {
            image="cloudmesh:latest"
            args=[""]
        }

        resources {
            cpu=128
            memory=128
        }
    }

}