# Setup Cluster ClickOps

## Step 1 Configure Cluster

Cluster Configuration
  - Name
  - K8 Version
  - Create Service Roles (DELETE so people can see how to make it)
      https://docs.aws.amazon.com/eks/latest/userguide/service_IAM_role.html

  Cluster Access
  - EKS API and ConfigMap

  Secrets Encryption
  - Keep Off
G
  ## Step 2 Specify Networking

  - VPC (Choose Defaul)
- Choose 3 Subnets
- Security Group (Choose Default???)
- Choose Cluster IP Address FAmily: Ipv4

Cluster Endpoint Access
- Public and Private

Control Plane Logging
Off for all

Amazon EKS Add-Ons
- CoreDNS
-Kube Proxy


## Install KubeCTL 

https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/

```sh
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl
```

## Install EKSCTL

https://eksctl.io/installation/


```sh
curl -sLO "https://github.com/eksctl-io/eksctl/releases/download/v0.175.0/eksctl_Linux_amd64.tar.gz"
tar -xzf eksctl_Linux_amd64.tar.gz -C /tmp && rm eksctl_Linux_amd64.tar.gz

sudo mv /tmp/eksctl /usr/local/bin
rm eksctl_Linux_amd64.tar.gz
```
## Install Helm

```sh
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
rm get_helm
```

## Create IAM Role use EKS CTL

> Remeber to add IAM Access for the role which is connecting. I use aws-examples in my CDE and its not the same role I use when I created the cluster via clickops.

## Create Node Group and Nodes

- Name MyNodeGroup
- Node IAM ROle

https://docs.aws.amazon.com/eks/latest/userguide/create-node-role.html

```sh
cat >node-role-trust-relationship.json <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
```

aws iam create-role \
  --role-name AmazonEKSNodeRole \
  --assume-role-policy-document file://"node-role-trust-relationship.json"
aws iam attach-role-policy \
  --policy-arn arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy \
  --role-name AmazonEKSNodeRole
aws iam attach-role-policy \
  --policy-arn arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly \
  --role-name AmazonEKSNodeRole
aws iam attach-role-policy \
  --policy-arn arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy \
  --role-name AmazonEKSNodeRole

- Launch Template (Skip)
- K8 Labels and Taints (Skip)

Min 1
Max 2
Desired 1

## Ingress with Application Load Balancer via AWS Load Balancer Controller

https://docs.aws.amazon.com/eks/latest/userguide/alb-ingress.html

> Read and do all requirements!!!

https://docs.aws.amazon.com/eks/latest/userguide/lbc-helm.html

## Create OCID using EKSCTL

### Check if you already have an OCID Provider for your Cluster
```sh
oidc_id=$(aws eks describe-cluster --name MyEKSCluster --query "cluster.identity.oidc.issuer" --output text | cut -d '/' -f 5)
echo $oidc_id
aws iam list-open-id-connect-providers | grep $oidc_id | cut -d "/" -f4
```

### Create One

eksctl utils associate-iam-oidc-provider --cluster MyEKSCluster --approve

## Create IAM Policy

```sh
curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.7.1/docs/install/iam_policy.json
aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam_policy.json
```


```sh
eksctl create iamserviceaccount \
--cluster=MyEKSCluster \
--namespace=kube-system \
--name=aws-load-balancer-controller \
--role-name AmazonEKSLoadBalancerControllerRole \
--attach-policy-arn=arn:aws:iam::982383527471:policy/AWSLoadBalancerControllerIAMPolicy \
--approve
```

Set Context for cluster
```sh
aws eks update-kubeconfig --name MyEKSCluster --region ca-central-1
```

## Install Load Balancer



```sh
helm repo add eks https://aws.github.io/eks-charts
helm repo update eks
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
-n kube-system \
--set clusterName=MyEKSCluster \
--set serviceAccount.create=false \
--set serviceAccount.name=aws-load-balancer-controller 
kubectl get deployment -n kube-system aws-load-balancer-controller

```