#!/bin/bash

GREEN="\033[32m"
RED="\033[31m"
RESET="\033[0m"

# install git (needs sudo)
sudo apt update
sudo apt install -y git

# create gitlab namespace
kubectl create namespace gitlab

# install helm (needs sudo for snap)
sudo snap install helm --classic

# add helm repo and update
helm repo add gitlab https://charts.gitlab.io/
helm repo update

# deploy gitlab
helm upgrade --install gitlab gitlab/gitlab \
  -n gitlab \
  -f https://gitlab.com/gitlab-org/charts/gitlab/raw/master/examples/values-minikube-minimum.yaml \
  --set global.hosts.domain=k3d.gitlab.com \
  --set global.hosts.externalIP=0.0.0.0 \
  --set global.hosts.https=false \
  --timeout 600s

# wait for webservice pod to be ready
kubectl wait --for=condition=ready --timeout=1200s pod -l app=webservice -n gitlab

# show initial gitlab root password
echo -n "${GREEN}GITLAB PASSWORD: "
kubectl get secret gitlab-gitlab-initial-root-password -n gitlab -o jsonpath="{.data.password}" | base64 --decode
echo "${RESET}"

# port-forward GitLab webservice (use non-privileged port to avoid sudo)
kubectl port-forward svc/gitlab-webservice-default -n gitlab 8080:8181 > /dev/null 2>&1 &

echo "Access GitLab at http://localhost:8080"
