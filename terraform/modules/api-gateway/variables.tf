variable "project_name" {}
variable "environment"  {}
variable "vpc_id"       {}
variable "subnet_ids"   { type = list(string) }
variable "security_group_id" {}
variable "cognito_endpoint"  {}
variable "cognito_client_id" {}
variable "integration_uri"   {}
variable "tags"         { type = map(string) }