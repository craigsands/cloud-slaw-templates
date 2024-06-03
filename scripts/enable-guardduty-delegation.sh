#!/bin/bash

# Notes:
#   - This script should be run with AdministratorAccess credentials in the Management account
#   - Other than slight tweaks, this script was written by Chris Farris, and taken from
#     https://github.com/primeharbor/aws-account-automation/blob/master/scripts/enable_guardduty_delegation.sh
#
# Modifications:
#   - We only need to enable GuardDuty in 2 regions, since we have an SCP blocking all others

# Script to enable Delegated Admin in a management account for all GuardDuty Regions

GD_ACCOUNT=$1

if [ -z $GD_ACCOUNT ] ; then
	echo "Usage: $0 <account_id_of_account_to_run_guardduty>"
	exit 1
fi

REGIONS='us-east-1 us-west-2'
for r in $REGIONS ; do
  echo "Enabling GuardDuty Delegated Admin in $r"
  aws guardduty enable-organization-admin-account --admin-account-id $GD_ACCOUNT --region $r

  DETECTOR=`aws guardduty list-detectors --query DetectorIds[] --output text --region $r `
  if [ -z $DETECTOR ] ; then
    echo "Creating a Detector in the Organizations Management account in $r"
    DETECTOR=`aws guardduty create-detector  --output text --region $r --finding-publishing-frequency ONE_HOUR --enable`
    if [ -z $DETECTOR ] ; then
      echo "Failed to create a detector in $r. Aborting script"
      exit 1
    fi
  fi

done
