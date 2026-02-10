# 2. Worker Node Security Group
resource "aws_security_group" "node" {
  name        = "${var.project_name}-node-sg"
  description = "Security group for EKS worker nodes"
  vpc_id      = var.vpc_id

  tags = merge(var.tags, {
    Name                                                    = "${var.project_name}-node-sg"
    "kubernetes.io/cluster/${var.project_name}-cluster" = "owned"
  })
}

# Allow nodes to communicate with each other
resource "aws_security_group_rule" "node_internal" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.node.id
  security_group_id        = aws_security_group.node.id
}

# Allow Control Plane to communicate with nodes
resource "aws_security_group_rule" "node_ingress_cluster" {
  type             = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = aws_security_group.node.id
}

resource "aws_security_group_rule" "node_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.node.id
}

resource "aws_security_group_rule" "node_ingress_vpc" {
  type              = "ingress"
  from_port         = 1024       
  to_port           = 65535    
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"] 
  security_group_id = aws_security_group.node.id
}

# 3. VPC Link Security Group
# Required for the API Gateway VPC Link to communicate with the Internal NLB
resource "aws_security_group" "vpc_link" {
  name        = "${var.project_name}-vpc-link-sg"
  description = "Security group for API Gateway VPC Link"
  vpc_id      = var.vpc_id

  tags = merge(var.tags, {
    Name = "${var.project_name}-vpc-link-sg"
  })
}

resource "aws_security_group_rule" "vpc_link_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.vpc_link.id
}