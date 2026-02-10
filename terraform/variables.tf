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

variable "nlb_listener_arn" {
  type        = string
  description = "The ARN of the NLB Listener (Updated automatically by Pipeline)"
  default     = "" #
}
