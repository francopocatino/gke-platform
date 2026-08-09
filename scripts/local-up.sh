#!/usr/bin/env bash
# Spin up the whole platform on a local kind cluster: Kyverno, Argo CD,
# policies, and hello-api synced from this repo on GitHub.
set -euo pipefail

cd "$(dirname "$0")/.."

CLUSTER=gke-platform
KYVERNO_VERSION=1.13.4
# 3.x needed: 2.x can't diff against the newer kube API kind ships
ARGOCD_VERSION=3.2.0

if ! kind get clusters 2>/dev/null | grep -qx "$CLUSTER"; then
  kind create cluster --name "$CLUSTER" --wait 120s
fi
kubectl config use-context "kind-$CLUSTER"

echo "==> Building hello-api image"
docker build -q -t hello-api:local services/hello-api
kind load docker-image hello-api:local --name "$CLUSTER"

echo "==> Installing Kyverno"
kubectl create -f "https://github.com/kyverno/kyverno/releases/download/v${KYVERNO_VERSION}/install.yaml" 2>/dev/null || true
kubectl -n kyverno wait --for=condition=Available deployment --all --timeout=180s

echo "==> Installing Argo CD"
kubectl create namespace argocd 2>/dev/null || true
kubectl apply -n argocd -f "https://raw.githubusercontent.com/argoproj/argo-cd/v${ARGOCD_VERSION}/manifests/install.yaml" > /dev/null
kubectl -n argocd wait --for=condition=Available deployment argocd-server --timeout=300s

echo "==> Bootstrapping app-of-apps"
kubectl apply -f gitops/argocd/root-app-local.yaml

echo
echo "Done. Argo CD will sync policies and hello-api from GitHub (main)."
echo
echo "  UI:        kubectl -n argocd port-forward svc/argocd-server 8080:443"
echo "  password:  kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d"
echo "  app:       kubectl -n hello-api port-forward svc/hello-api 8081:80  # then curl localhost:8081"
echo "  grafana:   kubectl -n monitoring port-forward svc/monitoring-grafana 3000:80"
echo "             kubectl -n monitoring get secret monitoring-grafana -o jsonpath='{.data.admin-password}' | base64 -d"
echo "  teardown:  make local-down"
