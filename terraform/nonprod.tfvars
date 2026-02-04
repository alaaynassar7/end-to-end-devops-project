region      = "us-east-1"
name_prefix = "alaay-final"
vpc_cidr    = "10.0.0.0/16"
azs         = ["us-east-1a", "us-east-1b"]

public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]

tags = {
  env     = "nonprod"
  project = "devops-final-project"
}

cluster_name    = "alaay-eks-cluster"
cluster_version = "1.31"

node_desired   = 2
node_min       = 1
node_max       = 3
instance_types = ["t3.medium"]
capacity_type  = "ON_DEMAND"

domain_name    = "alaaynassar.com"
hosted_zone_id = "Z05131842BXT9H3SPUW3F"
enable_cognito = true