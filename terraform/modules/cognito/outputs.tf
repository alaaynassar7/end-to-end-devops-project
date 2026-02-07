output "user_pool_id" {
  description = "The ID of the Cognito User Pool"
  value       = aws_cognito_user_pool.main.id
}

output "user_pool_client_id" {
  description = "The ID of the Cognito User Pool Client"
  value       = aws_cognito_user_pool_client.client.id
}

output "user_pool_endpoint" {
  description = "The endpoint of the Cognito User Pool"
  value       = aws_cognito_user_pool.main.endpoint
}

output "authorizer_id" {
  description = "The ID of the API Gateway Authorizer"
  value       = aws_apigatewayv2_authorizer.main.id
}