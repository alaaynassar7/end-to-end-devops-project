# ------------------------------------------------------------------------
# 1. Networking Layer (VPC, Subnets, NAT Gateway)
# ------------------------------------------------------------------------
module "network" {
  source = "./modules/network"

  project_name  = var.project_name
  vpc_cidr      = var.vpc_cidr
  public_cidrs  = var.public_cidrs
  private_cidrs = var.private_cidrs
  azs           = var.azs
  tags          = var.tags
}

# ------------------------------------------------------------------------
# 2. Security Groups Layer (Network Firewalls)
# ------------------------------------------------------------------------
module "security_groups" {
  source = "./modules/security-groups"

  project_name = var.project_name
  vpc_id       = module.network.vpc_id
}

# ------------------------------------------------------------------------
# 3. Identity & Access Management Layer (IAM Roles, Policies)
# ------------------------------------------------------------------------
module "iam" {
  source = "./modules/iam"

  project_name = var.project_name
  tags         = var.tags
  
}

# ------------------------------------------------------------------------
# 4. Compute Layer (EKS Cluster, Node Groups)
# ------------------------------------------------------------------------
module "eks" {
  source = "./modules/eks"

  project_name     = var.project_name
  subnet_ids       = module.network.private_subnet_ids
  node_sg_id       = module.security_groups.node_sg_id
  
  cluster_role_arn = module.iam.cluster_role_arn
  node_role_arn    = module.iam.node_role_arn
  
  tags = var.tags
}

# ------------------------------------------------------------------------
# 5. Artifacts Layer (ECR Repository)
# ------------------------------------------------------------------------
module "ecr" {
  source = "./modules/ecr"

  project_name = var.project_name
  tags         = var.tags
}

# ------------------------------------------------------------------------
# 6. Entry Point Layer (API Gateway & VPC Link)
# ------------------------------------------------------------------------
module "api_gateway" {
  source = "./modules/api-gateway"

  project_name      = var.project_name
  vpc_id            = module.network.vpc_id
  subnet_ids        = module.network.private_subnet_ids
  security_group_id = module.security_groups.alb_sg_id 
  
  integration_uri   = var.integration_uri
  
  tags = var.tags
}

# ------------------------------------------------------------------------
# 7. Authentication Layer (Cognito User Pool)
# ------------------------------------------------------------------------
module "cognito" {
  source = "./modules/cognito"

  project_name = var.project_name
  api_id       = module.api_gateway.api_id
  tags         = var.tags
}

# ------------------------------------------------------------------------
# 8. Kubernetes Addons (Helm Charts)
# ------------------------------------------------------------------------
module "kubernetes_addons" {
  source = "./modules/kubernetes-addons"

  project_name      = var.project_name
  cluster_name      = module.eks.cluster_name
  cluster_endpoint  = module.eks.cluster_endpoint
  
  
  tags = var.tags
  
  depends_on = [module.eks, module.iam]
}