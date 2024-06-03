#!/bin/bash

# Notes:
#   - This script expects enable-guardduty-delegation.sh to be ran first
#   - This script should be run with SecurityFullAdmin credentials in the SecurityAudit account
#   - Most of the code for this script was written by Chris Farris, and taken from
#     https://github.com/primeharbor/aws-account-automation/blob/master/scripts/configure_guardduty_admin_account.sh
#
# Modifications:
#   - We only need to enable GuardDuty in 2 regions, since we have an SCP blocking all others
#   - Since this is for a lab environment, new detectors will have a ONE_HOUR publishing frequency

# Script to enable GuardDuty in each region in the Delegated Admin Account

# We need to get a list of the accounts to then add as members. This actually comes from the Organizations API which we now have access to as a Delegated Admin Child
aws organizations list-accounts | jq '[ .Accounts[] | { AccountId: .Id, Email: .Email } ]' > ACCOUNT_INFO.txt

REGIONS='us-east-1 us-west-2'
for r in $REGIONS ; do
  echo "Enabling GuardDuty Delegated Admin in $r"
  DETECTOR=`aws guardduty list-detectors --query DetectorIds[] --output text --region $r `
  if [ -z $DETECTOR ] ; then
    echo "No detector in $r, creating one"
    DETECTOR=`aws guardduty create-detector  --output text --region $r --finding-publishing-frequency ONE_HOUR --enable`
    if [ -z $DETECTOR ] ; then
      echo "Failed to create a detector in $r. Aborting script"
      exit 1
    fi
  fi

  echo "Detector $DETECTOR in $r"
  aws guardduty update-organization-configuration --detector-id $DETECTOR --auto-enable-organization-members ALL --region $r
  aws guardduty create-members --detector-id $DETECTOR --account-details file://ACCOUNT_INFO.txt --region $r
done

# cleanup
rm ACCOUNT_INFO.txt
