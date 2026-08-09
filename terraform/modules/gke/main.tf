resource "google_container_cluster" "this" {
  #checkov:skip=CKV_GCP_61:Intranode visibility is managed by Autopilot; VPC flow logs are enabled on the subnet
  #checkov:skip=CKV_GCP_12:Autopilot runs Dataplane V2, which enforces network policies by default
  #checkov:skip=CKV_GCP_65:Google Groups RBAC needs a Workspace domain, not available on a personal project
  #checkov:skip=CKV_GCP_69:Autopilot always runs the GKE metadata server; node_config is not settable
  name     = var.cluster_name
  location = var.region

  enable_autopilot = true

  network    = var.network_id
  subnetwork = var.subnet_id

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_range_name
    services_secondary_range_name = var.services_range_name
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = var.master_cidr
  }

  master_authorized_networks_config {
    dynamic "cidr_blocks" {
      for_each = var.authorized_networks
      content {
        cidr_block   = cidr_blocks.value.cidr
        display_name = cidr_blocks.value.name
      }
    }
  }

  release_channel {
    channel = "REGULAR"
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  binary_authorization {
    evaluation_mode = "PROJECT_SINGLETON_POLICY_ENFORCE"
  }

  deletion_protection = false

  resource_labels = {
    env        = var.env
    managed_by = "terraform"
  }
}
