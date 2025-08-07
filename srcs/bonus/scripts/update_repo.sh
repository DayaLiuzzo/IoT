#!/bin/bash

# Get GitLab root password
GITLAB_PASS=$(kubectl get secret gitlab-gitlab-initial-root-password -n gitlab -o jsonpath="{.data.password}" | base64 --decode)

# Write .netrc for current user (adjust if needed for root)
sudo echo "machine gitlab.k3d.gitlab.com
login root
password ${GITLAB_PASS}" > ~/.netrc
sudo mv ~/.netrc /root/
sudo chmod 600 /root/.netrc

# Clone GitLab and GitHub repos
sudo git clone http://gitlab.k3d.gitlab.com:8082/root/simple-gitlab-app gitlab_repo
sudo git clone https://github.com/DayaLiuzzo/dliuzzo_iot github_repo

# Copy GitHub contents into GitLab repo
sudo mv github_repo/* gitlab_repo/

sudo rm -rf github_repo