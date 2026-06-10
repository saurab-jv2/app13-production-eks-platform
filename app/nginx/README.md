# Nginx Demo App (CI/CD Workload)

## Overview
This is a minimal Nginx-based application used as a deployment target for the EKS CI/CD pipeline project.

It is NOT a production application. It is a controlled workload used to validate:
- Docker build pipeline
- ECR image push
- Kubernetes deployment via Helm
- CI/CD automation flow using GitHub Actions

---

## Purpose
- Validate end-to-end CI/CD pipeline
- Demonstrate containerization workflow
- Test Kubernetes deployment automation on EKS

---

## Structure
- Dockerfile: Builds custom Nginx image
- index.html: Static content served by Nginx
- .dockerignore: Keeps Docker image clean

---

## Build (local)
```bash
docker build -t nginx-demo .
docker run -p 8080:80 nginx-demo