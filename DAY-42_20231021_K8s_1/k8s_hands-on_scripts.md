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

#### STEP-1 : Provision 2 Linux Servers 

```
Pre-requisites :
1. 2 Core Processor 
2. 2 GB Ram 
3. 50 GB Hard Disk 

```

#### STEP-2 : Download, Install & Configure required softwares

```
1. Setup Hostname : k8s-controller-plane.cloudbinary.io
2. Download, Install & Configure Utility Softwares : git curl unizp tree wget
3. Install Containerization Technology : docker.io 
4. Enable Docker For Ubuntu User 
5. Change cgroup driver to systemd
6. Enable Docker Services at boot level
7. Download, & Install Kubernetes Dependencies :  apt-transport-https ca-certificates
8. Download Kubernetes GPG Signature Key: apt-key.gpg 
9. Download & Install kubelet, kubeadm and kubectl
10. Hold Auto updates on kubelet, kubeadm and kubectl
11. Restart SSM Agent on EC2 Instance
12. Attach Instance profile To EC2 Instance 
```

#### STEP-3 : Connect EC2 Instance using SSM and Validate STEP-2

#### STEP-4 : Create Kubernetes Cluster by going to k8s-controller-plane

```
Update the Host Files for 2 Servers :

vi /etc/hosts
# K8s Controller-Plane 
172.31.40.184 k8s-controller-plane.cloudbinary.io

# K8s Node-1 
172.31.34.208 k8s-node1.cloudbinary.io
```

#### Below are the validation Commands :

kubeadm version
kubectl version
kubelet --version
docker images
docker ps
ls -lrt /etc/docker/daemon.json
cat /etc/docker/daemon.json
cat /etc/apt/sources.list.d/kubernetes.list
systemctl status docker
systemctl status kubelet

#### STEP-5 : Create kubernetes Cluster by doing SSH to k8s-controller-plane.cloudbinary.io

```
sudo kubeadm init --pod-network-cidr=10.10.0.0/16 --control-plane-endpoint=k8s-controller-plane.cloudbinary.io

sudo kubeadm init --pod-network-cidr=10.10.0.0/16 --control-plane-endpoint=k8s-controller.softobiz.com

```

#### STEP-6 : To start using your cluster, you need to run the following as a regular user:

```
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

#### STEP-7 : Alternatively, if you are the root user, you can run:

  ```
  export KUBECONFIG=/etc/kubernetes/admin.conf
  ```

#### STEP-8 : You should now deploy a pod network to the cluster:

```
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml

```

#### STEP-9 : You can now join any number of control-plane nodes by copying certificate authorities

```
and service account keys on each node and then running the following as root:

  kubeadm join k8s-cp.cloudbinary.io:6443 --token decv6u.n4m1k5e5ccxbdu71 \
        --discovery-token-ca-cert-hash sha256:f38398add9699a13c62f541594c271611669c4eed62433a6e7808a0c16050983 \
        --control-plane
```


#### STEP-10 : Then you can join any number of worker nodes by running the following on each as root:

## Join Nodes To Cluster As Root User :

```
sudo kubeadm join 172.31.45.66:6443 --token l2g7jk.yx7o1hghiisoacz3 --discovery-token-ca-cert-hash sha256:efa99a385fb79b407778f32e6f47c9ec54ee2368290276cda8e2ed36308c84d2

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 172.31.23.211:6443 --token dwdznz.z7hbjpebxddqzg50 --discovery-token-ca-cert-hash sha256:7bc337165fb46ade92f95d9af968869298bc8d49adfd54e4298810e522a3d3de
```

#### STEP-11 : Validate the Cluster Info :
```
$ kubectl cluster-info

Viewing, Finding Resources :

$ kubectl get services                          # List all services in the namespace
$ kubectl get pods --all-namespaces             # List all pods in all namespaces
$ kubectl get pods -o wide                      # List all pods in the namespace, with more details
$ kubectl get rc <rc-name>                      # List a particular replication controller
$ kubectl get replicationcontroller <rc-name>   # List a particular RC

# Verbose output
$ kubectl describe nodes <node-name>
$ kubectl describe pods <pod-name>
$ kubectl describe pods/<pod-name>              # Equivalent to previous
$ kubectl describe pods <rc-name>               # Lists pods created by <rc-name> using common prefix

