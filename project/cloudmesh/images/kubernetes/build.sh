#Step 1 : Kubernetes Installation on Ubuntu

#Installing docker on ubuntu
$ sudo apt install docker.io

#Enabling the docker utility 
$ sudo systemctl enable docker

#Adding the Kubernetes signing key to the nodes
$ curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add

#Adding Xenial Kubernetes repository
$ sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"

#Installing Kubeadm tool
$ sudo apt install kubeadm

#Step 2 : Kubernetes Deployment

#Disabling swap memory bertween the nodes
$ sudo swapoff -a

#Defining the master host out of the two nodes
$ sudo hostnamectl set-hostname master-node