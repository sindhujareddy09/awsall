#### 

```
K8s Cluster :
    - Deployment
    - Service Deployment
    - Replication
    - Cleanup

Kubernetes :
    - k8s-control-plane ---> Cluster 
    - node1
    - node2
    - node3 

Application : k8s Cluster ---> Nodes i.e. Node1 ---> POD ---> Container i.e. Nginx

```
#### Provision 2 Linux Servers
```
Pre-requisites :
1. 2 Core Processor 
2. 2 GB Ram 
3. 8 GB Hard Disk

```

#### Create TF Code 

#### EC2 Instance Of Ubuntu for k8scp
```
# Versions
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Providers
provider "aws" {
  region  = "ap-south-1"
  profile = "default"
}


# Resource - aws - ec2 
resource "aws_instance" "k8scp" {
  ami                    = "ami-0f5ee92e2d63afc18"
  instance_type          = "t2.medium"
  key_name               = "mumbai_keys"
  subnet_id              = "subnet-0f958d0a25a066abd"
  vpc_security_group_ids = ["sg-0d0e398b5436dda47"]
  iam_instance_profile   = "8amSSMEC2"
  user_data              = file("/Users/ck/repos/project_efs/k8s/k8s-cp.sh")
  tags = {
    Name        = "k8scp"
    Environment = "Dev"
    ProjectName = "Cloud Binary"
    ProjectID   = "2023"
    CreatedBy   = "IaC Terraform"
  }
}

resource "aws_instance" "k8snode1" {
  ami                    = "ami-0f5ee92e2d63afc18"
  instance_type          = "t2.medium"
  key_name               = "mumbai_keys"
  subnet_id              = "subnet-0f958d0a25a066abd"
  vpc_security_group_ids = ["sg-0d0e398b5436dda47"]
  iam_instance_profile   = "8amSSMEC2"
  user_data              = file("/Users/ck/repos/project_efs/k8s/k8s-node1.sh")

  #user_data = <<-EOF
  #!/bin/bash
  #echo "Welcome to AWS" > /tmp/ansible.txt
  #EOF

  tags = {
    Name        = "k8snode1"
    Environment = "Dev"
    ProjectName = "Cloud Binary"
    ProjectID   = "2023"
    CreatedBy   = "IaC Terraform"
  }
}
```

```
#!/bin/bash

hostnamectl set-hostname "k8s-cp.cloudbinary.io"
echo "`hostname -I | awk '{ print $1}'` `hostname`" >> /etc/hosts 
sudo apt-get update 
sudo apt-get install git curl unzip tree wget -y 

# Load the following kernel modules on all the nodes
# Disable swap & add kernel settings

sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Load the following kernel modules on all the nodes
sudo tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# Set the following Kernel parameters for Kubernetes, run beneath tee command

sudo tee /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

# Reload the above changes, run
sudo sysctl --system

# Install containerd run time
sudo apt-get install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates

# Enable docker repository
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Now, run following apt command to install containerd
sudo apt-get update
sudo apt-get install -y containerd.io

# Configure containerd so that it starts using systemd as cgroup.
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml

# Restart and enable containerd service
sudo systemctl restart containerd
sudo systemctl enable containerd

# Add apt repository for Kubernetes
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/kubernetes-jammy.gpg
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"

# Install Kubernetes components Kubectl, kubeadm & kubelet
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# kubelet --version  Kubernetes v1.28.0 kubeadm version kubectl version

export KUBECONFIG=/etc/kubernetes/admin.conf

# Initialize Kubernetes cluster with Kubeadm command
su - ubuntu
id
pwd
cd
sudo kubeadm init --control-plane-endpoint=k8s-cp.cloudbinary.io >> /home/ubuntu/k8s-cluster.output

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install Calico Pod Network Add-on
# Run following kubectl command to install Calico network plugin from the master node,
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml

# kubectl cluster-info
```

#### EC2 Instance Of Ubuntu for k8snode1

```
# Versions
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Providers
provider "aws" {
  region  = "ap-south-1"
  profile = "default"
}

resource "aws_instance" "k8snode1" {
  ami                    = "ami-0f5ee92e2d63afc18"
  instance_type          = "t2.medium"
  key_name               = "mumbai_keys"
  subnet_id              = "subnet-0f958d0a25a066abd"
  vpc_security_group_ids = ["sg-0d0e398b5436dda47"]
  iam_instance_profile   = "8amSSMEC2"
  user_data              = file("/Users/ck/repos/project_efs/k8s/k8s-node1.sh")

  #user_data = <<-EOF
  #!/bin/bash
  #echo "Welcome to AWS" > /tmp/ansible.txt
  #EOF

  tags = {
    Name        = "k8snode1"
    Environment = "Dev"
    ProjectName = "Cloud Binary"
    ProjectID   = "2023"
    CreatedBy   = "IaC Terraform"
  }
}
```

