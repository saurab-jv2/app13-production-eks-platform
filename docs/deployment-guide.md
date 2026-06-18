# Deployment Guide

## Overview

This guide describes the deployment process for the App13 Production EKS Platform.

The deployment consists of three major phases:

1. Infrastructure Provisioning
2. Platform Services Installation
3. Application Deployment

---

## Prerequisites

Required tools:

* AWS CLI
* Terraform
* kubectl
* Helm
* Git

Verify installations:

```bash
aws --version
terraform --version
kubectl version --client
helm version
git --version
```

---

## Phase 1: Infrastructure Provisioning

### Configure AWS Credentials

Verify AWS access:

```bash
aws sts get-caller-identity
```

---

### Initialize Terraform Backend

Navigate to the environment directory:

```bash
cd terraform/environments/dev
```

Initialize Terraform:

```bash
terraform init
```

---

### Review Infrastructure Changes

```bash
terraform plan
```

---

### Provision Infrastructure

```bash
terraform apply
```

Infrastructure created:

* VPC
* Public Subnets
* Private Subnets
* NAT Gateway
* IAM Resources
* Amazon ECR
* Amazon EKS
* Node Groups

---

## Phase 2: Configure Cluster Access

Retrieve cluster credentials:

```bash
aws eks update-kubeconfig \
  --region ap-south-1 \
  --name <cluster-name>
```

Verify connectivity:

```bash
kubectl get nodes
```

Expected result:

```text
Worker nodes in Ready state
```

---

## Phase 3: Platform Services Installation

Trigger the GitHub Actions workflow:

```text
platform.yaml
```

This workflow installs:

* Ingress NGINX
* kube-prometheus-stack
* cert-manager
* Grafana credentials

Verify installations:

```bash
helm list -A
```

Verify namespaces:

```bash
kubectl get ns
```

Expected namespaces:

```text
ingress-nginx
monitoring
cert-manager
dev
```

---

## Phase 4: Application Deployment

Push application changes to the main branch.

GitHub Actions automatically triggers:

```text
ci.yaml
cd.yaml
```

Deployment process:

1. Build Docker image
2. Push image to Amazon ECR
3. Configure kubectl
4. Execute Helm deployment
5. Update Kubernetes workloads

---

## Verify Application Deployment

Check pods:

```bash
kubectl get pods -n dev
```

Check services:

```bash
kubectl get svc -n dev
```

Check ingress:

```bash
kubectl get ingress -n dev
```

Verify rollout:

```bash
kubectl rollout status deployment/nginx -n dev
```

---

## Verify Monitoring Stack

Check monitoring components:

```bash
kubectl get pods -n monitoring
```

Check Prometheus:

```bash
kubectl get svc -n monitoring
```

Check Grafana:

```bash
kubectl get svc -n monitoring
```

---

## Verify cert-manager

Check cert-manager pods:

```bash
kubectl get pods -n cert-manager
```

Check issuers:

```bash
kubectl get clusterissuer
```

Check certificates:

```bash
kubectl get certificates -A
```

---

## Validation Checklist

Infrastructure:

* EKS cluster available
* Worker nodes ready
* ECR repository available

Platform:

* Ingress NGINX running
* Prometheus running
* Grafana running
* cert-manager running

Application:

* Pods healthy
* Service available
* Ingress available
* Application accessible

---

## Cleanup

Destroy infrastructure:

```bash
cd terraform/environments/dev

terraform destroy
```

Verify removal of AWS resources before closing the deployment.

```
```
