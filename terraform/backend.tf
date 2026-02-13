terraform {
  backend "s3" {
    bucket       = "final-project-alaa-bucket-lv"
    key          = "eks-platform/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
  }
}