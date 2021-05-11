
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