# --- Project Configuration ---
project_name = "alaa-devops-project"
region       = "us-east-1"  # Renamed from aws_region to match variables.tf

# --- Networking Configuration ---
vpc_cidr      = "10.0.0.0/16"
azs           = ["us-east-1a", "us-east-1b"]
public_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_cidrs = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

# --- Integration Configuration ---
# This is required. Leave it empty for the first run.
# After the Ingress Controller creates the NLB, you will paste the ARN here.
integration_uri = "http://ad22f48977c87461aa8a9364faa608ee-19978a9a7b3f723f.elb.us-east-1.amazonaws.com"

# --- Project Tagging ---
tags = {
  Environment = "non-prod"
  Owner       = "Alaa-Nassar"
  Project     = "End-to-End-DevOps"
  ManagedBy   = "Terraform"
}
