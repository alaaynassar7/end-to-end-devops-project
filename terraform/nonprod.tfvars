# 1. Project Identity
project_name = "alaa-devops-project"
environment  = "nonprod" 
region       = "eu-north-1"

# 2. Networking Configuration
vpc_cidr      = "10.0.0.0/16"
azs           = ["eu-north-1a", "eu-north-1b"]
public_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_cidrs = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

# 3. Integration Configuration (Placeholder for Pass 1)
nlb_listener_arn = "placeholder-will-be-updated-by-pipeline"
# 4. Project Tagging
tags = {
  Environment = "non-prod"
  Owner       = "Alaa-Nassar"
  Project     = "End-to-End-DevOps"
  ManagedBy   = "Terraform"
}