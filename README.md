# AWS EKS Infrastructure with Terraform

## Overview

This project provisions AWS infrastructure for an Amazon Elastic Kubernetes Service (EKS) cluster using Terraform. It demonstrates Infrastructure as Code (IaC), modular Terraform design, AWS networking, managed Kubernetes, and remote state management.

## Technology Stack

- **AWS:** Cloud infrastructure
- **Terraform:** Infrastructure provisioning and automation
- **Amazon EKS:** Managed Kubernetes cluster
- **Amazon VPC:** Networking and subnet configuration
- **Amazon EC2:** Kubernetes worker nodes
- **AWS IAM:** Identity and access management
- **Amazon S3:** Remote Terraform state storage
- **Kubernetes:** Container orchestration

## Project Structure

```text
terraform-eks-devops/
├── Backend/
├── modules/
│   ├── eks/
│   └── vpn/
├── main.tf
├── variables.tf
├── outputs.tf
├── .terraform.lock.hcl
└── README.md
```

## Infrastructure Components

### Amazon VPC

- Custom VPC with CIDR `10.0.0.0/16`
- Public and private subnets
- Two Availability Zones
- NAT Gateway and routing configuration

### Amazon EKS

- Cluster name: `eks-demo`
- AWS Region: `us-west-2`
- Kubernetes version configured as `1.33`
- Managed node group: `eks_nodes`
- Worker instance type: `t3.small`
- Capacity type: On-Demand
- Desired worker count: 2
- Minimum workers: 1
- Maximum workers: 3

Confirm Kubernetes version and instance-type availability in your AWS account before deploying.

### Terraform State Management

Terraform uses an Amazon S3 backend for remote state storage, with encryption and S3 lockfile-based state locking. The S3 bucket must exist before initializing the root configuration.

## Prerequisites

- AWS account with the required infrastructure permissions
- AWS CLI
- Terraform 1.10 or later
- kubectl

Verify AWS authentication:

```bash
aws sts get-caller-identity
```

## Configuration

Create a local `terraform.tfvars` file containing the environment-specific values required by `variables.tf`.

Do not commit credentials, secrets, Terraform state files, or environment-specific sensitive configuration.

## Infrastructure Workflow

Initialize Terraform:

```bash
terraform init
```

Format the configuration:

```bash
terraform fmt -recursive
```

Validate the configuration:

```bash
terraform validate
```

Review planned infrastructure changes:

```bash
terraform plan
```

Apply the reviewed configuration:

```bash
terraform apply
```

## Connect to the EKS Cluster

Configure kubectl:

```bash
aws eks update-kubeconfig --region us-west-2 --name eks-demo
```

Verify cluster connectivity:

```bash
kubectl cluster-info
```

Check worker nodes:

```bash
kubectl get nodes -o wide
```

Check Kubernetes pods:

```bash
kubectl get pods -A
```

## Terraform Outputs

Display configured outputs:

```bash
terraform output
```

Expected outputs include the cluster name, cluster endpoint, and VPC ID.

## Security and Cost Considerations

- Keep AWS credentials and private keys out of source control.
- Exclude `terraform.tfvars`, Terraform state files, and saved plan files from Git.
- Apply least-privilege IAM permissions.
- Protect the S3 state bucket with appropriate access controls and encryption.
- AWS charges may apply to the EKS control plane, EC2 instances, NAT Gateways, public IPv4 addresses, and other resources.
- Review costs before deploying and remove infrastructure when it is no longer needed.

## Project Purpose

This project demonstrates practical skills in Terraform, AWS infrastructure provisioning, VPC networking, Amazon EKS, IAM, remote state management, and Kubernetes cluster administration.

## Disclaimer

This project is intended for learning and demonstration. Review the infrastructure configuration, permissions, service compatibility, and costs before using it in production.
