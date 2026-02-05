variable "project_name" {
  description = "Project name prefix for API Gateway resources"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnets for the VPC Link"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for the VPC Link"
  type        = string
}

variable "load_balancer_arn" {
  description = "ARN of the Internal Load Balancer created by the Ingress Controller"
  type        = string
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
}