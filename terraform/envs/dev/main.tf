module "network" {
  source = "../../modules/network"

  network_name = "platform-dev"
  region       = var.region
}

module "gke" {
  source = "../../modules/gke"

  cluster_name        = "platform-dev"
  region              = var.region
  env                 = "dev"
  network_id          = module.network.network_id
  subnet_id           = module.network.subnet_id
  pods_range_name     = module.network.pods_range_name
  services_range_name = module.network.services_range_name
  authorized_networks = var.authorized_networks
}

module "github_wif" {
  source = "../../modules/github-wif"

  project_id        = var.project_id
  github_repository = var.github_repository
}

resource "google_artifact_registry_repository" "images" {
  repository_id = "platform"
  location      = var.region
  format        = "DOCKER"

  cleanup_policies {
    id     = "keep-recent"
    action = "KEEP"
    most_recent_versions {
      keep_count = 10
    }
  }
}
