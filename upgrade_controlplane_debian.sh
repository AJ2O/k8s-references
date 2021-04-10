#!/bin/bash

# drain node
kubectl drain $node --ignore-daemonsets

# upgrade kubeadm to new version
sudo apt-get update && \
sudo apt-get install -y --allow-change-held-packages kubeadm=1.20.2-00

# plan the upgrade
sudo kubeadm upgrade plan v1.20.2

# apply the upgrade
sudo kubeadm upgrade apply v1.20.2

# upgrade kubelet and kubectl
sudo apt-get update && \
sudo apt-get install -y --allow-change-held-packages kubelet=1.20.2-00 kubectl=1.20.2-00

# restart kubelet
sudo systemctl daemon-reload
sudo systemctl restart kubelet

# uncordon the node
kubectl uncordon $node

# verify that the upgraded control plane is working
kubectl get nodes