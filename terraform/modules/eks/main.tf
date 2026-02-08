# 1. EKS Cluster (Control Plane)
resource "aws_eks_cluster" "main" {
  name     = "${var.project_name}-cluster"
  role_arn = var.cluster_role_arn
  
  # Leaving version null allows AWS to pick the default stable version
  version  = null 

  vpc_config {
    subnet_ids              = var.subnet_ids
    security_group_ids      = [var.node_sg_id]
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  tags = var.tags
}

# 2. Managed Node Group (Data Plane)
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

  update_config {
    max_unavailable = 1
  }

  ami_type       = "AL2_x86_64" # Amazon Linux 2
  
  # Using t3.small as requested (Cost Effective)
  instance_types = ["t3.small"] 

  depends_on = [
    aws_eks_cluster.main
  ]

  tags = merge(var.tags, {
    Name = "${var.project_name}-node-group"
  })
}

# 3. EBS CSI Driver Addon (Required for Storage/Database)
resource "aws_eks_addon" "ebs_csi_driver" {
  cluster_name                = aws_eks_cluster.main.name
  addon_name                  = "aws-ebs-csi-driver"
  
  # Automatic version selection
  addon_version               = null 
  resolve_conflicts_on_create = "OVERWRITE"
  
  depends_on = [aws_eks_node_group.main]
}