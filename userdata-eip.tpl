INSTANCE_ID=$(curl -w '\n' -s http://169.254.169.254/latest/meta-data/instance-id)
aws --region ${region} ec2 associate-address --allocation-id ${eip_id} --instance-id $INSTANCE_ID