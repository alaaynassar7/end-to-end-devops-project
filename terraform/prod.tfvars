aws_region      = "eu-north-1"
environment     = "prod"
project_name    = "alaa-end-to-end-devops-project"
vpc_cidr        = "10.1.0.0/16"
cluster_version = "1.30"
instance_type   = "t3.medium"
principal_arn   = "arn:aws:iam::344809605543:root"

tags = {
  Owner       = "Alaa-Nassar"
  Project     = "Final-Project"
  Environment = "prod"
}

irsa_roles = {
  "ebs-csi" = {
    namespace            = "kube-system"
    service_account_name = "ebs-csi-controller-sa"
    policy_arns          = ["arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"]
  }
}