# 1. EKS Control Plane
resource "aws_eks_cluster" "main" {
  name     = "${var.project_name}-cluster"
  role_arn = var.cluster_role_arn
  
  # Set to null for automatic stable version selection
  version  = var.kubernetes_version 

  vpc_config {
    subnet_ids              = var.subnet_ids
    security_group_ids      = [var.node_sg_id]
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  tags = var.tags
}

# 2. Managed Node Group
resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.project_name}-node-group"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids

  # Automatic OS (Amazon Linux) and version matching
  instance_types = var.instance_types
  capacity_type  = "ON_DEMAND"

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [aws_eks_cluster.main]
  
  tags = var.tags
}