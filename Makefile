.PHONY: fmt validate policy test render local local-down

fmt:
	terraform fmt -recursive terraform/

validate:
	terraform fmt -check -recursive terraform/
	cd terraform/envs/dev && terraform init -backend=false -input=false > /dev/null && terraform validate

policy:
	conftest verify --policy policy/terraform
	conftest test --parser hcl2 --policy policy/terraform --ignore='.terraform' terraform/
	kyverno test policy/cluster/tests

test:
	mvn -q -B -f services/hello-api/app/pom.xml test

render:
	kustomize build gitops/hello-api/overlays/dev

local:
	./scripts/local-up.sh

local-down:
	kind delete cluster --name gke-platform
