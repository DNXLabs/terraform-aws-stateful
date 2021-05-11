
echo "### SETUP EFS"

yum update -y
yum install -y amazon-efs-utils

EFS_DIR=${efs_mount_dir}

if [ -z "$${EFS_DIR}" ]; then
    EFS_DIR=/mnt/efs
fi

EFS_ID=${efs_id}

mkdir -p $${EFS_DIR}
echo "$${EFS_ID}:/ $${EFS_DIR} efs tls,_netdev" >> /etc/fstab
mount -a -t efs defaults