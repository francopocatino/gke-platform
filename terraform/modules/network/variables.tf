variable "network_name" {
  description = "Name of the VPC network"
  type        = string
}

variable "region" {
  description = "Region for the GKE subnet"
  type        = string
}

variable "subnet_cidr" {
  description = "Primary CIDR for the GKE subnet"
  type        = string
  default     = "10.10.0.0/20"
}

variable "pods_cidr" {
  description = "Secondary CIDR for pods"
  type        = string
  default     = "10.20.0.0/16"
}

variable "services_cidr" {
  description = "Secondary CIDR for services"
  type        = string
  default     = "10.30.0.0/20"
}
