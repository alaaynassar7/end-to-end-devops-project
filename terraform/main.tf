module "vpc" {
  source       = "./modules/vpc"
  vpc_cidr     = var.vpc_cidr
  project_name = var.project_name
  cluster_name = "${var.project_name}-cluster"
}

module "eks" {
  source          = "./modules/eks"
  project_name    = var.project_name
  environment     = var.environment
  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
  private_subnets = module.vpc.private_subnets
  cluster_version = var.cluster_version
  instance_type   = var.instance_type
  principal_arn   = var.principal_arn
}

module "apigateway" {
  source                 = "./modules/apigateway"
  project_name           = var.project_name
  environment            = var.environment
  vpc_id                 = module.vpc.vpc_id
  private_subnets        = module.vpc.private_subnets
  cluster_security_group = module.eks.cluster_security_group_id
  nlb_listener_arn       = var.nlb_listener_arn
  cognito_user_pool_id   = module.cognito.user_pool_id
  cognito_client_id      = module.cognito.client_id
  cognito_issuer_url     = module.cognito.cognito_issuer_url
}


module "cognito" {
  source       = "./modules/cognito"
  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region
  tags         = var.tags
  callback_url = var.nlb_dns_name != "" ? var.nlb_dns_name : "https://example.com"
}
