terraform {
  backend "gcs" {
    bucket = "iac-bucket"
    prefix = "iac"
  }
}
