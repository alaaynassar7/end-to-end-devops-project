output "cluster_role_arn" {
  description = "IAM Role ARN for the EKS control plane"
  value       = aws_iam_role.cluster_role.arn
}

output "node_role_arn" {
  description = "IAM Role ARN for the worker nodes"
  value       = aws_iam_role.node_role.arn
}