#! /bin/bash

set -eux

echo "### INSTALL PACKAGES"
yum update -y
yum install -y amazon-efs-utils aws-cli httpd

echo "### INSTALL SSM AGENT"
cd /tmp
yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
systemctl restart amazon-ssm-agent

echo "### SETUP EFS"

EFS_DIR=${custom_efs_dir}

if [ -z "$${EFS_DIR}" ]; then
    EFS_DIR=/mnt/efs
fi

EFS_ID=${tf_efs_id}

mkdir -p $${EFS_DIR}
echo "$${EFS_ID}:/ $${EFS_DIR} efs tls,_netdev" >> /etc/fstab
mount -a -t efs defaults

echo "### SETUP AGENT"

echo "### SETUP APACHE"
touch /var/www/html/index.html
systemctl restart httpd

${userdata_extra}