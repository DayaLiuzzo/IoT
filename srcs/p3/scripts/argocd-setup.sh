#!/bin/sh

. scripts/.env

ARGOCD_ADMIN_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)


kubectl -n argocd port-forward svc/argocd-server 8080:443 --address 0.0.0.0 > /dev/null 2>&1 &
PF_PID=$!

# Wait for port-forward to be ready
while ! nc -z localhost 8080; do
  sleep 0.5
done

argocd login localhost:8080 --username admin --password $ARGOCD_ADMIN_PASSWORD --insecure

argocd account update-password --current-password "$ARGOCD_ADMIN_PASSWORD" --new-password "$NEW_PASSWORD"

kubectl config set-context --current --namespace=argocd
argocd app create simple-app \
--repo https://github.com/DayaLiuzzo/dliuzzo_iot.git \
--path . \
--dest-server https://kubernetes.default.svc \
--dest-namespace dev

argocd app sync simple-app
argocd app set simple-app --sync-policy automated


