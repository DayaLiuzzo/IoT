#init cluster
k3d cluster create --config conf/k3d-argocd-lab.yaml

#argocd install
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
# kubectl apply -n argocd -f conf/install.yaml

#argocd cli
VERSION=$(curl -L -s https://raw.githubusercontent.com/argoproj/argo-cd/stable/VERSION)
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/download/v$VERSION/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64

#dev namespace
kubectl create namespace dev


#argo cd set up

# kubectl apply -f conf/ingress.yaml -n argocd


# kubectl patch deployment argocd-server -n argocd \
#   --type=json \
#   -p='[{"op": "add", "path": "/spec/template/spec/containers/0/args/-", "value": "--insecure"}]'
