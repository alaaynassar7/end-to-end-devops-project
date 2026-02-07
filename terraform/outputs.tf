# --- Cluster Access ---
output "cluster_name" {
  description = "EKS Cluster Name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS Cluster Endpoint"
  value       = module.eks.cluster_endpoint
}

# --- ECR Repository ---
output "ecr_repository_url" {
  description = "URL of the ECR Repository"
  value       = module.ecr.repository_url
}

# --- API Gateway & Cognito ---
output "api_gateway_endpoint" {
  description = "Public URL of the API Gateway"
  value       = module.api_gateway.api_endpoint
}

output "cognito_user_pool_id" {
  value = module.cognito.user_pool_id
}

output "cognito_client_id" {
  value = module.cognito.user_pool_client_id
}

output "cognito_login_url" {
  value = "https://${var.project_name}-auth.auth.${var.region}.amazoncognito.com/login?client_id=${module.cognito.user_pool_client_id}&response_type=code&scope=email+openid&redirect_uri=http://localhost"
}

# --- Important Reminder ---
output "action_required" {
  value = "PLEASE NOTE: After Ingress-Nginx is installed, update 'integration_uri' with the NLB DNS name and run terraform apply again."
}