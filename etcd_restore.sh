#!/bin/bash

# make sure etcd is stopped
sudo systemctl stop etcd

# restore to a temporary etcd cluster
ETCDCTL_API=3 etcdctl snapshot restore etcd_backup.db \
--initial-cluster etcd-restore=https://$etcd_server_ip:2380 \
--initial-advertise-peer-urls https://$etcd_server_ip:2380 \
--name etcd-restore-tmp \
--data-dir /var/lib/etcd

# make etcd the owner of the data directory
chown -R etcd:etcd /var/lib/etcd

# verify that the cluster is restored
ETCDCTL_API=3 etcdctl get cluster.name \
--endpoints=https://$etcd_server_ip:2379 \
--cacert=$path_to_cacert/etcd-ca.pem \
--cert=$path_to_crt/etcd-server.crt \
--key=$path_to_key/etcd-server.key