output "cluster_name" {
  description = "EKS Cluster Name"
  value       = module.eks.cluster_name
}

output "ecr_repository_url" {
  description = "URL of the ECR Repository"
  value       = module.ecr.repository_url
}

output "api_gateway_endpoint" {
  description = "Public URL of the API Gateway"
  value       = module.api_gateway.api_endpoint
}

output "cognito_user_pool_id" {
  description = "Cognito User Pool ID"
  value       = module.cognito.user_pool_id
}

output "cognito_client_id" {
  description = "Cognito Client ID"
  value       = module.cognito.client_id
}

output "next_steps" {
  value = "SUCCESS: Infrastructure is ready. ACTION: 1. Deploy App via Pipeline. 2. Get NLB DNS. 3. Update 'integration_uri' and re-run."
}