
echo "### SETUP CLOUDWATCH LOGS AGENT"

yum update -y
yum install -y awslogs amazon-cloudwatch-agent

# UNTESTED CODE BELOW
cat <<EOF >> /tmp/cwlogs-config.json
{
  "agent": {
    "run_as_user": "cwagent"
  },
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": ${jsonencode([
          for log_file in log_files: {
            "file_path": "${log_file}",
            "log_group_name": "/ec2/${name}",
            "log_stream_name": "${log_file}"
          }
        ])}
      }
    }
  }
}
EOF

amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/tmp/cwlogs-config.json -s