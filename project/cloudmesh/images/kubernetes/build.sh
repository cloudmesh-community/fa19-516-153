#Step 1 : Kubernetes Installation on Ubuntu

#Accessing the instances
ssh -i .ssh/smirjank.pem cc@[FLOATING IP]

#Updating repository
$ sudo apt-get update

#Installing docker on ubuntu
$ sudo apt install docker.io

#Enabling the docker utility 
$ sudo systemctl enable docker

#Adding the Kubernetes signing key to the nodes
$ sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add

#Adding Xenial Kubernetes repository
$ sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"

#Updating repository
$ sudo apt-get update

#Installing Kubeadm, Kubelet and Kubectl tools
$ sudo apt-get install -y kubelet kubeadm kubectl

#Step 2 : Kubernetes Deployment

#Disabling swap memory between the nodes
$ sudo swapoff -a

#Defining the master host out of the two nodes
$ sudo hostnamectl set-hostname master-node

#Defining the slave host out of the two nodes
$ hostnamectl set-hostname slave-node

#Step 3 : Initialize Kubernetes on the master node

#Initializing master node
$ sudo kubeadm init --pod-network-cidr=10.244.0.0/16
$ sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=129.114.33.197

#Creating a directory
$ mkdir -p $HOME/.kube

#Moving kubernetes file to that specific directory
$ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
$ sudo chown $(id -u):$(id -g) $HOME/.kube/config

#Joining clusters from either of the nodes
$ sudo kubeadm join 192.168.0.29:6443 --token n4j536.n0jg69abrx4fuudl --discovery-token-ca-cert-hash sha256:b9d5eb0d9e59cd03a22c0385ad0c3a43446fbe8113a57c7a31e73c22c4f25b20

#Checking status of the master node
$ sudo kubectl get nodes

#Installing minikube on windows
choco install minikube -y

#Inspecting current network adapters in powershell
Get-NetAdapter

#Installing packages to allow apt to use a repository over HTTPS
$ sudo apt-get update && sudo apt-get install apt-transport-https ca-certificates curl software-properties-common

#Adding Docker’s official GPG key
$ sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

#Adding Docker apt repository.
$ sudo add-apt-repository \ "deb [arch=amd64] https://download.docker.com/linux/ubuntu \ $(lsb_release -cs) \ stable"

###############################################################################################################################

#Creating a directory to store minikube
$ sudo mkdir -p /usr/local/bin/

#Installing minikube
$ sudo install minikube /usr/local/bin/

#Changing permissions of minikube
$ sudo chmod +x minikube

#Starting a kubernetes cluster
$ sudo minikube start --kubernetes-version v1.16.2

###############################################################################################################################

#Creating a docker-compose.yaml file

#Deploying an HDFS Cluster
docker-compose up -d

#Creating a Dockerfile for the namenode

#Creating a shell script to run the Dockerfile in the namenode

#Building a hadoop image for the namenode
docker build -t smirjank/cloudmesh_namenode:latest -f C:\Users\Siddhesh\Desktop\Cloud_Computing\docker-hadoop\namenode\Dockerfile .

#Creating a Dockerfile for the datanode

#Creating a shell script to run the Dockerfile in the datanode

#Building a hadoop image for the datanode
docker build -t smirjank/cloudmesh_datanode:latest -f C:\Users\Siddhesh\Desktop\Cloud_Computing\docker-hadoop\datanode\Dockerfile .

#Creating a Dockerfile for the historyserver

#Creating a shell script to run the Dockerfile in the historyserver

#Building a hadoop image for the historyserver
docker build -t smirjank/cloudmesh_historyserver:latest -f C:\Users\Siddhesh\Desktop\Cloud_Computing\docker-hadoop\historyserver\Dockerfile .

#Creating a Dockerfile for the resourcemanager

#Creating a shell script to run the Dockerfile in the resourcemanager

#Building a hadoop image for the resourcemanager
docker build -t smirjank/cloudmesh_resourcemanager:latest -f C:\Users\Siddhesh\Desktop\Cloud_Computing\docker-hadoop\resourcemanager\Dockerfile .

#Creating a Dockerfile for the nodemanager

#Creating a shell script to run the Dockerfile in the nodemanager

#Building a hadoop image for the nodemanager
docker build -t smirjank/cloudmesh_nodemanager:latest -f C:\Users\Siddhesh\Desktop\Cloud_Computing\docker-hadoop\nodemanager\Dockerfile .

#Building a Hadoop Image
docker build -t smirjank/cloudmesh:latest -f C:/Users/Siddhesh/Desktop/Cloud_Computing/fa19-516-153/project/cloudmesh/images/hadoop/Dockerfile .

#Creating hbase network manually
docker network create hbase

hadoop pseudo cluster

#Removing all containers
docker rm $(docker ps -a -q)

#Installing dos2unix
RUN apt-get install dos2unix

#Dealing with windows line endings
RUN dos2unix ./entrypoint.sh && apt-get --purge remove -y dos2unix && rm -rf /var/lib/apt/lists/*

#Running all commands together
docker-compose up

#Installing make command on anaconda
conda install -c anaconda make

#Configuring github to commit LF(Unix) line endings
git config --global core.autocrlf false