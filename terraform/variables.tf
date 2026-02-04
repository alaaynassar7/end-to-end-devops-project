variable "region" { type = string }
variable "name_prefix" { type = string }
variable "vpc_cidr" { type = string }
variable "azs" { type = list(string) }
variable "public_subnet_cidrs" { type = list(string) }
variable "private_subnet_cidrs" { type = list(string) }
variable "tags" { type = map(string) }

# EKS
variable "cluster_name" { type = string }
variable "cluster_version" { type = string }
variable "node_desired" { type = number }
variable "node_min" { type = number }
variable "node_max" { type = number }
variable "instance_types" { type = list(string) }
variable "capacity_type" { type = string }

# Security & Identity
variable "domain_name" { type = string }
variable "hosted_zone_id" { type = string }
variable "enable_cognito" { type = bool }