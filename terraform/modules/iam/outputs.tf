output "cluster_role_arn" {
  description = "The ARN of the IAM role for the EKS cluster"
  value       = aws_iam_role.cluster_role.arn
}

output "node_role_arn" {
  description = "The ARN of the IAM role for the EKS worker nodes"
  value       = aws_iam_role.node_role.arn
}