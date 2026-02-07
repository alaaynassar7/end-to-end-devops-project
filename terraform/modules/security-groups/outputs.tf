output "alb_sg_id" {
  description = "Security Group ID for the Load Balancer"
  value       = aws_security_group.alb.id
}

output "node_sg_id" {
  description = "Security Group ID for the EKS Worker Nodes"
  value       = aws_security_group.node.id
}