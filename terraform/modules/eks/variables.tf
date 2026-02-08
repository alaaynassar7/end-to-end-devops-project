variable "project_name" { type = string }
variable "subnet_ids" { type = list(string) }
variable "node_sg_id" { type = string }
variable "cluster_role_arn" { type = string }
variable "node_role_arn" { type = string }
variable "tags" { type = map(string) }