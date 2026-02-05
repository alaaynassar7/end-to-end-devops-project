# 1. Infrastructure Networking Layer
module "network" {
  source         = "./modules/network"
  project_name   = var.project_name
  vpc_cidr       = var.vpc_cidr
  public_cidrs   = var.public_cidrs
  private_cidrs  = var.private_cidrs
  azs            = var.azs
  tags           = var.tags
}

# 2. Identity and Access Management Layer
module "iam_base" {
  source       = "./modules/iam"
  project_name = var.project_name
  tags         = var.tags
}

# 3. Compute Layer (EKS Cluster)
module "eks" {
  source             = "./modules/eks"
  project_name       = var.project_name
  kubernetes_version = var.kubernetes_version
  cluster_role_arn   = module.iam_base.cluster_role_arn
  node_role_arn      = module.iam_base.node_role_arn
  private_subnet_ids = module.network.private_subnet_ids
  instance_types     = var.instance_types
  
  # Dependencies to ensure IAM roles exist before cluster/nodes
  cluster_role_policy_attachment = module.iam_base.cluster_role_arn # simplified
  node_role_policy_attachments   = module.iam_base.node_role_arn    # simplified
  
  tags = var.tags
}

# 4. Container Registry for CI/CD artifacts
module "ecr" {
  source       = "./modules/ecr"
  project_name = var.project_name
  tags         = var.tags
}

# 5. Security & Identity Integration (OIDC & IRSA)
module "security" {
  source          = "./modules/security"
  project_name    = var.project_name
  oidc_issuer_url = module.eks.oidc_issuer_url
  tags            = var.tags
  
  # Policy for Ingress controller (This ARN should be provided in variables)
  ingress_controller_policy_arn = var.ingress_controller_policy_arn
}

# 6. Entry Point Layer (API Gateway)
module "api_gateway" {
  source             = "./modules/api-gateway"
  project_name       = var.project_name
  
  private_subnet_ids = module.network.private_subnet_ids 
  security_group_id = module.network.default_security_group_id  
  load_balancer_arn  = var.load_balancer_arn
  tags               = var.tags
}