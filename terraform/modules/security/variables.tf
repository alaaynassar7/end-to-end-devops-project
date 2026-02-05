variable "project_name" {
  description = "Prefix for naming security resources"
  type        = string
}

variable "oidc_issuer_url" {
  description = "The OIDC issuer URL from the EKS cluster"
  type        = string
}

variable "ingress_controller_policy_arn" {
  description = "ARN of the IAM policy for AWS Load Balancer Controller"
  type        = string
}

variable "tags" {
  description = "Common tags for security resources"
  type        = map(string)
}