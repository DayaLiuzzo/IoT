#!/bin/sh

# ArgoCD setup script for K3D cluster

# Create namespaces
echo "Creating namespaces: argocd and dev"
kubectl create namespace argocd && kubectl create namespace dev

# Install ArgoCD
echo "Installing ArgoCD in cluster"
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Deploy CD pipeline
echo "Configuring CD pipeline for simple-app"
kubectl apply -n argocd -f conf/argocd-deploy.yaml

