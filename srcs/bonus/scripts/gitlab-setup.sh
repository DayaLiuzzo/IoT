source .env

# solo install
sudo apt-get update
sudo apt-get install -y curl ca-certificates tzdata perl
sudo debconf-set-selections <<< "openssh-server openssh/keep_the_local_version_currently_installed boolean true"
echo "postfix postfix/mailname string $GITLAB_MAIL" | sudo debconf-set-selections
echo "postfix postfix/main_mailer_type string 'Internet Site'" | sudo debconf-set-selections
sudo apt*get install -y   openssh-server
sudo apt-get install -y postfix
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash

# actual installation
sudo GITLAB_ROOT_EMAIL="$GITLAB_MAIL" GITLAB_ROOT_PASSWORD="$GITLAB_PASS" EXTERNAL_URL="$GITLAB_URL" apt install gitlab-ee

# help install
# helm repo add gitlab https://charts.gitlab.io/
# helm repo update
# helm upgrade --install gitlab gitlab/gitlab --namespace gitlab \
# --timeout 600s \
# --set global.hosts.domain="$GITLAB_URL" \
# --set global.hosts.https=true \
# --set certmanager.install=false \
# --set global.ingress.configureCertmanager=false \
# --set global.ingress.tls.secretName=lab-tls \
# -f value.yaml