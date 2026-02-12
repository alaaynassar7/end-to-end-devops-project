variable "project_name" {}
variable "environment" {}
variable "vpc_id" {}
variable "private_subnets" { type = list(string) }
variable "cluster_security_group" {}
variable "nlb_listener_arn" { default = "" }
variable "cognito_user_pool_id" {}
variable "cognito_client_id" {}
variable "cognito_issuer_url" {}
