variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}

variable "subnet_ids" {
  description = "Private subnet IDs for nodes"
  type        = list(string)
}

variable "node_sg_id" {
  description = "Security group for worker nodes"
  type        = string
}

variable "cluster_role_arn" {
  description = "IAM role for the control plane"
  type        = string
}

variable "node_role_arn" {
  description = "IAM role for worker nodes"
  type        = string
}

variable "kubernetes_version" {
  description = "K8s version (null = latest stable)"
  type        = string
  default     = null 
}

variable "instance_types" {
  description = "EC2 instance types"
  type        = list(string)
  default     = ["t3.small"] 
}