# Modifying and Deleting Resources :
$ kubectl label pods <pod-name> new-label=awesome                  # Add a Label
$ kubectl annotate pods <pod-name> icon-url=http://goo.gl/XXBTWq   # Add an annotation

Interacting with running Pods :
$ kubectl logs <pod-name>         # dump pod logs (stdout)
$ kubectl logs -f <pod-name>      # stream pod logs (stdout) until canceled (ctrl-c) or timeout

$ kubectl run -i --tty busybox --image=busybox -- sh      # Run pod as interactive shell
$ kubectl attach <podname> -i                             # Attach to Running Container
$ kubectl port-forward <podname> <local-and-remote-port>  # Forward port of Pod to your local machine
$ kubectl port-forward <servicename> <port>               # Forward port to service
$ kubectl exec <pod-name> -- ls /                         # Run command in existing pod (1 container case) 
$ kubectl exec <pod-name> -c <container-name> -- ls /     # Run command in existing pod (multi-container case) 
```


#### Kubectl context and configuration :
```
kubectl config view # Show Merged kubeconfig settings.

# use multiple kubeconfig files at the same time and view merged config
KUBECONFIG=~/.kube/config:~/.kube/kubconfig2

kubectl config view

# get the password for the e2e user
kubectl config view -o jsonpath='{.users[?(@.name == "e2e")].user.password}'

kubectl config view -o jsonpath='{.users[].name}'    # display the first user
kubectl config view -o jsonpath='{.users[*].name}'   # get a list of users
kubectl config get-contexts                          # display list of contexts
kubectl config current-context                       # display the current-context
kubectl config use-context my-cluster-name           # set the default context to my-cluster-name

# add a new user to your kubeconf that supports basic auth
kubectl config set-credentials kubeuser/foo.kubernetes.com --username=kubeuser --password=kubepassword

# permanently save the namespace for all subsequent kubectl commands in that context.
kubectl config set-context --current --namespace=ggckad-s2

# set a context utilizing a specific username and namespace.
kubectl config set-context gce --user=cluster-admin --namespace=foo \
  && kubectl config use-context gce

kubectl config unset users.foo                       # delete user foo

# short alias to set/show context/namespace (only works for bash and bash-compatible shells, current context to be set before using kn to set namespace) 
alias kx='f() { [ "$1" ] && kubectl config use-context $1 || kubectl config current-context ; } ; f'
alias kn='f() { [ "$1" ] && kubectl config set-context --current --namespace $1 || kubectl config view --minify | grep namespace | cut -d" " -f6 ; } ; f'

Creating objects :
kubectl apply -f ./my-manifest.yaml            # create resource(s)
kubectl apply -f ./my1.yaml -f ./my2.yaml      # create from multiple files
kubectl apply -f ./dir                         # create resource(s) in all manifest files in dir
kubectl apply -f https://git.io/vPieo          # create resource(s) from url
kubectl create deployment nginx --image=nginx  # start a single instance of nginx

# create a Job which prints "Hello World"
kubectl create job hello --image=busybox:1.28 -- echo "Hello World"

# create a CronJob that prints "Hello World" every minute
kubectl create cronjob hello --image=busybox:1.28   --schedule="*/1 * * * *" -- echo "Hello World"

kubectl explain pods                           # get the documentation for pod manifests

# Create multiple YAML objects from stdin
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: busybox-sleep
spec:
  containers:
  - name: busybox
    image: busybox:1.28
    args:
    - sleep
    - "1000000"
---
apiVersion: v1
kind: Pod
metadata:
  name: busybox-sleep-less
spec:
  containers:
  - name: busybox
    image: busybox:1.28
    args:
    - sleep
    - "1000"
EOF

# Create a secret with several keys
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: mysecret
type: Opaque
data:
  password: $(echo -n "s33msi4" | base64 -w0)
  username: $(echo -n "jane" | base64 -w0)
EOF

Viewing, finding resources :
# Get commands with basic output
kubectl get services                          # List all services in the namespace
kubectl get pods --all-namespaces             # List all pods in all namespaces
kubectl get pods -o wide                      # List all pods in the current namespace, with more details
kubectl get deployment my-dep                 # List a particular deployment
kubectl get pods                              # List all pods in the namespace
kubectl get pod my-pod -o yaml                # Get a pod's YAML

