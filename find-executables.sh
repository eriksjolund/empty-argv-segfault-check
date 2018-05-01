#!/usr/bin/env bash

extra_arguments=""

if [ "$#" -eq 1 ]; then
  if [ $1 = "setuid" ]; then
    extra_arguments="-perm /4000"
  fi
fi

sudo find / \
     -path /proc -prune \
  -o -path /sys  -prune \
  -o -path /run  -prune \
  -o -path /var/lib/lxd/storage-pools -prune \
  -o -path /home -prune \
  -o -path /tmp -prune \
  -o -path /var/tmp -prune \
  -o -type f -perm -u=x $extra_arguments -print
