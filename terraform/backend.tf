
terraform {
  backend "s3" {
    bucket = "end-to-end-devops-project-bucket" 
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}