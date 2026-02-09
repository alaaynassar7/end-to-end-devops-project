variable "project_name" { type = string }
variable "region"       { type = string }
variable "environment"  { type = string }
variable "vpc_cidr"     { type = string }
variable "public_cidrs" { type = list(string) }
variable "private_cidrs" { type = list(string) }
variable "azs"           { type = list(string) }

variable "tags" {
  type        = map(string)
  description = "Resource tags provided via tfvars"
}

variable "integration_uri" {
  type        = string
  description = "Target URI for API Gateway - Provided via tfvars "
}
variable "cognito_client_id" {
  type = string
}

variable "cognito_issuer_url" {
  type = string
}