variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}

# OIDC is optional initially because it comes FROM the EKS cluster
variable "oidc_issuer_url" {
  description = "The OIDC issuer URL (Output from EKS module)"
  type        = string
  default     = "" 
}

# Policy ARN for Load Balancer (optional initially)
variable "ingress_controller_policy_arn" {
  description = "ARN of the AWS Load Balancer Controller IAM Policy"
  type        = string
  default     = ""
}