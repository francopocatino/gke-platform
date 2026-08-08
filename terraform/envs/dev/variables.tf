variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "Default region"
  type        = string
  default     = "us-central1"
}

variable "github_repository" {
  description = "Repository allowed to deploy, as owner/name"
  type        = string
  default     = "francopocatino/gke-platform"
}

variable "authorized_networks" {
  description = "Networks allowed to reach the control plane endpoint"
  type = list(object({
    cidr = string
    name = string
  }))
  default = []
}
