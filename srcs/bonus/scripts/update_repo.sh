# MANUALLY CREATE THE REPO IN GITLAB UI BEFORE LAUNCHING THIS


GITLAB_PASS=$(kubectl get secret gitlab-gitlab-initial-root-password -n gitlab -o jsonpath="{.data.password}" | base64 --decode)

# Write the .netrc file directly to /root/
sudo bash -c "echo -e 'machine gitlab.k3d.gitlab.com:8082\nlogin root\npassword ${GITLAB_PASS}' > /root/.netrc"

# Set strict permissions
sudo chmod 600 /root/.netrc

# clone the gitlab repo
git clone http://gitlab.k3d.gitlab.com:8082/root/simple-gitlab-app.git gitlab_repo