# Describe commands with verbose output
kubectl describe nodes my-node
kubectl describe pods my-pod

# List Services Sorted by Name
kubectl get services --sort-by=.metadata.name

# List pods Sorted by Restart Count
kubectl get pods --sort-by='.status.containerStatuses[0].restartCount'

# List PersistentVolumes sorted by capacity
kubectl get pv --sort-by=.spec.capacity.storage

# Get the version label of all pods with label app=cassandra
kubectl get pods --selector=app=cassandra -o \
  jsonpath='{.items[*].metadata.labels.version}'

# Retrieve the value of a key with dots, e.g. 'ca.crt'
kubectl get configmap myconfig \
  -o jsonpath='{.data.ca\.crt}'

# Get all worker nodes (use a selector to exclude results that have a label
# named 'node-role.kubernetes.io/control-plane')
kubectl get node --selector='!node-role.kubernetes.io/control-plane'

# Get all running pods in the namespace
kubectl get pods --field-selector=status.phase=Running

# Get ExternalIPs of all nodes
kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="ExternalIP")].address}'

# List Names of Pods that belong to Particular RC
# "jq" command useful for transformations that are too complex for jsonpath, it can be found at https://stedolan.github.io/jq/
sel=${$(kubectl get rc my-rc --output=json | jq -j '.spec.selector | to_entries | .[] | "\(.key)=\(.value),"')%?}
echo $(kubectl get pods --selector=$sel --output=jsonpath={.items..metadata.name})

# Show labels for all pods (or any other Kubernetes object that supports labelling)
kubectl get pods --show-labels

# Check which nodes are ready
JSONPATH='{range .items[*]}{@.metadata.name}:{range @.status.conditions[*]}{@.type}={@.status};{end}{end}' \
 && kubectl get nodes -o jsonpath="$JSONPATH" | grep "Ready=True"

# Output decoded secrets without external tools
kubectl get secret my-secret -o go-template='{{range $k,$v := .data}}{{"### "}}{{$k}}{{"\n"}}{{$v|base64decode}}{{"\n\n"}}{{end}}'

# List all Secrets currently in use by a pod
kubectl get pods -o json | jq '.items[].spec.containers[].env[]?.valueFrom.secretKeyRef.name' | grep -v null | sort | uniq

# List all containerIDs of initContainer of all pods
# Helpful when cleaning up stopped containers, while avoiding removal of initContainers.
kubectl get pods --all-namespaces -o jsonpath='{range .items[*].status.initContainerStatuses[*]}{.containerID}{"\n"}{end}' | cut -d/ -f3

# List Events sorted by timestamp
kubectl get events --sort-by=.metadata.creationTimestamp

# Compares the current state of the cluster against the state that the cluster would be in if the manifest was applied.
kubectl diff -f ./my-manifest.yaml

# Produce a period-delimited tree of all keys returned for nodes
# Helpful when locating a key within a complex nested JSON structure
kubectl get nodes -o json | jq -c 'paths|join(".")'

# Produce a period-delimited tree of all keys returned for pods, etc
kubectl get pods -o json | jq -c 'paths|join(".")'

# Produce ENV for all pods, assuming you have a default container for the pods, default namespace and the `env` command is supported.
# Helpful when running any supported command across all pods, not just `env`
for pod in $(kubectl get po --output=jsonpath={.items..metadata.name}); do echo $pod && kubectl exec -it $pod -- env; done

# Get a deployment's status subresource
kubectl get deployment nginx-deployment --subresource=status

Updating resources:

kubectl set image deployment/frontend www=image:v2               # Rolling update "www" containers of "frontend" deployment, updating the image
kubectl rollout history deployment/frontend                      # Check the history of deployments including the revision
kubectl rollout undo deployment/frontend                         # Rollback to the previous deployment
kubectl rollout undo deployment/frontend --to-revision=2         # Rollback to a specific revision
kubectl rollout status -w deployment/frontend                    # Watch rolling update status of "frontend" deployment until completion
kubectl rollout restart deployment/frontend                      # Rolling restart of the "frontend" deployment


cat pod.json | kubectl replace -f -                              # Replace a pod based on the JSON passed into stdin

