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

#Disabling swap memory between the nodes
$ sudo swapoff -a

#Defining the master host out of the two nodes
$ sudo hostnamectl set-hostname master-node

#Defining the slave host out of the two nodes
$ hostnamectl set-hostname slave-node

#Step 3 : Initialize Kubernetes on the master node

#Initializing master node
$ sudo kubeadm init --pod-network-cidr=10.244.0.0/16

#Creating a directory
$ mkdir -p $HOME/.kube

#Moving kubernetes file to that specific directory
$ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
$ sudo chown $(id -u):$(id -g) $HOME/.kube/config

#Joining clusters from either of the nodes
$ kubeadm join 192.168.0.29:6443 --token n4j536.n0jg69abrx4fuudl \ --discovery-token-ca-cert-hash sha256:b9d5eb0d9e59cd03a22c0385ad0c3a43446fbe8113a57c7a31e73c22c4f25b20
