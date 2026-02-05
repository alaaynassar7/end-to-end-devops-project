output "oidc_provider_arn" {
  description = "The ARN of the OIDC Provider"
  value       = aws_iam_openid_connect_provider.eks.arn
}

output "ingress_controller_role_arn" {
  description = "The ARN of the IAM role for the Ingress Controller"
  value       = aws_iam_role.ingress_controller.arn
}