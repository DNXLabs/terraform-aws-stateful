
echo "### SETUP EBS"

EBS_DIR=${ebs_mount_dir}

if [ -z "$${EBS_DIR}" ]; then
    EBS_DIR=/mnt/ebs
fi

EBS_ID=${ebs_id}

INSTANCE_ID="`wget -q -O - http://169.254.169.254/latest/meta-data/instance-id || die \"wget instance-id has failed: $?\"`"
AZ="`wget -q -O - http://169.254.169.254/latest/meta-data/placement/availability-zone || die \"wget availability-zone has failed: $?\"`"
AWS_REGION="`echo \"$AZ\" | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`"

aws ec2 attach-volume --region $${AWS_REGION} --volume-id $${EBS_ID} --instance-id $${INSTANCE_ID} --device /dev/sdf

aws ec2 wait volume-in-use --volume-ids $${EBS_ID}

VOLUME=/dev/nvme1n1

# Format if it does not contain a partition yet
if [ "`file -b -s $${VOLUME}`" == "data" ]; then
  echo mkfs -t ext4 $${VOLUME}
fi

mkdir -p $${EBS_DIR}
mount $${VOLUME} $${EBS_DIR}

# Persist the volume in /etc/fstab so it gets mounted again
echo '$${VOLUME} $${EBS_DIR} ext4 defaults,nofail 0 2' >> /etc/fstab