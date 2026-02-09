terraform {
  backend "s3" {
    bucket = "cd"
    key    = "terraform.tfstate"                   
    region = "us-east-1"
    encrypt = true
  }
}