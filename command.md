# Basic files needed: 
backend.tf, .gitignore, vpc.tf, main.tf, security-group.tf, provider.tf, userdata.sh
# Check terraform version
terraform -version
==========================================
# Terraform Commands

==========================================
# To initialize terraform
terraform init
# To format terraform
terraform fmt
# Validate terraform
terraform validate
# To see what terraform is about to build
terraform plan
# To apply interractive approval of resource provising
terraform apply
# To auto approve resource provising without 
terraform apply --auto-approve
# To destroy infractructure in AWS
terraform destroy --auto-approve

- AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip

# AWS Configure (supply your credentials)
aws configure 
=======================================
# Verify login context
aws sts get-caller-identity
=======================================

# Install Kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

kubectl version --client
====================================

# check kubectl version
$kubectl version
$kubectl version --client

## install eksctl

curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

sudo mv /tmp/eksctl /usr/local/bin

eksctl version
====================================
# check eksctl version
eksctl version

# Create EKS cluster
  eksctl create cluster --name eks-cluster-110 --node-type t2.medium --nodes 2 --nodes-min 2 --nodes-max 3 --region us-east-1

# Another command to creating the eks cluster
  eksctl create cluster \
  --name eks-cluster-223 \
  --version 1.29 \
  --region us-east-1 \
  --nodegroup-name ng-1 \
  --node-type t3.medium \
  --nodes 2 \
  --nodes-min 1 \
  --nodes-max 3

  # Update eks kubeconfig once k8s cluster is installed successfully
aws eks update-kubeconfig --name eks-cluster-223 --region us-east-1
  
  # Get EKS Cluster service
eksctl get cluster --name eks-cluster-223 --region us-east-1

# create argocd namespace
kubectl create namespace argocd

# install argocd from argocd repository 

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# kubectl get pods -n argocd
kubectl get pods -n argocd

# Get argocd on the webbrowser by editing the service of LoadBalancer

kubectl edit svc argocd-server -n argocd

# If the above command fails, then below is the work around of the above command. Change the clusterIP to LoadBalancer:
kubectl -n argocd patch svc argocd-server -p '{"spec": {"type": "LoadBalancer"}}'

# Get the application running service
kubectl get svc -n argocd

# copy the loadbalancer endpoints and take to the browser
a623d2802046844268ec72d013327516-1000438710.us-east-1.elb.amazonaws.com

# username is 
admin
# Get argocd password

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

# login to the argocd portal

## Now lets check the terminal at the default namespace

kubectl get pods -n argocd

# lets also checked the service object
now access the pyappservice and put into the browser from the load balancer




