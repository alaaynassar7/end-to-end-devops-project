output "alb_sg_id" { value = aws_security_group.alb.id }
output "node_sg_id" { value = aws_security_group.node.id }
output "node_sg_arn" { value = aws_security_group.node.arn }