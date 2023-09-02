terraform {
  backend "s3" {
    bucket = "mycicd-project-backend-storage-file-save"
    key    = "terraform_backend_file/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "mybackend_table"
  }
}