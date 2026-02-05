variable "project_name" {
  description = "Project name prefix for resource naming"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "azs" {
  description = "List of availability zones to use"
  type        = list(string)
}

variable "tags" {
  description = "Resource tags to be applied to all networking components"
  type        = map(string)
}