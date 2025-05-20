sudo apt update

#Vagrant Configuration
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vagrant



echo "Installing VirtualBox dependencies..."

# Update first
sudo apt update

# Install VirtualBox and dependencies
sudo apt install -y virtualbox virtualbox-dkms dkms build-essential linux-headers-$(uname -r)

# Optional: Force rebuild of VirtualBox kernel modules
echo "Reconfiguring DKMS modules..."
sudo dpkg-reconfigure virtualbox-dkms

# Load kernel module
echo "Loading VirtualBox kernel module..."
sudo modprobe vboxdrv

# OPTIONAL: Reboot manually after script finishes
echo "✅ VirtualBox setup complete. Reboot manually if needed."
