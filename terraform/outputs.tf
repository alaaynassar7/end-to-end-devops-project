output "cluster_name" { value = module.eks.cluster_name }
output "ecr_repository_url" { value = module.ecr.repository_url }
output "api_gateway_endpoint" { value = module.api_gateway.api_endpoint }
output "cognito_client_id" { value = module.cognito.client_id }