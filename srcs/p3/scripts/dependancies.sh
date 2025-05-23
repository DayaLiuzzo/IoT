pt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
kubectl create namespace argo-nm
kubectl create namespace dev