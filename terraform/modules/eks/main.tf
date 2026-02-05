# --- EKS Cluster Control Plane ---
# Provisions the Kubernetes control plane
resource "aws_eks_cluster" "main" {
  name     = "${var.project_name}-cluster"
  role_arn = var.cluster_role_arn
  version  = var.kubernetes_version

  vpc_config {
    subnet_ids              = var.private_subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  # Ensure IAM Role permissions are created before the cluster
  depends_on = [var.cluster_role_policy_attachment]

  tags = var.tags
}

# --- Managed Node Group ---
# Provisions a group of worker nodes managed by AWS
resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.project_name}-node-group"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.private_subnet_ids

  scaling_config {
    desired_size = var.desired_capacity
    max_size     = var.max_capacity
    min_size     = var.min_capacity
  }

  instance_types = var.instance_types
  capacity_type  = "ON_DEMAND"

  # Ensure IAM Role permissions are created before the nodes
  depends_on = [var.node_role_policy_attachments]

  tags = var.tags
}