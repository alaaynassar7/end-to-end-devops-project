# 1. Project Identity
project_name = "alaa-devops-project"
region       = "us-east-1" 

# 2. Networking Configuration
vpc_cidr      = "10.0.0.0/16"
azs           = ["us-east-1a", "us-east-1b"]
public_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_cidrs = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

# 3. Integration Configuration (Proxy Target)

integration_uri = ""


# 4. Project Tagging (General Labels)
tags = {
  Environment = "non-prod"
  Owner       = "Alaa-Nassar"
  Project     = "End-to-End-DevOps"
  ManagedBy   = "Terraform"
}