variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_endpoint" {
  description = "EKS Cluster Endpoint"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}