#!/bin/bash

# save the backup
ETCDCTL_API=3 etcdctl snapshot save etcd_backup.db \
--endpoints=https://$etcd_server_ip:2379 \
--cacert=$path_to_cacert/etcd-ca.pem \
--cert=$path_to_crt/etcd-server.crt \
--key=$path_to_key/etcd-server.key