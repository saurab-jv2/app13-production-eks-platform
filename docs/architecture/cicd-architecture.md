# CI/CD Architecture

## Overview

This document describes the GitHub Actions workflows used by the App13 Production EKS Platform.

The platform uses GitHub Actions and GitHub OIDC authentication to automate container image delivery, Kubernetes application deployment, and cluster service installation.

The repository contains three workflows:

* ci.yaml
* cd.yaml
* platform.yaml

## Workflow Architecture

```mermaid
graph TD

    DEV[Developer]

    DEV -->|Push To Main| GITHUB[GitHub Repository]

    GITHUB --> CI[ci.yaml]

    GITHUB --> CD[cd.yaml]

    MANUAL[Manual Trigger]
        --> PLATFORM[platform.yaml]

    subgraph CI Workflow

        CI --> OIDC1[GitHub OIDC]

        OIDC1 --> IAM1[AWS IAM Role]

        IAM1 --> BUILD1[Build Docker Image]

        BUILD1 --> ECR1[Push Image To Amazon ECR]

    end

    subgraph CD Workflow

        CD --> OIDC2[GitHub OIDC]

        OIDC2 --> IAM2[AWS IAM Role]

        IAM2 --> BUILD2[Build Docker Image]

        BUILD2 --> ECR2[Push Image To Amazon ECR]

        ECR2 --> KUBECTL[Configure kubectl]

        KUBECTL --> HELM[Helm Upgrade]

        HELM --> EKS[Amazon EKS]

        EKS --> PODS[Application Pods]

    end

    subgraph Platform Workflow

        PLATFORM --> OIDC3[GitHub OIDC]

        OIDC3 --> IAM3[AWS IAM Role]

        IAM3 --> EKS2[Amazon EKS]

        EKS2 --> INGRESS[Ingress NGINX]

        EKS2 --> PROM[kube-prometheus-stack]

        EKS2 --> CERT[cert-manager]

    end
```

---

## Workflow Responsibilities

### ci.yaml

Continuous Integration workflow triggered on pushes to the main branch.

Responsibilities:

* Authenticate to AWS using GitHub OIDC
* Login to Amazon ECR
* Build application Docker image
* Push versioned image to Amazon ECR
* Push latest image to Amazon ECR

---

### cd.yaml

Continuous Deployment workflow triggered on pushes to the main branch.

Responsibilities:

* Authenticate to AWS using GitHub OIDC
* Login to Amazon ECR
* Build application Docker image
* Push image to Amazon ECR
* Configure kubectl access
* Connect to Amazon EKS
* Deploy application using Helm

---

### platform.yaml

Platform services installation workflow triggered manually.

Responsibilities:

* Authenticate to AWS using GitHub OIDC
* Configure kubectl access
* Verify EKS connectivity
* Install Ingress NGINX
* Install kube-prometheus-stack
* Create Grafana administrator credentials
* Install cert-manager
* Verify platform components

---

## Authentication Architecture

```mermaid
graph LR

    GHA[GitHub Actions]

    GHA --> OIDC[GitHub OIDC]

    OIDC --> IAM[AWS IAM Role]

    IAM --> AWS[AWS Account]
```

GitHub Actions authenticates to AWS using OpenID Connect (OIDC).

Benefits:

* No long-lived AWS access keys
* Short-lived credentials
* Improved security
* Centralized IAM management

---

## Application Deployment Flow

```mermaid
graph LR

    CODE[Application Source Code]

    CODE --> BUILD[Docker Build]

    BUILD --> ECR[Amazon ECR]

    ECR --> HELM[Helm Upgrade]

    HELM --> EKS[Amazon EKS]

    EKS --> PODS[Application Pods]
```

---

## Platform Services Installation Flow

```mermaid
graph LR

    PLATFORM[platform.yaml]

    PLATFORM --> EKS[Amazon EKS]

    EKS --> INGRESS[Ingress NGINX]

    EKS --> MONITORING[kube-prometheus-stack]

    EKS --> CERT[cert-manager]
```

---

## Core Components

### GitHub Actions

Executes automation workflows.

### GitHub OIDC

Provides secure AWS authentication.

### AWS IAM Role

Allows GitHub Actions to interact with AWS resources.

### Amazon ECR

Stores application container images.

### Helm

Deploys and upgrades Kubernetes workloads.

### Amazon EKS

Hosts application and platform services.

### Ingress NGINX

Provides ingress traffic routing.

### kube-prometheus-stack

Provides monitoring and observability capabilities.

### cert-manager

Provides certificate lifecycle management.

---

## Benefits

* Automated container image delivery
* Automated Kubernetes deployments
* Secure AWS authentication using OIDC
* Repeatable platform installation
* Version-controlled deployment workflows
* Consistent Helm-based application delivery

```
```
