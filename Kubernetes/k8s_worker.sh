## Script for Worker Node
```bash
#!/bin/bash

echo ".........----------------#################._.-.-INSTALLING KUBERNETES (WORKER NODE)-.-._.#################----------------........."

# Update and install dependencies
apt-get update
apt-get install -y curl apt-transport-https ca-certificates gnupg lsb-release

# Configure Kubernetes package repository
KUBE_LATEST=$(curl -L -s https://dl.k8s.io/release/stable.txt | awk 'BEGIN { FS="." } { printf "%s.%s", $1, $2 }')
mkdir -p /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/${KUBE_LATEST}/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/${KUBE_LATEST}/deb/ /" > /etc/apt/sources.list.d/kubernetes.list

# Update package list and install Kubernetes components
apt-get update
apt-get install -y kubelet kubectl kubeadm kubernetes-cni containerd

# Configure containerd
mkdir -p /etc/containerd
containerd config default | sed 's/SystemdCgroup = false/SystemdCgroup = true/' > /etc/containerd/config.toml
systemctl restart containerd
systemctl enable kubelet

# Reset kubeadm (in case of reconfiguration)
kubeadm reset -f

echo ".........----------------#################._.-.-KUBERNETES WORKER NODE INSTALLATION COMPLETED-.-._.#################----------------........."
```