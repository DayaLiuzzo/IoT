curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --node-ip=192.168.56.110" sh -
sudo cat /var/lib/rancher/k3s/server/node-token > /home/vagrant/srcs/node-token