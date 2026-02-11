terraform {
  required_version = ">= 1.14.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "> 2.23"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "> 2.11"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Provider configuration relying on the compute module outputs
data "aws_eks_cluster_auth" "main" {
  name = module.compute.cluster_name
}

provider "kubernetes" {
  host                   = module.compute.cluster_endpoint
  cluster_ca_certificate = base64decode(module.compute.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.main.token
}