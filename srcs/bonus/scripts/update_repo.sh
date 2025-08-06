#!/bin/bash

# Get GitLab root password
GITLAB_PASS=$(kubectl get secret gitlab-gitlab-initial-root-password -n gitlab -o jsonpath="{.data.password}" | base64 --decode)

# Write .netrc for current user (adjust if needed for root)
echo -e "machine gitlab.k3d.gitlab.com:8082\nlogin root\npassword ${GITLAB_PASS}" > ~/.netrc
chmod 600 ~/.netrc

# Clone GitLab and GitHub repos
git clone http://gitlab.k3d.gitlab.com:8082/root/simple-gitlab-app.git gitlab_repo
git clone https://github.com/DayaLiuzzo/dliuzzo_iot github_repo

# Copy GitHub contents into GitLab repo
cp -r github_repo/* gitlab_repo/
rm -rf github_repo

# Commit and push changes
cd gitlab_repo
git add .
git commit -m "Update from GitHub repo"
git push
cd ..

# Apply ArgoCD application
kubectl apply -f ../conf/argocd-deploy.yaml
