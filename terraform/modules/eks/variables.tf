variable "project_name" {
  description = "Name of the project for resource identification"
  type        = string
}

variable "kubernetes_version" {
  description = "Desired Kubernetes version"
  type        = string
  default     = "1.31"
}

variable "cluster_role_arn" {
  description = "ARN of the IAM role for the EKS cluster"
  type        = string
}

variable "node_role_arn" {
  description = "ARN of the IAM role for the worker nodes"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the cluster and nodes"
  type        = list(string)
}

variable "instance_types" {
  description = "List of EC2 instance types for the nodes"
  type        = list(string)
  default     = ["t3.micro"]
}

variable "desired_capacity" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "min_capacity" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 3
}

variable "tags" {
  description = "Resource tags for the EKS components"
  type        = map(string)
}

# Dependencies to ensure correct creation order
variable "cluster_role_policy_attachment" {}
variable "node_role_policy_attachments" {}