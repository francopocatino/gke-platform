# Decisions

Short log of the choices behind this repo, newest first.

## CI runs without GCP credentials (2026-08)

Every check in CI is config-time: checkov and conftest read the HCL, kyverno tests run against fixtures and rendered manifests. Nothing needs a `terraform plan` against a real project, so a fork or a PR can never touch my infrastructure and CI stays green with the cluster destroyed. Plan-time checks run locally, where credentials already exist.

## WIF provider must carry an attribute condition (2026-08)

The provider path ends up in public workflow files, and GitHub's OIDC issuer is shared by every repository on GitHub. Without `attribute_condition` scoping it to this repo, anyone can exchange a token against the pool and impersonate the deployer service account. I learned this reviewing an older repo of mine; there is now a conftest rule that fails the build if the condition is missing.

## Policy at two layers (2026-08)

Pipeline checks (checkov, conftest) catch bad infrastructure before it exists. Admission checks (kyverno) catch bad workloads no matter how they reach the cluster, including kubectl straight from a laptop. One without the other leaves a gap: pipeline-only misses out-of-band applies, cluster-only wastes an apply cycle to find out requests are missing.

## Autopilot over Standard (2026-08)

This cluster runs one demo service, not enough to justify tuning node pools. Autopilot bills per pod request, so an idle cluster costs close to the management fee alone, and it removes the node-hardening surface (no SSH, shielded nodes, auto-upgrades). The trade-off is less control: no privileged DaemonSets, no custom node images. Nothing here needs either.

## Kustomize over Helm for own workloads (2026-08)

Helm earns its complexity when you distribute charts to other people. For my own manifests, a base plus one overlay per environment is easier to read and to diff in Argo CD. Third-party installs (Argo CD itself, Kyverno) still come from their upstream charts or manifests.
