output "cluster_endpoint" { value = module.eks.cluster_endpoint }
output "nlb_dns_name" { value = module.lb.nlb_dns_name }
output "vpc_id" { value = module.network.vpc_id }