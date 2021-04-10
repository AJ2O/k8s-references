#!/bin/bash

# drain node
kubectl drain $node --ignore-daemonsets

# upgrade kubeadm to new version
sudo apt-get update && \
sudo apt-get install -y --allow-change-held-packages kubeadm=1.20.2-00

# upgrade the kubelet configuration on this node
sudo kubeadm upgrade node

# upgrade kubelet and kubectl
sudo apt-get update && \
sudo apt-get install -y --allow-change-held-packages kubelet=1.20.2-00 kubectl=1.20.2-00

# restart kubelet
sudo systemctl daemon-reload
sudo systemctl restart kubelet

# uncordon the node
kubectl uncordon $node