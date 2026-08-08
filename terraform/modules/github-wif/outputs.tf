output "provider_name" {
  description = "Full provider path for google-github-actions/auth"
  value       = google_iam_workload_identity_pool_provider.github.name
}

output "deployer_email" {
  description = "Deployer service account email"
  value       = google_service_account.deployer.email
}
