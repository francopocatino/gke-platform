variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
}

variable "region" {
  description = "Cluster region"
  type        = string
}

variable "env" {
  description = "Environment label (dev, staging, prod)"
  type        = string
}

variable "network_id" {
  description = "VPC network ID"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the cluster"
  type        = string
}

variable "pods_range_name" {
  description = "Secondary range name for pods"
  type        = string
}

variable "services_range_name" {
  description = "Secondary range name for services"
  type        = string
}

variable "master_cidr" {
  description = "CIDR for the control plane"
  type        = string
  default     = "172.16.0.0/28"
}

variable "authorized_networks" {
  description = "Networks allowed to reach the control plane endpoint"
  type = list(object({
    cidr = string
    name = string
  }))
  default = []
}