```
#!/bin/bash

hostnamectl set-hostname "k8s-node1.cloudbinary.io"
echo "`hostname -I | awk '{ print $1}'` `hostname`" >> /etc/hosts 
sudo apt-get update 
sudo apt-get install git curl unzip tree wget -y 

# Load the following kernel modules on all the nodes
# Disable swap & add kernel settings

sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Load the following kernel modules on all the nodes
sudo tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# Set the following Kernel parameters for Kubernetes, run beneath tee command

sudo tee /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

# Reload the above changes, run
sudo sysctl --system

# Install containerd run time
sudo apt-get install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates

# Enable docker repository
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Now, run following apt command to install containerd
sudo apt-get update
sudo apt-get install -y containerd.io

# Configure containerd so that it starts using systemd as cgroup.
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml

# Restart and enable containerd service
sudo systemctl restart containerd
sudo systemctl enable containerd

# Add apt repository for Kubernetes
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/kubernetes-jammy.gpg
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"

# Install Kubernetes components Kubectl, kubeadm & kubelet
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

```

#### Join Node To k8scp

```
Then you can join any number of worker nodes by running the following on each as root:

kubeadm join k8s-controller.cloudbinary.io:6443 --token f284ss.yc0g579n0hf43loo \
	--discovery-token-ca-cert-hash sha256:a984431484bd12be3a424242a06b6f1c7322e1b58f1911ab799396279f941cd8

```

#### Kubernetes Commands 

```
kubectl cluster-info

kubectl get nodes

# Get commands with basic output
kubectl get services                          # List all services in the namespace
kubectl get pods --all-namespaces             # List all pods in all namespaces
kubectl get pods -o wide                      # List all pods in the current namespace, with more details
kubectl get deployment my-dep                 # List a particular deployment
kubectl get pods                              # List all pods in the namespace
kubectl get pod my-pod -o yaml                # Get a pod's YAML
```

#### Test Kubernetes Installation
```
    - To test Kubernetes installation, let’s try to deploy nginx based application and try to access it.
    $ kubectl create deployment nginx-app --image=nginx --replicas=2

    - Check the status of nginx-app deployment
    $ kubectl get deployment nginx-app

    - Expose the deployment as NodePort,
    $ kubectl expose deployment nginx-app --type=NodePort --port=80

    - Run following commands to view service status

    $ kubectl get svc nginx-app
    
    $ kubectl describe svc nginx-app

    - Use following command to access nginx based application,

    $ curl http://<woker-node-ip-addres>:31246

```

#### kubectl commands 
```
kubectl get pods -n kube-system

kubectl get pods --show-labels

kubectl get rs

kubectl scale --current-replicas=2 --replicas=3 deployment/nginx-app

kubectl logs -f nginx-app-5777b5f95-7rp52

kubectl exec nginx-app-5777b5f95-7rp52 -- ls /
```

#### Deploy a an artifact 

```
STEP-1 :  Create deployment.yml

File Name : deployment.yml

STEP-2 : Create Service and Deploy:

File Name : nginx-service.yaml

$ kubectl create service nodeport nginx --tcp=80:80

$ kubectl apply -f deployment.yml

STEP-3 : Update the deployment with new version

File Name : deployment-update.yaml

$ kubectl apply -f deployment-update.yaml

STEP-4 : Scale the deployment

File Name : deployment-scale.yaml

$ kubectl apply -f  deployment-scale.yaml

STEP-5 : Deleting a deployment

$ kubectl delete deployment nginx-deployment
```

#### File Name : deployment.yml

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  selector:
    matchLabels:
      app: nginx
  replicas: 2 # tells deployment to run 2 pods matching the template
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
```

#### File Name : nginx-service.yaml

```
---
apiVersion: v1
kind: Service
metadata:
  name: nginx
  namespace: default
  labels:
    app: nginx
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-type: "nlb"
spec:
  externalTrafficPolicy: Local
  ports:
    - name: http 
      port: 80
      protocol: TCP
      targetPort: 80
  selector:
    app: nginx
  type: LoadBalancer

...

```

#### Apply the Deployment and Service

```
kubectl create service nodeport nginx --tcp=80:80

kubectl apply -f deployment.yml

kubectl describe deployment nginx-deployment

kubectl get svc

kubectl get nodes

kubectl get pods
```

#### Update your deployment

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  selector:
    matchLabels:
      app: nginx
  replicas: 2
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.16.1 # Update the version of nginx from 1.14.2 to 1.16.1
        ports:
        - containerPort: 80
```

#### Scale Up / Down the deployment

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  selector:
    matchLabels:
      app: nginx
  replicas: 4 # Update the replicas from 2 to 4
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
```
