resource "aws_eks_cluster" "main" {
  name     = "${var.project_name}-cluster"
  role_arn = var.cluster_role_arn
  version  = "1.30"

  vpc_config {
    subnet_ids              = var.subnet_ids
    security_group_ids      = [var.node_sg_id]
    endpoint_private_access = true
    endpoint_public_access  = true
  }
}

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.project_name}-node-group"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  ami_type       = "AL2023_x86_64_STANDARD"
  
  instance_types = ["t3.small"]
  capacity_type  = "ON_DEMAND"

  depends_on = [aws_eks_cluster.main]
}
