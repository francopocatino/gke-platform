output "cluster_name" {
  description = "GKE cluster name"
  value       = module.gke.cluster_name
}

output "wif_provider" {
  description = "Set as GCP_WIF_PROVIDER repository variable"
  value       = module.github_wif.provider_name
}

output "deployer_email" {
  description = "Set as GCP_DEPLOYER_SA repository variable"
  value       = module.github_wif.deployer_email
}

output "registry" {
  description = "Artifact Registry repository for images"
  value       = "${var.region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.images.repository_id}"
}
