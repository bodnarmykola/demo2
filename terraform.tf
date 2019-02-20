terraform {
 backend "s3" {
 encrypt = true
 bucket = "gammas3statichtml"
# dynamodb_table = "terraform-state-lock-dynamo"
 region = "us-west-2"
 key = "tfstate/lock.tf"
 }
}