# Force replace, delete and then re-create the resource. Will cause a service outage.
kubectl replace --force -f ./pod.json

# Create a service for a replicated nginx, which serves on port 80 and connects to the containers on port 8000
kubectl expose rc nginx --port=80 --target-port=8000

# Update a single-container pod's image version (tag) to v4
kubectl get pod mypod -o yaml | sed 's/\(image: myimage\):.*$/\1:v4/' | kubectl replace -f -

kubectl label pods my-pod new-label=awesome                      # Add a Label
kubectl annotate pods my-pod icon-url=http://goo.gl/XXBTWq       # Add an annotation
kubectl autoscale deployment foo --min=2 --max=10                # Auto scale a deployment "foo"

Patching resources:
# Partially update a node
kubectl patch node k8s-node-1 -p '{"spec":{"unschedulable":true}}'

# Update a container's image; spec.containers[*].name is required because it's a merge key
kubectl patch pod valid-pod -p '{"spec":{"containers":[{"name":"kubernetes-serve-hostname","image":"new image"}]}}'

# Update a container's image using a json patch with positional arrays
kubectl patch pod valid-pod --type='json' -p='[{"op": "replace", "path": "/spec/containers/0/image", "value":"new image"}]'

# Disable a deployment livenessProbe using a json patch with positional arrays
kubectl patch deployment valid-deployment  --type json   -p='[{"op": "remove", "path": "/spec/template/spec/containers/0/livenessProbe"}]'

# Add a new element to a positional array
kubectl patch sa default --type='json' -p='[{"op": "add", "path": "/secrets/1", "value": {"name": "whatever" } }]'

# Update a deployment's replicas count by patching it's scale subresource
kubectl patch deployment nginx-deployment --subresource='scale' --type='merge' -p '{"spec":{"replicas":2}}'



Scaling resources :
kubectl scale --replicas=3 rs/foo                                 # Scale a replicaset named 'foo' to 3
kubectl scale --replicas=3 -f foo.yaml                            # Scale a resource specified in "foo.yaml" to 3
kubectl scale --current-replicas=2 --replicas=3 deployment/mysql  # If the deployment named mysql's current size is 2, scale mysql to 3
kubectl scale --replicas=5 rc/foo rc/bar rc/baz                   # Scale multiple replication controllers

Deleting resources :
kubectl delete -f ./pod.json                                      # Delete a pod using the type and name specified in pod.json
kubectl delete pod unwanted --now                                 # Delete a pod with no grace period
kubectl delete pod,service baz foo                                # Delete pods and services with same names "baz" and "foo"
kubectl delete pods,services -l name=myLabel                      # Delete pods and services with label name=myLabel
kubectl -n my-ns delete pod,svc --all                             # Delete all pods and services in namespace my-ns,
# Delete all pods matching the awk pattern1 or pattern2
kubectl get pods  -n mynamespace --no-headers=true | awk '/pattern1|pattern2/{print $1}' | xargs  kubectl delete -n mynamespace pod


Editing resources :
Edit any API resource in your preferred editor.

kubectl edit svc/docker-registry                      # Edit the service named docker-registry
KUBE_EDITOR="nano" kubectl edit svc/docker-registry   # Use an alternative editor

Interacting with running Pods :
kubectl logs my-pod                                 # dump pod logs (stdout)
kubectl logs -l name=myLabel                        # dump pod logs, with label name=myLabel (stdout)
kubectl logs my-pod --previous                      # dump pod logs (stdout) for a previous instantiation of a container
kubectl logs my-pod -c my-container                 # dump pod container logs (stdout, multi-container case)
kubectl logs -l name=myLabel -c my-container        # dump pod logs, with label name=myLabel (stdout)
kubectl logs my-pod -c my-container --previous      # dump pod container logs (stdout, multi-container case) for a previous instantiation of a container
kubectl logs -f my-pod                              # stream pod logs (stdout)
kubectl logs -f my-pod -c my-container              # stream pod container logs (stdout, multi-container case)
kubectl logs -f -l name=myLabel --all-containers    # stream all pods logs with label name=myLabel (stdout)
kubectl run -i --tty busybox --image=busybox:1.28 -- sh  # Run pod as interactive shell
kubectl run nginx --image=nginx -n mynamespace      # Start a single instance of nginx pod in the namespace of mynamespace
kubectl run nginx --image=nginx                     # Run pod nginx and write its spec into a file called pod.yaml
--dry-run=client -o yaml > pod.yaml

