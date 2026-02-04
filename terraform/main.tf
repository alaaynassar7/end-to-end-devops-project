# 1. Network: Creates VPC, Subnets, IGW, NAT
module "network" {
  source               = "./modules/network"
  project_name         = var.name_prefix
  environment          = var.tags["env"]
  vpc_cidr             = var.vpc_cidr
  public_subnets_cidr  = var.public_subnet_cidrs
  private_subnets_cidr = var.private_subnet_cidrs
  availability_zones   = var.azs
}

# 2. IAM: Roles for EKS Cluster and Worker Nodes
module "iam" {
  source       = "./modules/iam"
  project_name = var.name_prefix
  cluster_name = var.cluster_name
}

# 3. EKS: Kubernetes Cluster & Node Groups
module "eks" {
  source           = "./modules/eks"
  project_name     = var.name_prefix
  cluster_role_arn = module.iam.cluster_role_arn
  node_role_arn    = module.iam.node_role_arn
  private_subnets  = module.network.private_subnets_ids
}

# 4. Load Balancing: NLB and Target Groups
module "lb" {
  source         = "./modules/load_balancing"
  project_name   = var.name_prefix
  vpc_id         = module.network.vpc_id
  public_subnets = module.network.public_subnets_ids
}

# 5. Identity & DNS: Route53 and Cognito
module "identity" {
  source       = "./modules/identity_dns"
  project_name = var.name_prefix
  domain_name  = var.domain_name
  nlb_dns_name = module.lb.nlb_dns_name
  nlb_zone_id  = "Z26RNL4B79WM9H" # Fixed ID for NLB in us-east-1
}