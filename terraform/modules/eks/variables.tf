variable "node_desired" { type = number }
variable "node_min"     { type = number }
variable "node_max"     { type = number }
variable "instance_types" { type = list(string) }
variable "project_name" { type = string }
variable "cluster_role_arn" { type = string }
variable "node_role_arn" { type = string }
variable "private_subnets" { type = list(string) }