kubectl attach my-pod -i                            # Attach to Running Container
kubectl port-forward my-pod 5000:6000               # Listen on port 5000 on the local machine and forward to port 6000 on my-pod
kubectl exec my-pod -- ls /                         # Run command in existing pod (1 container case)
kubectl exec --stdin --tty my-pod -- /bin/sh        # Interactive shell access to a running pod (1 container case)
kubectl exec my-pod -c my-container -- ls /         # Run command in existing pod (multi-container case)
kubectl top pod POD_NAME --containers               # Show metrics for a given pod and its containers
kubectl top pod POD_NAME --sort-by=cpu              # Show metrics for a given pod and sort it by 'cpu' or 'memory'


Copy files and directories to and from containers:
kubectl cp /tmp/foo_dir my-pod:/tmp/bar_dir            # Copy /tmp/foo_dir local directory to /tmp/bar_dir in a remote pod in the current namespace
kubectl cp /tmp/foo my-pod:/tmp/bar -c my-container    # Copy /tmp/foo local file to /tmp/bar in a remote pod in a specific container
kubectl cp /tmp/foo my-namespace/my-pod:/tmp/bar       # Copy /tmp/foo local file to /tmp/bar in a remote pod in namespace my-namespace
kubectl cp my-namespace/my-pod:/tmp/foo /tmp/bar       # Copy /tmp/foo from a remote pod to /tmp/bar locally

Interacting with Deployments and Services:
kubectl logs deploy/my-deployment                         # dump Pod logs for a Deployment (single-container case)
kubectl logs deploy/my-deployment -c my-container         # dump Pod logs for a Deployment (multi-container case)

kubectl port-forward svc/my-service 5000                  # listen on local port 5000 and forward to port 5000 on Service backend
kubectl port-forward svc/my-service 5000:my-service-port  # listen on local port 5000 and forward to Service target port with name <my-service-port>

kubectl port-forward deploy/my-deployment 5000:6000       # listen on local port 5000 and forward to port 6000 on a Pod created by <my-deployment>
kubectl exec deploy/my-deployment -- ls                   # run command in first Pod and first container in Deployment (single- or multi-container cases)


Interacting with Nodes and cluster:

kubectl cordon my-node                                                # Mark my-node as unschedulable
kubectl drain my-node                                                 # Drain my-node in preparation for maintenance
kubectl uncordon my-node                                              # Mark my-node as schedulable
kubectl top node my-node                                              # Show metrics for a given node
kubectl cluster-info                                                  # Display addresses of the master and services
kubectl cluster-info dump                                             # Dump current cluster state to stdout
kubectl cluster-info dump --output-directory=/path/to/cluster-state   # Dump current cluster state to /path/to/cluster-state

# If a taint with that key and effect already exists, its value is replaced as specified.
kubectl taint nodes foo dedicated=special-user:NoSchedule
```


# Hands-On K8s Cluster Setup:s

#### STEP-1 : Launch 2 EC2 Instances in AWS :

```
aws ec2 run-instances --image-id "ami-0557a15b87f6559cf" --count 1 --instance-type t2.medium --key-name "us_east_1_keys" --security-group-ids "sg-09e7a75b97f33d7f1" --subnet-id "subnet-00a07bb8fefdfcfec" --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=docker-compose},{Key=Environment,Value=dev}]'

```

#### STEP-2 : Setup K8s-cp :

```
#!/bin/bash

# Setup Hostname 
hostnamectl set-hostname "k8s-controller.cloudbinary.io"

# Configure Hostname unto hosts file 
echo "`hostname -I | awk '{ print $1}'` `hostname`" >> /etc/hosts 

# Update the Ubuntu Local Repository with Online Repository 
sudo apt update 

# Download, Install & Configure Utility Softwares 
sudo apt install git curl unzip tree wget -y 

```

#### Load the following kernel modules on all the nodes,

```
    # Disable swap & add kernel settings

    $ cat /proc/swaps

    $ top 

    $ cat /etc/fstab

    # Disalbe Swap:
    
    $ sudo swapoff -a
    
    $ sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

