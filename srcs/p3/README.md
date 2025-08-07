# P3: ArgoCD Setup

## Prerequisites
- Docker, K3D, kubectl installed
- Run all scripts from P3 root folder

## Setup

### 1. Create K3D cluster
```bash
./scripts/init.sh
```

### 2. Deploy ArgoCD
```bash
./scripts/argocd-setup.sh
```

### 3. Access ArgoCD UI
```bash
kubectl port-forward -n argocd svc/argocd-server 8080:443 --address 0.0.0.0
```
- UI: `https://localhost:8080`
- Username: `admin`
- Password: `kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d`

## GitOps
ArgoCD monitors `https://github.com/DayaLiuzzo/dliuzzo_iot.git` and auto-syncs to `dev` namespace.

## Cleanup
```bash
k3d cluster delete argocd-lab
``` 


## CHECK
To check at "MachineIP:8888" for simple app from the host, or curl it from the Vm at "Localhost:8888"