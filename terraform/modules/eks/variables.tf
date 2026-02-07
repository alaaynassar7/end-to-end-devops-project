variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}

variable "subnet_ids" {
  description = "List of private subnet IDs for the cluster and nodes"
  type        = list(string)
}

variable "node_sg_id" {
  description = "Security Group ID for the worker nodes"
  type        = string
}

variable "cluster_role_arn" {
  description = "IAM Role ARN for the EKS Cluster"
  type        = string
}

variable "node_role_arn" {
  description = "IAM Role ARN for the EKS Node Group"
  type        = string
}


