output "cluster_name" {
  description = "EKS Cluster Name"
  value       = module.eks.cluster_name
}

output "api_gateway_url" {
  description = "Public URL for API Gateway"
  value       = module.apigateway.api_gateway_url
}

output "cognito_client_id" {
  value = module.cognito.client_id
}

output "cognito_client_secret" {
  value     = module.cognito.client_secret
  sensitive = true
}

output "cognito_issuer_url" {
  value = module.cognito.cognito_issuer_url
}