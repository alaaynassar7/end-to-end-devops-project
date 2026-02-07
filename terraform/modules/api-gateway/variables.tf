variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "List of private subnet IDs for the VPC Link"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security Group ID to allow traffic through the VPC Link"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}

variable "integration_uri" {
  description = "The Listener ARN of the Network Load Balancer (NLB). Leave empty for initial run."
  type        = string
  default     = "" 
}