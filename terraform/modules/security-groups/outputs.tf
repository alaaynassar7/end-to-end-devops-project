output "node_sg_id" {
  description = "Security Group ID of the EKS Worker Nodes"
  value       = aws_security_group.node.id
}

output "vpc_link_sg_id" {
  description = "Security Group ID for the API Gateway VPC Link"
  value       = aws_security_group.vpc_link.id
}