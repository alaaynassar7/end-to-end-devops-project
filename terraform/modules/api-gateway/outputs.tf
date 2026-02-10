output "api_endpoint" {
  description = "The URI of the API Gateway"
  value       = aws_apigatewayv2_api.main.api_endpoint
}