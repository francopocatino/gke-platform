package main

deny contains msg if {
	network := input.resource.google_compute_network[name][_]
	not network.auto_create_subnetworks == false
	msg := sprintf("Network %q must not auto-create subnetworks", [name])
}
