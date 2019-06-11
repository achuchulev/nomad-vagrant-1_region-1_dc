#!/usr/bin/env bash

# adjust interfce if not named eth0
[ -d /etc/nomad.d/ ] && {
  IFACE=`route -n | awk '$1 ~ "192.168.*.*" {print $8}'`
  sed -i "s/eth0/${IFACE}/g" /etc/nomad.d/*.hcl
}

systemctl restart nomad.service