variable "project_name" {
  type    = string
  default = "alaa-devops-project"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_cidrs" {
  type    = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "environment" {
  type    = string
  default = "non-prod"
}

variable "tags" {
  type = map(string)
  default = {
    Project     = "End-to-End-DevOps"
    Environment = "non-prod"
    Owner       = "Alaa-Nassar"
    ManagedBy   = "Terraform"
  }
}

variable "integration_uri" {
  type        = string
  default     = "http://pending-nlb-dns.com"
  description = "Target URI for the API Integration (NLB DNS)"
}