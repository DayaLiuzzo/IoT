# cluster & namespaces
# sudo k3d cluster create inception
sudo k3d cluster create --config  conf/inception-cluster.yaml
# sudo k3d cluster start inception
sudo kubectl create namespace argocd
sudo kubectl create namespace gitlab
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
sudo kubectl create namespace dev
# sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
sleep 30
export ARGOPASSWORD=$(sudo kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath='{.data.password}' | base64 -d)
echo $ARGOPASSWORD
sudo kubectl port-forward svc/argocd-server -n argocd 8080:443 --address 0.0.0.0 &