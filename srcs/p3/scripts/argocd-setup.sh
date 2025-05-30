ARGOCD_ADMIN_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

kubectl -n argocd port-forward svc/argocd-server 8080:443 &
PF_PID=$!

# Wait for port-forward to be ready
while ! nc -z localhost 8080; do
  sleep 0.5
done

argocd login localhost:8080 --username admin --password $ARGOCD_ADMIN_PASSWORD --insecure


kubectl config set-context --current --namespace=argocd
argocd app create simple-app \
--repo https://github.com/DayaLiuzzo/dliuzzo_iot.git \
--path . \
--dest-server https://kubernetes.default.svc \
--dest-namespace dev

argocd app sync simple-app

SLEEP_INTERVAL=2
POD_NAME=$(kubectl get pods -n dev -l app=simple-app -o jsonpath="{.items[0].metadata.name}")
NAMESPACE=dev
TIMEOUT=60                 
SLEEP_INTERVAL=2

elapsed=0
while true; do
  POD_STATUS=$(kubectl -n "$NAMESPACE" get pods -l "$POD_LABEL" -o jsonpath="{.items[0].status.phase}" 2>/dev/null || echo "NotFound")
  if [ "$POD_STATUS" = "Running" ]; then
    echo "Pod is running!"
    break
  fi

  if [ "$elapsed" -ge "$TIMEOUT" ]; then
    echo "Timeout waiting for pod to be running" >&2
    exit 1
  fi

  echo "Waiting for pod to be running (current status: $POD_STATUS)..."
  sleep $SLEEP_INTERVAL
  elapsed=$((elapsed + SLEEP_INTERVAL))
done

kubectl port-forward -n dev svc/simple-app 8888:80 --address 0.0.0.0 & 
