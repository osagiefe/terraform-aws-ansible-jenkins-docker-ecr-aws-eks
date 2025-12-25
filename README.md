## argocd-aws-eksapp-deployment
Deploying applications to AWS EKS using ArgoCD follows the GitOps principle where a Git repository serves as the single source of truth for the desired application state. ArgoCD, running within your EKS cluster, automatically detects and synchronizes changes from the repository to the cluster. 

## project perequisite:
- Install locally AWS Cli
- Create an IAM user with administrative access
- AWS configure
- Authenticate yourself locally within AWS cloud and verify
- Install Kubectl 
- Kubernetes manifest files

# Tools stack:
- AWS eks
- AWS services
- Jenkins
- Argocd software
- eksctl
- nodejs

# project workflow
ArgoCD is a powerful GitOps continuous delivery tool for Kubernetes, and in this project, I will cover the following steps:

 - Use Terraform to build AWS EC2 servers
 - Installation of Ansible
 - Configure Ansible controller 
-  Install Jenkins Server
 - Build a Jenkins pipline to build and push images to      Dockerhub
 - Build AWS EKS Cluster and deploy app
 - Application deployment using argocd (Github as source) 
 - Roleback to different working version using argocd  versioning 
 - Cleanup of environment
 - Challenges and learned

## Update server after Ansible install
<img width="1857" height="488" alt="Image" src="https://github.com/user-attachments/assets/19a49106-74bd-4265-9324-0e7f36d126fe" />

1. Create an EKS Cluster using this command:

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


# Get EKS Cluster service
eksctl get cluster --name eks-cluster-223 --region us-east-1

<img width="1855" height="698" alt="Image" src="https://github.com/user-attachments/assets/76b1c8ba-79bf-4d9e-bed4-c847ad4158c9" />
 
 # Update eks kubeconfig once k8s cluster is installed successfully
aws eks update-kubeconfig --name eks-cluster-223 --region us-east-1


# create argocd namespace
kubectl create namespace argocd

# install argocd from argocd repository 

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml


# kubectl get pods -n argocd
kubectl get pods -n argocd

<img width="957" height="459" alt="Image" src="https://github.com/user-attachments/assets/d7487a3b-34a5-4ff3-8acb-d6846dd33f11" />

# then get argocd service
kubectl get svc -n argocd

<img width="1855" height="588" alt="Image" src="https://github.com/user-attachments/assets/a3a3d88d-f6f4-4ca0-8c8f-6982860c4a38" />

# To Get argocd from the webbrowser edit the service of LoadBalancer

kubectl edit svc argocd-server -n argocd

# If the above command fails, then below is the work around of the above command. Change the clusterIP to LoadBalancer:
kubectl -n argocd patch svc argocd-server -p '{"spec": {"type": "LoadBalancer"}}'

# Get the application running service

kubectl get svc -n argocd


# copy the loadbalancer endpoints and take to the browser
a623d2802046844268ec72d013327516-1000438710.us-east-1.elb.amazonaws.com

# on the browser

# argocd GUI
Here I simply login to the Argocd portal

# username is 
admin
# Get argocd password

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

# login to the argocd

<img width="1860" height="761" alt="Image" src="https://github.com/user-attachments/assets/6631dfcd-0034-4b3f-83f1-ce894fb1a1e5" />


## Configure Argocd to sync with Gitup as the single source of truth

<img width="1844" height="908" alt="Image" src="https://github.com/user-attachments/assets/ae367631-2c7f-4908-99e9-1b106f26d50f" />



## Now lets check the terminal at the default namespace

kubectl get pods -n argocd


<img width="1127" height="319" alt="Image" src="https://github.com/user-attachments/assets/b5819c17-037e-4804-ab25-62da5e5bed55" />


# lets also checked the service object
<img width="1211" height="517" alt="Image" src="https://github.com/user-attachments/assets/a1b83fdf-9a69-4b11-8615-00ba2da9c2ac" />

now access the pyappservice and put into the browser from the load balancer


# view on the browser

<img width="1450" height="924" alt="Image" src="https://github.com/user-attachments/assets/909f0b0a-6271-4cf9-9548-e9e8fb3c9a28" />


# now after changing the version in Github, then refresh argocd will detect the changes and publish the appropriate version
<img width="1500" height="915" alt="Image" src="https://github.com/user-attachments/assets/541c33f6-3ee4-474b-84fb-cf59756a55dc" />


# to delete cluster

eksctl delete cluster --name eks-cluster-223

# To destroy infractructure in AWS within the infrastructure folder
terraform destroy --auto-approve


## Lessons/Challenges learned
In this project I learnt how to install ArgoCD on Kubernetes, deploy an application, and rollback to a previous version using the Web UI. The command "kubectl edit svc argocd-server -n argocd" to edit the application svc failed to launch the editor (vi) to enable my changing the cluster IP to Loadblancer. I sort help from ChatGPT to resolve the issue. Moreover, AWS EKS Cluster will cannot be  easily deleted, because deletion protection was automatically activated during creation. Once the protection is deactivated the cluster can be fully cleaned up without incurring charges


