package main

deny contains msg if {
	provider := input.resource.google_iam_workload_identity_pool_provider[name][_]
	not provider.attribute_condition
	msg := sprintf("WIF provider %q must set attribute_condition; without it any GitHub repository can authenticate", [name])
}
