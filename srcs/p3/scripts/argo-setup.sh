. .env
export ARGOPASSWORD=$(sudo kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath='{.data.password}' | base64 -d)
echo $ARGOPASSWORD
argocd login localhost:8080 --username admin --password $ARGOPASSWORD --insecure
argocd account update-password --current-password $ARGOPASSWORD --new-password $NEWPASS
kubectl config set-context --current --namespace=argocd
argocd app create simple-app \
--repo https://github.com/DayaLiuzzo/dliuzzo_iot.git \
--path . \
--dest-server https://kubernetes.default.svc \
--dest-namespace dev
argocd app sync simple-app
argocd app set simple-app --sync-policy automated