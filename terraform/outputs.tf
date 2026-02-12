output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "api_gateway_url" {
  description = "URL of the API Gateway"
  value       = module.apigateway.api_endpoint
}

output "cognito_user_pool_id" {
  description = "Cognito User Pool ID"
  value       = module.cognito.user_pool_id
}

output "cognito_client_id" {
  description = "Cognito App Client ID"
  value       = module.cognito.client_id
}

output "cognito_client_secret" {
  description = "Cognito App Client Secret"
  value       = module.cognito.client_secret
  sensitive   = true
}

output "cognito_issuer_url" {
  description = "Cognito Issuer URL"
  value       = module.cognito.cognito_issuer_url
}

output "nlb_dns_name" {
  description = "The DNS name of the Network Load Balancer"
  value       = var.nlb_dns_name
}

output "cognito_login_url" {
  description = "Direct link to the Cognito Hosted UI Login page"
  value       = "https://${module.cognito.domain}.auth.${var.aws_region}.amazoncognito.com/login?client_id=${module.cognito.client_id}&response_type=code&scope=email+openid+profile&redirect_uri=${module.apigateway.api_endpoint}/oauth2/callback"
}