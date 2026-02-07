output "api_id" {
  description = "The ID of the API Gateway"
  value       = aws_apigatewayv2_api.main.id
}

output "api_endpoint" {
  description = "The public URL of the API Gateway"
  value       = aws_apigatewayv2_api.main.api_endpoint
}

output "vpc_link_id" {
  description = "The ID of the VPC Link"
  value       = aws_apigatewayv2_vpc_link.main.id
}