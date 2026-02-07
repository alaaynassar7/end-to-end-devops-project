output "cluster_role_arn" {
  description = "IAM Role ARN for EKS Cluster Control Plane"
  value       = aws_iam_role.cluster_role.arn
}

output "node_role_arn" {
  description = "IAM Role ARN for EKS Worker Nodes"
  value       = aws_iam_role.node_role.arn
}