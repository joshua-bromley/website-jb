provider "google" {
  project = var.project_name
  region  = "us-west1"
  zone    = "us-west1-a"
}

terraform {
    required_providers {
      cloudflare = {
        source  = "cloudflare/cloudflare"
      }
    }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_key
}

terraform {
  #Disable this if you need to bootstrap this terraform
    backend "gcs" {
    bucket = "91371b7ab40fe40a-bmao-bucket-tfstate"
    prefix = "terraform/state"
  }
}

module "site" {
  source = "./website-tf"

  providers = {
    google = google
  }

  domain = var.domain
  site_name = var.site_name
  account_id = var.account_id
  repo_name = var.repo_name
  project_name = var.project_name
}




