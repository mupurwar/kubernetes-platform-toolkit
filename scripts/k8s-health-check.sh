#!/usr/bin/env bash
set -u
echo "=== Kubernetes Cluster Health ==="
echo
echo "--- Nodes ---"
kubectl get nodes -o wide
echo
echo "--- Nodes Not Ready ---"
kubectl get nodes --no-headers | awk '$2 != "Ready" {print}'
echo
echo "--- Pods Not Running/Completed ---"
kubectl get pods -A --field-selector=status.phase!=Running,status.phase!=Succeeded
echo
echo "--- Node Conditions ---"
kubectl get nodes -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{range .status.conditions[*]}  {.type}={.status}{"\n"}{end}{end}'
echo
echo "=== Health Check Complete ==="
