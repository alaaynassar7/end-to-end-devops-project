# --- Project Configuration ---
project_name       = "alaa-devops-project"
aws_region         = "us-east-1"
kubernetes_version = "1.31" # Balanced version for stability

# --- Networking Configuration ---
# Defining a fresh VPC range to avoid conflicts with previous setups
vpc_cidr      = "10.0.0.0/16"
azs           = ["us-east-1a", "us-east-1b"]

# Public Subnets for Load Balancer and NAT Gateway
public_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]

# Private Subnets (2 for Nodes, 2 for Database/Internal Services)
private_cidrs = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

# --- EKS Compute Configuration ---
instance_types = ["t3.small"]  # Optimized for budget/Free Tier
desired_capacity = 2
min_capacity     = 1
max_capacity     = 3

# --- Security & Governance ---
# Temporary policy ARN for Ingress Controller to allow Plan to pass
# You can update this later with the actual Load Balancer Controller Policy ARN
ingress_controller_policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

# --- Project Tagging ---
tags = {
  Environment = "non-prod"
  Owner       = "Alaa-Nassar"
  Project     = "End-to-End-DevOps"
  ManagedBy   = "Terraform"
}