#!/bin/bash

# Export the region if no default is configured
# export AWS_REGION='us-west-2'

account_id=$(
  aws organizations list-accounts \
    --query 'Accounts[?Name==`SecurityAudit`].Id' \
    --output text
)
aws cloudtrail register-organization-delegated-admin \
  --member-account-id="${account_id}"
