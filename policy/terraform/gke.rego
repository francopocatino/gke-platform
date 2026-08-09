package main

import rego.v1

deny contains msg if {
	cluster := input.resource.google_container_cluster[name][_]
	not cluster.enable_autopilot == true
	msg := sprintf("GKE cluster %q must use Autopilot", [name])
}

deny contains msg if {
	cluster := input.resource.google_container_cluster[name][_]
	pcc := cluster.private_cluster_config[_]
	not pcc.enable_private_nodes == true
	msg := sprintf("GKE cluster %q must run private nodes", [name])
}

deny contains msg if {
	cluster := input.resource.google_container_cluster[name][_]
	not cluster.private_cluster_config
	msg := sprintf("GKE cluster %q must declare private_cluster_config", [name])
}

deny contains msg if {
	cluster := input.resource.google_container_cluster[name][_]
	not cluster.release_channel
	msg := sprintf("GKE cluster %q must subscribe to a release channel", [name])
}
