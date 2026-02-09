variable "project_name" { type = string }
variable "tags" { type = map(string) }
variable "integration_uri" { type = string }
variable "cognito_client_id" { type = string }
variable "cognito_endpoint" { type = string }

# Add these two:
variable "subnet_ids" { type = list(string) }
variable "node_sg_id" { type = string }