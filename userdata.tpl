#! /bin/bash

set -eux

# echo "### INSTALL PACKAGES"
# yum update -y
# yum install -y amazon-efs-utils aws-cli httpd

${efs}

${eip}

${ebs}

${userdata_extra}