output "cluster_name" {
  description = "EKS Cluster Name"
  value       = module.eks.cluster_name
}

output "api_gateway_url" {
  description = "Public URL for API Gateway"
  value       = module.apigateway.api_endpoint 
}

output "cognito_client_id" {
  value = module.cognito.client_id
}

output "cognito_client_secret" {
  value     = module.cognito.client_secret
  sensitive = true
}

output "cognito_issuer_url" {
  value = "https://cognito-idp.${var.aws_region}.amazonaws.com/${module.cognito.user_pool_id}"
}

output "cognito_login_url" {
  description = "Dynamic Login URL using HTTPS callback"
  value       = "https://${module.cognito.cognito_domain}.auth.${var.aws_region}.amazoncognito.com/login?client_id=${module.cognito.client_id}&response_type=code&scope=email+openid+profile&redirect_uri=${module.apigateway.api_endpoint}/oauth2/callback"
}