```

#### Load the following kernel modules on all the nodes

```
    $ sudo tee /etc/modules-load.d/containerd.conf <<EOF
    overlay
    br_netfilter
    EOF
    
    $ sudo modprobe overlay
    
    $ sudo modprobe br_netfilter

```

#### Set the following Kernel parameters for Kubernetes, run beneath tee command

```
$ sudo tee /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

```

#### Reload the above changes, run

```
sudo sysctl --system
```

#### Install containerd run time

    In this guide, we are using containerd run time for our Kubernetes cluster. 
    So, to install containerd, first install its dependencies.

    ```
    $ sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates
    ```

    - Enable docker repository
    
    ```    
    $ sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg
    
    $ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    ```

    # Now, run following apt command to install containerd

    ```
    $ sudo apt update
    $ sudo apt install -y containerd.io
    ```

    # Configure containerd so that it starts using systemd as cgroup.

    ```
    $ containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
    
    $ sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
    ```

    # Restart and enable containerd service
    
    ```
    $ sudo systemctl restart containerd
    $ sudo systemctl enable containerd
    
    ```

#### Add apt repository for Kubernetes

    ```
    # Execute following commands to add apt repository for Kubernetes

    $ curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/kubernetes-jammy.gpg
    
    $ sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"

    
    ```

#### Install Kubernetes components Kubectl, kubeadm & kubelet
    
    # Install Kubernetes components like kubectl, kubelet and Kubeadm utility on all the nodes. Run following set of commands,

    ```
    $ sudo apt update
    
    $ sudo apt install -y kubelet kubeadm kubectl
    
    $ sudo apt-mark hold kubelet kubeadm kubectl
    ```

#### Initialize Kubernetes cluster with Kubeadm command
    
    # Now, we are all set to initialize Kubernetes cluster. 
    
    # Run the following Kubeadm command from the master node only.
    
    ```
    $ sudo kubeadm init --control-plane-endpoint=k8s-controller.cloudbinary.io
    ```

```
Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

You can now join any number of control-plane nodes by copying certificate authorities
and service account keys on each node and then running the following as root:

  kubeadm join k8s-controller.cloudbinary.io:6443 --token f284ss.yc0g579n0hf43loo \
	--discovery-token-ca-cert-hash sha256:a984431484bd12be3a424242a06b6f1c7322e1b58f1911ab799396279f941cd8 \
	--control-plane 

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join k8s-controller.cloudbinary.io:6443 --token f284ss.yc0g579n0hf43loo \
	--discovery-token-ca-cert-hash sha256:a984431484bd12be3a424242a06b6f1c7322e1b58f1911ab799396279f941cd8 

```

    - Now, try to run following kubectl commands to view cluster and node status
    $ kubectl cluster-info

    - Check the nodes status from master node using kubectl command,
    $ kubectl get nodes

    - Join both the worker nodes to the cluster, command is already there is output, just copy paste on the worker nodes,

    $ kubeadm join k8s-controller.cloudbinary.io:6443 --token f284ss.yc0g579n0hf43loo \
	--discovery-token-ca-cert-hash sha256:a984431484bd12be3a424242a06b6f1c7322e1b58f1911ab799396279f941cd8 

    - Check the nodes status from master node using kubectl command,
    $ kubectl get nodes

    - As we can see nodes status is ‘NotReady’, so to make it active. We must install CNI (Container Network Interface) or network add-on plugins like Calico, Flannel and Weave-net.

    - Install Calico Pod Network Add-on
    - Run following kubectl command to install Calico network plugin from the master node,

    $ kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml

    - Verify the status of pods in kube-system namespace,
    $ kubectl get pods -n kube-system

    - Perfect, check the nodes status as well.
    $ kubectl get nodes

    Note: Great, above confirms that nodes are active node. Now, we can say that our Kubernetes cluster is functional.


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

#### Note: Update the hosts file /etc/hosts in K8s Cluster and Node-1 

# K8s Node-1
172.31.57.209 k8s-node1.cloudbinary.io

# K8s CP
172.31.95.156 k8s-controller.cloudbinary.io


#### Now Node-1 Setup

#### STEP-1 : Launch 2 EC2 Instances in AWS :

```
aws ec2 run-instances --image-id "ami-0557a15b87f6559cf" --count 1 --instance-type t2.medium --key-name "us_east_1_keys" --security-group-ids "sg-09e7a75b97f33d7f1" --subnet-id "subnet-00a07bb8fefdfcfec" --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=docker-compose},{Key=Environment,Value=dev}]'

