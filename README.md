# 🏗️ Cloud-Native DevOps Ecosystem — Motivational Hub

A full end-to-end DevOps project that demonstrates migrating a "Motivational Hub" application from a local VMware development environment to a production-grade, highly available AWS EKS cluster. The pipeline orchestration is handled by Azure DevOps (CI) and Argo CD (GitOps CD). Infrastructure is implemented with modular Terraform.

---

## Table of contents
- [Project Overview](#project-overview)
- [Architecture](#architecture)
- [What's included](#whats-included)
- [Status / Roadmap](#status--roadmap)
- [Quick start (core commands)](#quick-start-core-commands)
- [CI / CD details](#ci--cd-details)
- [Secrets & Configuration](#secrets--configuration)
- [Observability & Next steps](#observability--next-steps)
- [Documentation gallery](#documentation-gallery)
- [License & contact](#license--contact)

---

## Project overview
This repo documents the full engineering lifecycle of the Motivational Hub application:
- Infrastructure as Code with Terraform (modular, reusable modules).
- Managed Kubernetes (AWS EKS) for orchestration.
- Image build and registry via Azure DevOps pipeline pushing to Amazon ECR.
- GitOps continuous deployment using Argo CD monitoring manifests in `/k8s`.
- Secrets stored and retrieved securely from AWS SSM / Kubernetes Secrets.
- Optional: MongoDB hosted in Atlas as the application data store.

Goals:
- Demonstrate repeatable, secure, multi-cloud-aware infrastructure and pipelines.
- Provide a reference implementation for migrating from local VMware to cloud native EKS.
- Show GitOps best practices using Argo CD.

---

## Architecture
- VPC with public and private subnets
- Internet Gateway + NAT Gateway for controlled egress
- EKS control plane (managed) + Managed Node Groups
- Ingress controller (ingress-nginx) via Helm and an AWS Load Balancer for external traffic
- CI builds and pushes Docker images to ECR
- Argo CD watches `/k8s` manifests and syncs to EKS clusters (non-prod + prod)
- Secrets (MongoDB Atlas URI) stored in AWS SSM and injected into K8s at runtime

(Consider adding an architecture diagram image here)

---

## What's included
- /terraform — modular Terraform code for networking, EKS, IAM, node groups, and supporting resources
- /motivational-app — application source and Dockerfile
- /k8s — Kubernetes manifests and Helm charts used by Argo CD
- Azure DevOps pipeline YAML (CI) — builds, scans, and pushes images to ECR
- Argo CD manifests/config for CD

---

## Status & Roadmap
- AWS VPC & EKS cluster — ✅ Done
- Azure DevOps CI — ✅ Done (build, scan, push to ECR)
- MongoDB Atlas connection — ✅ Done (URI injected via Secrets)
- Argo CD deployment — ✅ Done (GitOps active for manifests)
- Datadog Observability — 🔄 In progress / next
- API Gateway integration (direct routing to K8s Ingress) — 🔄 Next

---

## Quick start (core commands)

1. Initialize and plan Terraform
   - terraform init
   - terraform plan

2. Apply infrastructure (example)
   - terraform apply -auto-approve

3. Configure kubectl for your EKS cluster
   - aws eks update-kubeconfig --region <region> --name <cluster-name>

4. Deploy (if using local kubectl/helm)
   - helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
   - helm install ingress-nginx ingress-nginx/ingress-nginx -n ingress-nginx --create-namespace
   - kubectl apply -f /k8s/<manifests>

Notes:
- Replace placeholders with your region, cluster-name, and other environment-specific values.
- Terraform state should be stored remotely (S3 + DynamoDB) in production setups.

---

## CI / CD details

CI (Azure DevOps)
- Self-hosted agent: `alaaynassar-VMware` (used for Docker builds)
- Builds Docker images from `/motivational-app/Dockerfile`
- Images are tagged with commit SHA and pushed to Amazon ECR
- ECR image scanning enabled to catch vulnerabilities before deployment
- Pipeline fetches MongoDB Atlas URI from AWS SSM Parameter Store at build/deploy time (as needed)

CD (Argo CD)
- Argo CD monitors `/k8s` directory in this repository
- Sync strategy: automated sync for non-prod; configurable for prod (promote via PR/approval)
- Secrets: MongoDB URI injected as Kubernetes Secret (created at runtime or via sealed-secrets / external-secrets)

---

## Secrets & configuration
- MongoDB Atlas connection string: stored in AWS SSM Parameter Store
- Kubernetes secrets: injected at deployment time. Consider using:
  - ExternalSecrets (external-secrets.io) to sync secrets from SSM to K8s
  - sealed-secrets or SOPS for repository-stored encrypted secrets (if desired)
- IAM: Terraform creates granular IAM roles and policies for EKS control plane, nodes, and service accounts

Security recommendations:
- Rotate secrets regularly.
- Restrict ECR and EKS permissions with least privilege.
- Enable image scanning and container runtime security tooling.

---

## Observability & Monitoring
Planned:
- Datadog agent installed as a DaemonSet to collect logs and metrics
- Configure Datadog APM for tracing if application supports it
- Alerts forwarded to your incident management (PagerDuty / Slack)

---

## Documentation gallery (evidence)
(Embed screenshots or link to repository screenshots folder)

Example screenshot (add to repo in `/docs/screenshots` and link here):
- README edit preview, pipeline runs, cluster console snapshots, Argo CD dashboard

---

## Next steps / Recommendations
- Finish Datadog integration and validate end-to-end observability
- Integrate API Gateway (e.g., AWS API Gateway or ALB) for routing and WAF protection
- Add automated security scanning during CI and admission controls in cluster
- Add a blue/green or canary promotion workflow using Argo Rollouts for production deployments
- Add detailed runbooks for DR and incident response

---

## IMGs


---

## License
Specify your license here (e.g., MIT). If unspecified, add a LICENSE file.# 🏗️ Cloud-Native DevOps Ecosystem — Motivational Hub

A full end-to-end DevOps project that demonstrates migrating a "Motivational Hub" application from a local VMware development environment to a production-grade, highly available AWS EKS cluster. The pipeline orchestration is handled by Azure DevOps (CI) and Argo CD (GitOps CD). Infrastructure is implemented with modular Terraform.

---

## Table of contents
- [Project Overview](#project-overview)
- [Architecture](#architecture)
- [What's included](#whats-included)
- [Status / Roadmap](#status--roadmap)
- [Quick start (core commands)](#quick-start-core-commands)
- [CI / CD details](#ci--cd-details)
- [Secrets & Configuration](#secrets--configuration)
- [Observability & Next steps](#observability--next-steps)
- [Documentation gallery](#documentation-gallery)
- [License & contact](#license--contact)

---

## Project overview
This repo documents the full engineering lifecycle of the Motivational Hub application:
- Infrastructure as Code with Terraform (modular, reusable modules).
- Managed Kubernetes (AWS EKS) for orchestration.
- Image build and registry via Azure DevOps pipeline pushing to Amazon ECR.
- GitOps continuous deployment using Argo CD monitoring manifests in `/k8s`.
- Secrets stored and retrieved securely from AWS SSM / Kubernetes Secrets.
- Optional: MongoDB hosted in Atlas as the application data store.

Goals:
- Demonstrate repeatable, secure, multi-cloud-aware infrastructure and pipelines.
- Provide a reference implementation for migrating from local VMware to cloud native EKS.
- Show GitOps best practices using Argo CD.

---

## Architecture
- VPC with public and private subnets
- Internet Gateway + NAT Gateway for controlled egress
- EKS control plane (managed) + Managed Node Groups
- Ingress controller (ingress-nginx) via Helm and an AWS Load Balancer for external traffic
- CI builds and pushes Docker images to ECR
- Argo CD watches `/k8s` manifests and syncs to EKS clusters (non-prod + prod)
- Secrets (MongoDB Atlas URI) stored in AWS SSM and injected into K8s at runtime

(Consider adding an architecture diagram image here)

---

## What's included
- /terraform — modular Terraform code for networking, EKS, IAM, node groups, and supporting resources
- /motivational-app — application source and Dockerfile
- /k8s — Kubernetes manifests and Helm charts used by Argo CD
- Azure DevOps pipeline YAML (CI) — builds, scans, and pushes images to ECR
- Argo CD manifests/config for CD

---

## Status & Roadmap
- AWS VPC & EKS cluster — ✅ Done
- Azure DevOps CI — ✅ Done (build, scan, push to ECR)
- MongoDB Atlas connection — ✅ Done (URI injected via Secrets)
- Argo CD deployment — ✅ Done (GitOps active for manifests)
- Datadog Observability — 🔄 In progress / next
- API Gateway integration (direct routing to K8s Ingress) — 🔄 Next

---

## Quick start (core commands)

1. Initialize and plan Terraform
   - terraform init
   - terraform plan

2. Apply infrastructure (example)
   - terraform apply -auto-approve

3. Configure kubectl for your EKS cluster
   - aws eks update-kubeconfig --region <region> --name <cluster-name>

4. Deploy (if using local kubectl/helm)
   - helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
   - helm install ingress-nginx ingress-nginx/ingress-nginx -n ingress-nginx --create-namespace
   - kubectl apply -f /k8s/<manifests>

Notes:
- Replace placeholders with your region, cluster-name, and other environment-specific values.
- Terraform state should be stored remotely (S3 + DynamoDB) in production setups.

---

## CI / CD details

CI (Azure DevOps)
- Self-hosted agent: `alaaynassar-VMware` (used for Docker builds)
- Builds Docker images from `/motivational-app/Dockerfile`
- Images are tagged with commit SHA and pushed to Amazon ECR
- ECR image scanning enabled to catch vulnerabilities before deployment
- Pipeline fetches MongoDB Atlas URI from AWS SSM Parameter Store at build/deploy time (as needed)

CD (Argo CD)
- Argo CD monitors `/k8s` directory in this repository
- Sync strategy: automated sync for non-prod; configurable for prod (promote via PR/approval)
- Secrets: MongoDB URI injected as Kubernetes Secret (created at runtime or via sealed-secrets / external-secrets)

---

## Secrets & configuration
- MongoDB Atlas connection string: stored in AWS SSM Parameter Store
- Kubernetes secrets: injected at deployment time. Consider using:
  - ExternalSecrets (external-secrets.io) to sync secrets from SSM to K8s
  - sealed-secrets or SOPS for repository-stored encrypted secrets (if desired)
- IAM: Terraform creates granular IAM roles and policies for EKS control plane, nodes, and service accounts

Security recommendations:
- Rotate secrets regularly.
- Restrict ECR and EKS permissions with least privilege.
- Enable image scanning and container runtime security tooling.

---

## Observability & Monitoring
Planned:
- Datadog agent installed as a DaemonSet to collect logs and metrics
- Configure Datadog APM for tracing if application supports it
- Alerts forwarded to your incident management (PagerDuty / Slack)

---

## Documentation gallery (evidence)
(Embed screenshots or link to repository screenshots folder)

Example screenshot (add to repo in `/docs/screenshots` and link here):
- README edit preview, pipeline runs, cluster console snapshots, Argo CD dashboard

---

## Next steps / Recommendations
- Finish Datadog integration and validate end-to-end observability
- Integrate API Gateway (e.g., AWS API Gateway or ALB) for routing and WAF protection
- Add automated security scanning during CI and admission controls in cluster
- Add a blue/green or canary promotion workflow using Argo Rollouts for production deployments
- Add detailed runbooks for DR and incident response

---

## Contributing
- Fork the repo, make your changes, open a pull request
- Use feature branches and include descriptive commit messages
- For infra changes: test Terraform in a sandbox environment before applying to prod

---

## License
---
![WhatsApp Image 2026-02-06 at 12 49 30 AM](https://github.com/user-attachments/assets/7288edad-38c2-4582-b2f6-fb71a51f0b37)

---
<img width="1600" height="900" alt="image" src="https://github.com/user-attachments/assets/7b6fa0e8-337a-4100-8a92-ffbc30790d90" />

---

<img width="1600" height="900" alt="image" src="https://github.com/user-attachments/assets/7b7e2937-b6e0-40ad-b3ab-b39aa73a051b" />

---

<img width="1600" height="900" alt="image" src="https://github.com/user-attachments/assets/3ef2a996-5f60-41f3-86e9-f4a5be5d2523" />

---

![WhatsApp Image 2026-02-06 at 2 15 31 AM](https://github.com/user-attachments/assets/08fb9da6-c319-4044-bf32-5d3732173fd5)

---
## Contact
Project owner: alaaynassar7@gmail.com
