# This script setup a simple NFS server for testing
# Tested on Fedora 21
#
#!/bin/bash

if [ ! ${UID} -eq 0 ]; then
    echo "Please switch to root."
    exit 1
fi

# Make volume
dd if=/dev/zero of=/dev/nfs bs=1G count=10
mkfs -t ext4 /dev/nfs
mkdir /nfs
mount /dev/nfs /nfs

# Install packages and start services
yum -y install nfs-utils nfs-utils-lib
systemctl start rpcbind
systemctl start nfs

# Make configurations
echo '/nfs *(rw,sync,no_root_squash,insecure)' >> /etc/exports
exportfs -a
