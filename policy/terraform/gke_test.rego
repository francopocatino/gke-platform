package main

import rego.v1

test_autopilot_required if {
	deny["GKE cluster \"bad\" must use Autopilot"] with input as {"resource": {"google_container_cluster": {"bad": [{}]}}}
}

test_autopilot_ok if {
	cluster := {"enable_autopilot": true, "private_cluster_config": [{"enable_private_nodes": true}], "release_channel": [{"channel": "REGULAR"}]}
	count(deny) == 0 with input as {"resource": {"google_container_cluster": {"good": [cluster]}}}
}

test_private_nodes_required if {
	cluster := {"enable_autopilot": true, "private_cluster_config": [{"enable_private_nodes": false}], "release_channel": [{"channel": "REGULAR"}]}
	deny["GKE cluster \"bad\" must run private nodes"] with input as {"resource": {"google_container_cluster": {"bad": [cluster]}}}
}

test_release_channel_required if {
	cluster := {"enable_autopilot": true, "private_cluster_config": [{"enable_private_nodes": true}]}
	deny["GKE cluster \"bad\" must subscribe to a release channel"] with input as {"resource": {"google_container_cluster": {"bad": [cluster]}}}
}

test_network_must_disable_auto_subnets if {
	deny["Network \"bad\" must not auto-create subnetworks"] with input as {"resource": {"google_compute_network": {"bad": [{"auto_create_subnetworks": true}]}}}
}

test_wif_condition_required if {
	provider := {"attribute_mapping": {"google.subject": "assertion.sub"}}
	count(deny) == 1 with input as {"resource": {"google_iam_workload_identity_pool_provider": {"bad": [provider]}}}
}

test_wif_condition_ok if {
	provider := {"attribute_condition": "assertion.repository == \"owner/repo\""}
	count(deny) == 0 with input as {"resource": {"google_iam_workload_identity_pool_provider": {"good": [provider]}}}
}
