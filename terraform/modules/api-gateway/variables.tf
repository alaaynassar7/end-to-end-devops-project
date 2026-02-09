variable "cognito_client_id" {
  description = "The Cognito App Client ID"
  type        = string
}

variable "cognito_issuer_url" {
  description = "The Cognito User Pool Issuer URL"
  type        = string
}

variable "project_name" {
  description = "The project name used for tagging and naming resources"
  type        = string
}

variable "integration_uri" {
  description = "The target URI for the API Gateway integration"
  type        = string
}

variable "node_sg_id" {
  description = "The Security Group ID of the EKS nodes for VPC Link"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the VPC Link"
  type        = list(string)
}