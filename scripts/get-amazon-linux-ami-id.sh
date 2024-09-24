#!/bin/bash

image_id=$(aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64 | jq -r '.Parameters[0].Value')
echo "The latest Amazon Linux 2023 image ID is '${image_id}'."
