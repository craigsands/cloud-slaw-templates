#!/bin/bash

default_vpc_ids=$(
  aws ec2 describe-vpcs \
    --query 'Vpcs[?IsDefault==`true`].VpcId' \
    --output text \
    | xargs
)

for vpc_id in $(echo "${default_vpc_ids}" | xargs); do
  igw_ids=$(
    aws ec2 describe-internet-gateways \
      --filters "Name=attachment.vpc-id,Values=[${vpc_id}]" \
      --query 'InternetGateways[].InternetGatewayId' \
      --output text \
      | xargs
  )

  subnet_ids=$(
    aws ec2 describe-subnets \
      --filters "Name=vpc-id,Values=[${vpc_id}]" \
      --query 'Subnets[].SubnetId' \
      --output text \
      | xargs
  )

  echo "You're about to delete the default VPC with VpcId='${default_vpc_ids}'."
  if [[ $igw_ids == igw-* ]]; then
    echo "This will also delete internet gateways: ${igw_ids}."
  fi
  if [[ $subnet_ids == subnet-* ]]; then
    echo "This will also delete subnets: ${subnet_ids}."
  fi

  read -r -p "Are you sure? [y|N] "
  if [[ $REPLY =~ ^[Yy](es)*$ ]]; then
    for igw_id in ${igw_ids}; do
      aws ec2 detach-internet-gateway --internet-gateway-id "${igw_id}" --vpc-id "${vpc_id}"
      aws ec2 delete-internet-gateway --internet-gateway-id "${igw_id}"
    done
    for subnet_id in ${subnet_ids}; do
      aws ec2 delete-subnet --subnet-id "${subnet_id}"
    done
    aws ec2 delete-vpc --vpc-id "${vpc_id}"
  fi
done