```

#### Note: Update the hosts file /etc/hosts in K8s Cluster and Node-1 

# K8s Node-1
172.31.57.209 k8s-node1.cloudbinary.io

# K8s CP
172.31.95.156 k8s-controller.cloudbinary.io

#### STEP-2 : Setup K8s-cp :

```
#!/bin/bash

# Setup Hostname 
hostnamectl set-hostname "k8s-node1.cloudbinary.io"

# Configure Hostname unto hosts file 
echo "`hostname -I | awk '{ print $1}'` `hostname`" >> /etc/hosts 

# Update the Ubuntu Local Repository with Online Repository 
sudo apt update 

# Download, Install & Configure Utility Softwares 
sudo apt install git curl unzip tree wget -y 

```

#### Load the following kernel modules on all the nodes,

```
    # Disable swap & add kernel settings

    $ cat /proc/swaps

    $ top 

    $ cat /etc/fstab

    # Disalbe Swap:
    
    $ sudo swapoff -a
    
    $ sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

```

#### Load the following kernel modules on all the nodes

```
    $ sudo tee /etc/modules-load.d/containerd.conf <<EOF
    overlay
    br_netfilter
    EOF
    
    $ sudo modprobe overlay
    
    $ sudo modprobe br_netfilter

```

#### Set the following Kernel parameters for Kubernetes, run beneath tee command

```
$ sudo tee /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

```

#### Reload the above changes, run

```
sudo sysctl --system
```

#### Install containerd run time

    In this guide, we are using containerd run time for our Kubernetes cluster. 
    So, to install containerd, first install its dependencies.

    ```
    $ sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates
    ```

    - Enable docker repository
    
    ```    
    $ sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg
    
    $ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    ```

    # Now, run following apt command to install containerd

    ```
    $ sudo apt update
    $ sudo apt install -y containerd.io
    ```

    # Configure containerd so that it starts using systemd as cgroup.

    ```
    $ containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
    
    $ sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
    ```

    # Restart and enable containerd service
    
    ```
    $ sudo systemctl restart containerd
    $ sudo systemctl enable containerd
    
    ```

#### Add apt repository for Kubernetes

    ```
    # Execute following commands to add apt repository for Kubernetes

    $ curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/kubernetes-jammy.gpg
    
    $ sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"

    
    ```

#### Install Kubernetes components Kubectl, kubeadm & kubelet
    
    # Install Kubernetes components like kubectl, kubelet and Kubeadm utility on all the nodes. Run following set of commands,

    ```
    $ sudo apt update
    
    $ sudo apt install -y kubelet kubeadm kubectl
    
    $ sudo apt-mark hold kubelet kubeadm kubectl
    ```


#### Join Node To K8s Clusterr:
        $ kubeadm join k8s-controller.cloudbinary.io:6443 --token f284ss.yc0g579n0hf43loo \
	--discovery-token-ca-cert-hash sha256:a984431484bd12be3a424242a06b6f1c7322e1b58f1911ab799396279f941cd8 



##### 

STEP-1 :  Create deployment.yml

File Name : deployment.yml

STEP-2 : Create Service and Deploy:

File Name : nginx-service.yaml

kubectl create service nodeport nginx --tcp=80:80

kubectl apply -f deployment.yml

STEP-3 : Update the deployment with new version

File Name : deployment-update.yaml

kubectl apply -f deployment-update.yaml

STEP-4 : Scale the deployment

File Name : deployment-scale.yaml

kubectl apply -f  deployment-scale.yaml 

STEP-5 : Deleting a deployment 

kubectl delete deployment nginx-deployment


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

#### Create Service 

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

#### Apply the Deployment and Service :

    kubectl create service nodeport nginx --tcp=80:80

    kubectl apply -f deployment.yml

    kubectl describe deployment nginx-deployment

    kubectl get svc

    kubectl get nodes

    kubectl get pods

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
