variable "project_id" {
  description = "Project that hosts the pool and service account"
  type        = string
}

variable "github_repository" {
  description = "GitHub repository allowed to authenticate, as owner/name"
  type        = string
}

variable "pool_id" {
  description = "Workload identity pool ID"
  type        = string
  default     = "github-actions"
}

variable "provider_id" {
  description = "Workload identity pool provider ID"
  type        = string
  default     = "github-oidc"
}

variable "deployer_account_id" {
  description = "Account ID for the deployer service account"
  type        = string
  default     = "sa-github-deployer"
}

variable "deployer_roles" {
  description = "Project roles granted to the deployer"
  type        = list(string)
  default = [
    "roles/container.developer",
    "roles/artifactregistry.writer",
  ]
}
