variable "project_name" { default = "alaa-devops-project" }
variable "region" { default = "us-east-1" }
variable "environment" { default = "non-prod" }
variable "vpc_cidr" { default = "10.0.0.0/16" }
variable "public_cidrs" { default = ["10.0.1.0/24", "10.0.2.0/24"] }
variable "private_cidrs" { default = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"] }
variable "azs" { default = ["us-east-1a", "us-east-1b"] }

variable "tags" {
  default = {
    Project     = "End-to-End-DevOps"
    Environment = "non-prod"
    Owner       = "Alaa-Nassar"
    ManagedBy   = "Terraform"
  }
}

variable "integration_uri" {
  # Placeholder until Ingress Controller creates the NLB
  default     = "http://google.com" 
  description = "Target URI for API Gateway"
}