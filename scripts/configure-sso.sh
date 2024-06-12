#!/bin/bash

# Configure local profiles for each AWS account in an organization.

# Notes:
#   - This script assumes existing access to the management account. If no profile is
#     configured, then use the temporary environment variables provided by clicking on
#     'Access keys' in the AWS (SSO) access portal. This script will automatically unset
#     those environment variables at the end, regardless of whether they are used, since
#     they take precedence over profiles.

usage() {
  cat << EOF
Usage: $0 ROLE

Required Arguments:
ROLE                      Configure profiles using ROLE.

Environment Variables:
AWS_SSO_SESSION_NAME      Set the session name for all profiles. Default is 'default'.
AWS_SSO_REGION            Set the region for all profiles. Default is 'us-east-1'.
EOF
}

role=$1
session_name=${AWS_SSO_SESSION_NAME:-default}
region=${AWS_SSO_REGION:-us-east-1}

[[ -z "${role}" ]] && { usage; exit 1; }

profile_name=$(echo "${role}" | tr '-' '_')

if [[ -z $(cat ~/.aws/config | grep "^\[sso-session ${session_name}\]$") ]]; then
  echo "Configuring SSO session '${session_name}'..."
  read -p 'SSO Start Url: ' start_url
  cat << EOF >> ~/.aws/config
[sso-session ${session_name}]
sso_start_url = ${start_url}
sso_region = ${region}
sso_registration_scopes = sso:account:access
EOF
fi

# login
aws sso login --sso-session "${session_name}"

# configure roles for each account
for account in $(
  aws organizations list-accounts \
    --query 'sort_by(Accounts, &Name)[?Status==`ACTIVE`].[Id, Name]' \
    | jq -c '.[]' \
    | tr ' ' '_'
); do
  account_id=$(echo "${account}" | jq -r '.[0]');
  account_name=$(echo "${account}" | jq -r '.[1]');

  echo "Configuring profile for ${account_name} account with ${role} role..."

  # replace spaces with underscores
  profile_slug=$(echo "${session_name}-${role}-${account_name}" | tr ' ' '_')

  aws configure set sso_session "${session_name}" --profile "${profile_slug}"
  aws configure set sso_account_id "${account_id}" --profile "${profile_slug}"
  aws configure set sso_role_name "${role}" --profile "${profile_slug}"
  aws configure set region "${region}" --profile "${profile_slug}"
done

unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
