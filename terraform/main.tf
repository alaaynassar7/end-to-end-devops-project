# 1. Network Layer
module "network" {
  source        = "./modules/network"
  project_name  = var.project_name
  vpc_cidr      = var.vpc_cidr
  public_cidrs  = var.public_cidrs
  private_cidrs = var.private_cidrs
  azs           = var.azs
  tags          = var.tags
}

# 2. Security Layer
module "security_groups" {
  source       = "./modules/security-groups"
  project_name = var.project_name
  vpc_id       = module.network.vpc_id
  tags         = var.tags
}

# 3. IAM Layer
module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
  tags         = var.tags
}

# 4. Compute Layer (EKS)
module "eks" {
  source           = "./modules/eks"
  project_name     = var.project_name
  subnet_ids       = module.network.private_subnet_ids
  node_sg_id       = module.security_groups.node_sg_id
  cluster_role_arn = module.iam.cluster_role_arn
  node_role_arn    = module.iam.node_role_arn
  tags             = var.tags
}

# 5. Container Registry
module "ecr" {
  source       = "./modules/ecr"
  project_name = var.project_name
  tags         = var.tags
}

# 6. Authentication
module "cognito" {
  source       = "./modules/cognito"
  project_name = var.project_name
  environment  = var.environment
  tags         = var.tags
}

# 7. API Exposure
module "api_gateway" {
  source            = "./modules/api-gateway"
  project_name      = var.project_name
  integration_uri   = var.integration_uri
  cognito_client_id = module.cognito.client_id
  cognito_endpoint  = module.cognito.user_pool_endpoint
  tags              = var.tags
}