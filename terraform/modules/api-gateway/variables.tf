variable "client_id" {
  description = "The Cognito App Client ID from the Cognito module"
  type        = string
}

variable "user_pool_id" {
  description = "The Cognito User Pool ID from the Cognito module"
  type        = string
}

variable "region" {
  description = "The AWS region for constructing the issuer URL"
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

variable "vpc_link_security_group_id" {
  description = "The Security Group ID for the VPC Link"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of Private Subnet IDs for the VPC Link"
  type        = list(string)
}