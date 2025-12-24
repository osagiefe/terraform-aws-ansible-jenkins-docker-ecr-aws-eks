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
- Argocd software
- eksctl
- nodejs

# project workflow
ArgoCD is a powerful GitOps continuous delivery tool for Kubernetes, and in this project, I will cover the following steps:

 - Installation of argocd
 - Application deployment using argocd
 - Roleback to different working version using argocd
 - Cleanup of environment
 - Challenges and learned


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

# Get argocd from the webbrowser by edit the service of LoadBalancer

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




## Now lets check the terminal at the default namespace

kubectl get pods -n argocd


NAME                     READY   STATUS    RESTARTS   AGE
pyapp-7ccc494bbd-9fzv5   1/1     Running   0          16m
pyapp-7ccc494bbd-llfj6   1/1     Running   0          16m
pyapp-7ccc494bbd-rc7xg   1/1     Running   0          16m


# lets also checked the service object
kubectl get svc -n argocd

kubectl get svc
NAME            TYPE           CLUSTER-IP      EXTERNAL-IP                                                               PORT(S)        AGE
kubernetes      ClusterIP      10.100.0.1      <none>                                                                    443/TCP        82m
pyapp-service   LoadBalancer   10.100.168.29   a6fbf8f936c0d4999b52db71cd07bec0-1865929378.eu-west-2.elb.amazonaws.com   80:31051/TCP   18m

now access the pyappservice and put into the browser from the load balancer


# view on the browser


<img width="2446" height="1386" alt="Image" src="https://github.com/user-attachments/assets/f7f4a439-60f6-4d4f-92b8-d308ef04af33" />




# now after we refresh argocd it will detect the changes

# now run 
kubectl get pods


# to delete cluster

eksctl delete cluster --name eks-cluster-223


## Lessons/Challenges learned
In this project I learnt how to install ArgoCD on Kubernetes, deploy an application, and rollback to a previous version using the Web UI. The command "kubectl edit svc argocd-server -n argocd" to edit the application svc failed to launch the editor (vi) to enable my changing the cluster IP to Loadblancer. I sort help from ChatGPT to resolve the issue. 


