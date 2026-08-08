output "network_id" {
  description = "VPC network ID"
  value       = google_compute_network.this.id
}

output "subnet_id" {
  description = "GKE subnet ID"
  value       = google_compute_subnetwork.gke.id
}

output "pods_range_name" {
  description = "Name of the pods secondary range"
  value       = google_compute_subnetwork.gke.secondary_ip_range[0].range_name
}

output "services_range_name" {
  description = "Name of the services secondary range"
  value       = google_compute_subnetwork.gke.secondary_ip_range[1].range_name
}
