terraform {
  required_version = ">= 1.5"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }

  # State lives in a GCS bucket created outside this configuration.
  # Uncomment and set the bucket after bootstrapping:
  # backend "gcs" {
  #   bucket = "<project-id>-tfstate"
  #   prefix = "envs/dev"
  # }
}
