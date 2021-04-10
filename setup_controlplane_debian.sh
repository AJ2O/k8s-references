#!/bin/bash

# initialize cluster
sudo kubeadm init --pod-network-cidr 192.168.0.0/16

# set up kubectl access
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# verify kubectl is working
kubectl version

# install Calico add-on for configuring cluster networking
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

# get the join command for the worker nodes
kubeadm token create --print-join-command

# TODO: join the nodes to the cluster

# verify node connection
kubectl get nodes