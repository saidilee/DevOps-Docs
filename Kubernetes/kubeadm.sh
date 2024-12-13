#!/bin/bash

echo ".........----------------#################._.-.-INSTALLING KUBERNETES-.-._.#################----------------........."

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

# Initialize Kubernetes cluster
kubeadm reset -f
kubeadm init --pod-network-cidr='10.244.0.0/16' --service-cidr='10.96.0.0/16' --skip-token-print

# Configure kubectl for the root user
mkdir -p ~/.kube
cp -i /etc/kubernetes/admin.conf ~/.kube/config

# Install a pod network (WeaveNet)
kubectl apply -f "https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s-1.11.yaml"
kubectl rollout status daemonset weave-net -n kube-system --timeout=90s

# Remove taints from the control-plane node to schedule workloads
node=$(kubectl get nodes -o=jsonpath='{.items[0].metadata.name}')
for taint in $(kubectl get node $node -o=jsonpath='{range .spec.taints[*]}{.key}{":"}{.effect}{"-"}{end}')
do
    kubectl taint node $node $taint
done

kubectl get nodes -o wide

echo ".........----------------#################._.-.-KUBERNETES INSTALLATION COMPLETED-.-._.#################----------------........."