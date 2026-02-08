terraform {
  backend "s3" {
    bucket  = "end-to-end-devops-project-bucket"
    key     = "infrastructure/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
    # use_lockfile = true (Optional, needs DynamoDB)
  }
}