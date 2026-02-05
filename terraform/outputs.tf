# --- Networking Outputs ---
output "vpc_id" {
  description = "The ID of the created VPC"
  value       = module.network.vpc_id
}

# --- EKS Outputs ---
output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "The endpoint URL for the EKS cluster API"
  value       = module.eks.cluster_endpoint
}

# --- ECR Outputs ---
output "ecr_repository_url" {
  description = "The URL of the ECR repository for Docker images"
  value       = module.ecr.repository_url
}

# --- API Gateway Outputs ---
output "api_gateway_endpoint" {
  description = "The public endpoint for the API Gateway"
  value       = module.api_gateway.api_endpoint
}

# --- IAM/Security Outputs ---
output "ingress_controller_role_arn" {
  description = "The ARN of the IAM role for the Ingress Controller (IRSA)"
  value       = module.security.ingress_controller_role_arn
}