output "cluster_name" {
  description = "GKE cluster name"
  value       = google_container_cluster.this.name
}

output "cluster_endpoint" {
  description = "Control plane endpoint"
  value       = google_container_cluster.this.endpoint
  sensitive   = true
}

output "workload_identity_pool" {
  description = "Workload identity pool of the cluster"
  value       = google_container_cluster.this.workload_identity_config[0].workload_pool
}
