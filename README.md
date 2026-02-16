# End-to-End DevOps Project 🚀

![AWS](https://img.shields.io/badge/AWS-EKS-orange?style=for-the-badge&logo=amazon-aws)
![Terraform](https://img.shields.io/badge/Terraform-IaC-purple?style=for-the-badge&logo=terraform)
![Azure DevOps](https://img.shields.io/badge/Azure%20DevOps-CI%2FCD-blue?style=for-the-badge&logo=azure-devops)
![ArgoCD](https://img.shields.io/badge/ArgoCD-GitOps-orange?style=for-the-badge&logo=argo)
![Python](https://img.shields.io/badge/Python-Flask-yellow?style=for-the-badge&logo=python)

## 📖 Overview

Welcome to **Alaa's Hub**, a comprehensive **End-to-End DevOps** project. This repository houses the infrastructure, configuration, and source code for a Python Flask application deployed on **AWS EKS**.

The project demonstrates a production-ready workflow using **Infrastructure as Code (IaC)**, **GitOps**, **Secret Management**, and **Full-Stack Observability**.

### 🌟 Key Features
*   **Automated Infrastructure**: One-click EKS cluster provisioning using Terraform.
*   **GitOps Deployment**: Application state managed by ArgoCD.
*   **Security First**: Secrets managed by HashiCorp Vault; Authentication via OAuth2 & Cognito.
*   **Quality Assurance**: Code analysis integrated via SonarQube.
*   **Observability**: Real-time monitoring and logging with Datadog.

---

## 🏗️ Architecture
<img width="1144" height="974" alt="1_-ft05Aq5c-rlFL7buOjCtA" src="https://github.com/user-attachments/assets/8ba67ee2-7fc2-4a2c-af27-e10eea14069b" />

---

<img width="1144" height="974" alt="aws-private-lb-diagram" src="https://github.com/user-attachments/assets/495a6678-5d71-4503-bcb4-6752408d60b5" />

---
<img width="1144" height="974" alt="roundtrip" src="https://github.com/user-attachments/assets/8dd805f0-5c23-414c-88fd-6fd0a4597aba" />

---
<img width="1144" height="974" alt="4" src="https://github.com/user-attachments/assets/0b6aff40-d958-4ec0-bb08-d666ff722174" />

---
<img width="1144" height="974" alt="vpc-example-private-subnets" src="https://github.com/user-attachments/assets/b85f9d92-1551-4bc4-aa5d-35df38969682" />

---

*High-level architecture illustrating the AWS EKS cluster, CI/CD pipelines, and tool integrations.*

The solution leverages a modern cloud-native stack:

| Category | Technology | Usage |
|----------|------------|-------|
| **Cloud Provider** | !AWS | EKS, VPC, API Gateway, NLB |
| **IaC** | !Terraform | Provisioning VPC & Kubernetes Cluster |
| **CI/CD** | !Azure DevOps | Pipeline Orchestration |
| **GitOps** | !ArgoCD | Continuous Deployment to K8s |
| **Containerization** | !Docker | App Containerization |
| **Monitoring** | !Datadog | Metrics & Logs |
| **Security** | !Vault | Secret Management |

---

## 📂 Repository Structure

```bash
├── terraform/                  # ☁️ Terraform IaC for AWS
│   ├── modules/                # Reusable Infrastructure Modules
│   │   ├── apigateway/         # API Gateway configuration
│   │   ├── cognito/            # Authentication (Cognito User Pools)
│   │   ├── eks/                # Kubernetes Cluster & Node Groups
│   │   └── vpc/                # Network configuration (VPC, Subnets)
│   ├── backend.tf              # State backend configuration
│   ├── main.tf                 # Root configuration
│   ├── nonprod.tfvars          # Non-prod environment variables
│   ├── outputs.tf              # Outputs (VPC ID, EKS Endpoint)
│   ├── prod.tfvars             # Prod environment variables
│   ├── providers.tf            # Provider definitions
│   └── variables.tf            # Variable definitions
├── motivational-app/           # 🐍 Python Flask Application
│   ├── app.py                  # Application Logic
│   ├── Dockerfile              # Container Definition
│   └── requirements.txt        # Dependencies
├── motivational-app-chart/     # ☸️ Helm Chart
│   ├── templates/              # K8s Manifests (Deployment, Service)
│   ├── Chart.yaml              # Chart Metadata
│   └── values.yaml             # Default Values
├── infra-pipeline.yml      # 🏗️ Infrastructure Provisioning Pipeline
├── tools-pipeline.yml      # 🛠️ K8s Add-ons Pipeline (Nginx, Vault, Argo, etc.)
├── release-pipeline.yml    # 🐳 CI: Build & Push Docker Image Pipeline
├── argocd-application.yml  # 🐙 CD: Sync App via ArgoCD Pipeline
└── README.md               # 📄 Documentation
```

## 🔄 Pipelines Workflow

This project utilizes **Azure DevOps** for automation, split into four distinct pipelines:

### 1. Infrastructure Pipeline (`infra-pipeline.yml`)
- **Trigger**: Manual / On-demand.
- **Actions**:
  - `terraform init`, `plan`, and `apply`.
  - Provisions the VPC, EKS Cluster, and security groups.
  - Supports a `destroy` action with automated pre-cleanup scripts for AWS Load Balancers to prevent hanging resources.

### 2. Tools Pipeline (`tools-pipeline.yml`)
- **Purpose**: Bootstraps the EKS cluster with essential add-ons.
- **Deployments**:
  - **Nginx Ingress**: Sets up the Ingress Controller and AWS NLB.
  - **Datadog Agent**: Installs the agent for full-stack monitoring.
  - **HashiCorp Vault**: Deploys Vault for secrets management.
  - **ArgoCD**: Installs the GitOps controller.
  - **SonarQube**: Deploys the code quality server.
  - **OAuth2-Proxy**: Configures authentication via AWS Cognito, linking API Gateway to the Ingress.

### 3. Release Pipeline (`release-pipeline.yml`)
- **Trigger**: On commit to `main`.
- **Actions**:
  - Builds the Docker image for the Motivational App.
  - Tags with `BuildId` and `latest`.
  - Pushes the image to **Docker Hub** (`alaaynassar7/motivational-app`).

### 4. ArgoCD Sync Pipeline (`argocd-application.yml`)
- **Purpose**: Deploys the application logic using GitOps.
- **Actions**:
  - Configures `kubeconfig` and fetches API Gateway details.
  - Generates Docker Registry secrets in the cluster for image pulling.
  - Creates/Updates the **ArgoCD Application** manifest dynamically.
  - Triggers ArgoCD to sync the Helm chart from the repository to the EKS cluster.

## 💻 Application Details
The application is a lightweight Flask web server:
- **Frontend**: HTML/JS template rendering motivational quotes.
- **Backend**: Python Flask with PyMongo.
- **Database**: MongoDB (stores quotes).
- **Features**:
  - View quotes by ID.
  - Update quotes dynamically (persisted to MongoDB).
  - Real-time connection status indicator.

## 🛠️ Setup & Prerequisites
1. **AWS Account**: With permissions to create EKS, VPC, and IAM roles.
2. **Azure DevOps Organization**: With a self-hosted agent pool configured (`alaaynassar-VMware`).
3. **Docker Hub Account**: For storing application images.
4. **Datadog Account**: API Key required for monitoring.
5. **Terraform Backend**: S3 bucket/DynamoDB for state locking.

## 🚀 How to Run
1. **Provision Infrastructure**: Run the `Infrastructure` pipeline to create the EKS cluster.
2. **Install Tools**: Run the `Tools` pipeline to install ArgoCD, Nginx, etc.
3. **Build App**: Run the `Release` pipeline to push the Docker image.
4. **Deploy App**: Run the `ArgoCD` pipeline to sync the app to the cluster.

## 📸 Application Screenshots
1. **App + MongoDb**
<img width="1600" height="876" alt="image" src="https://github.com/user-attachments/assets/2dc0cf5e-0af5-40c4-8f5e-f880610c54b3" />
---
<img width="1600" height="900" alt="image" src="https://github.com/user-attachments/assets/8cb28a90-d005-4449-bf0e-41652e015ce4" />

---
<img width="1600" height="900" alt="image" src="https://github.com/user-attachments/assets/1c2327f9-134a-4099-816a-470c48aa6d03" />

--
<img width="1600" height="900" alt="image" src="https://github.com/user-attachments/assets/b51094a9-137e-448b-863a-1c61f0b73e64" />

---
<img width="1600" height="900" alt="image" src="https://github.com/user-attachments/assets/59997eb7-c391-468c-a785-0c25a84207c0" />

---
2. **Data dog**
<img width="1721" height="883" alt="0" src="https://github.com/user-attachments/assets/5d308b60-7c43-4189-af94-f41645aad7e3" />
---
2. **Sonar qube**
<img width="1600" height="711" alt="image" src="https://github.com/user-attachments/assets/acc9142d-255a-42e8-9b9b-cbee0ecc11f5" />


---
*Created by Alaa Nassar*
