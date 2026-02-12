variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "project_name" {
  description = "Name prefix for resources"
  type        = string
}

variable "cluster_name" {
  description = "The name of the EKS cluster (Required for subnet tagging)"
  type        = string
}