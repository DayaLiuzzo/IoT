export K3S_TOKEN=$(cat /vagrant/srcs/node-token)
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent --node-ip=192.168.56.111" K3S_URL="https://192.168.56.110:6443" K3S_TOKEN=$K3S_TOKEN sh -