# cloud-slaw-templates

CloudFormation templates for Cloud Security Lab a Week (S.L.A.W.)

## Notes

1. I'd like to thank Rich for creating [this blog](https://slaw.securosis.com/). I understand that each organization
   has unique elements to it, but I love the idea of 'bootstrapping' new (or even existing)
   organizations with common conventions of the security community. This repository is
   designed to help in that end.
2. These templates will attempt to follow the labs, especially from the sense that they
   are designed to be atomic in nature. However, rather than be representative of
   "snapshots in time," they can build off each other (using references) when possible, or
   where it makes sense, combined (as in one template being the result of multiple labs).
   In order to preserve as much of the lab "flow" as possible, the templates will be
   organized by lab in the outline below, in roughly reverse chronological order.

## Outline

| Posted Date | Lab Name                                                              | Templates                                                                                                                                                                                                                                                                                                                                      |
| ----------- | --------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 2024-08-15  | Run Our First Instance (FINALLY!)                                     | [EC2Instance](./accounts/TestAccount1/EC2Instance.template) (depends on [BasicVPCWithSSM](./accounts/TestAccount1/BasicVPCWithSSM.template), adapted from https://cloudslaw.s3.us-west-2.amazonaws.com/basicvpcwithssm.template to include additional outputs.)                                                                                                               |
| 2024-08-08  | Harness the Magic of Security Groups                                  | [SecurityGroups](./accounts/TestAccount1/SecurityGroups.template)                                                                                                                                                                                                                                                                              |
| 2024-08-01  | Build a VPC with IaC and Maybe TLC                                    | [CloudSLAWVPC](./accounts/TestAccount1/CloudSLAWVPC.template)                                                                                                                                                                                                                                                                                  |
| 2024-07-25  | NAT Your Way to Privacy (and Maybe Poverty)                           | ~~[NATWithPrivateSubnets](./accounts/TestAccount1/NATWithPrivateSubnets.template)~~ superseded by [CloudSLAWVPC](./accounts/TestAccount1/CloudSLAWVPC.template)                                                                                                                                                                                |
| 2024-07-18  | Build a VPC from Scratch                                              | ~~[VPCWithPublicSubnets](./accounts/TestAccount1/VPCWithPublicSubnets.template)~~ superseded by [CloudSLAWVPC](./accounts/TestAccount1/CloudSLAWVPC.template)                                                                                                                                                                                  |
| 2024-07-11  | Journey to the Center of the VPC: Getting Started with Cloud Networks | [delete-default-vpc.sh](./scripts/delete-default-vpc.sh)                                                                                                                                                                                                                                                                                       |
| 2024-06-27  | Permissions Boundaries Made Easy                                      | [IdentityCenterAdministration](./accounts/IAM/IdentityCenterAdministration.template)<br />Note, due to limitations of CloudFormation, the boundary policy references the permission set, and must be added to the permission set manually.                                                                                                     |
| 2024-06-20  | Skills Solution: IAM Identity Center                                  | [IdentityCenterAdministration](./accounts/IAM/IdentityCenterAdministration.template)                                                                                                                                                                                                                                                           |
| 2024-06-06  | PBAC and ABAC? Write an Intermediate AWS IAM Policy                   | [DeleteMePleaseNow](./accounts/TestAccount1/DeleteMePleaseNow.template)                                                                                                                                                                                                                                                                        |
| 2024-05-30  | Use EventBridge for Security Hub Alerts                               | [SecurityHubAlerts](./accounts/Management/SecurityHubAlerts.template)                                                                                                                                                                                                                                                                          |
| 2024-05-23  | The Best Way to Start with AWS Security Hub                           | [SecurityHubDelegation](./accounts/Management/SecurityHubDelegation.template), [SecurityHubOrganizationConfiguration](./accounts/SecurityAudit/SecurityHubOrganizationConfiguration.template)                                                                                                                                                  |
| 2024-05-16  | Enable GuardDuty the Right Way                                        | [enable-guardduty-delegation.sh](./scripts/enable-guardduty-delegation.sh), [configure-guardduty-admin-account.sh](./scripts/configure-guardduty-admin-account.sh)                                                                                                                                                                             |
| 2024-05-09  | Creating Security Team Permissions in IAM Identity Center             | [IdentityCenterAdministration](./accounts/IAM/IdentityCenterAdministration.template), [SecurityAdministratorAccess](./accounts/IAM/SecurityAdministratorAccess.template), [SecurityReadOnlyAssignments](./accounts/IAM/SecurityReadOnlyAssignments.template)<br />Note, it's left up to the reader to manually assign their user to the groups |
| 2024-05-02  | Enable Delegated Administrator for Identity Center and CloudTrail     | [delegate-cloudtrail.sh](./scripts/delegate-cloudtrail.sh)<br />Note, the AWS CLI does not yet support delegating administration for IAM Identity Center.                                                                                                                                                                                      |
| 2024-04-25  | Buttoning up the Org                                                  | [WorkloadAccounts](./accounts/Management/WorkloadAccounts.template)                                                                                                                                                                                                                                                                            |
| 2024-04-18  | On the Meaning of Life(cycles), Versions, and Ransomware              | [CloudTrailOrgBucket](./accounts/LogArchive/CloudTrailOrgBucket.template)                                                                                                                                                                                                                                                                      |
| 2024-04-04  | NotWhat?!? Lock Out Regions with a Double Negative SCP                | [RegionLockoutPolicy](./accounts/Management/RegionLockoutPolicy.template)                                                                                                                                                                                                                                                                      |
| 2024-03-28  | OUs, SCPs, and a Root User Account Recovery                           | [ProtectRootAndOrg](./accounts/Management/ProtectRootAndOrg.template)                                                                                                                                                                                                                                                                          |
| 2024-03-21  | AWS LEGO: Organizing the Org                                          | [BasicOrganizationStructure](./accounts/Management/BasicOrganizationStructure.template), [SecurityAccounts](./accounts/Management/SecurityAccounts.template)                                                                                                                                                                                   |
| 2024-03-14  | Another Me? SSO with IAM Identity Center, Part 2                      | [SSOAdministratorAccess](./accounts/Management/SSOAdministratorAccess.template)                                                                                                                                                                                                                                                                |
| 2024-03-07  | Bring in the Fed(eration): SSO                                        | [IdentityCenterAdministratorsGroup](./accounts/Management/IdentityCenterAdministratorsGroup.template)                                                                                                                                                                                                                                          |
| 2024-02-22  | Secure that Bucket! (Centralized Logging: Part 2)                     | [CloudTrailOrgBucketPolicy](./accounts/LogArchive/CloudTrailOrgBucketPolicy.template)                                                                                                                                                                                                                                                          |
| 2024-02-15  | Assume the Role! (Centralized Logging, Part 1)                        | [CloudTrailOrgBucket](./accounts/LogArchive/CloudTrailOrgBucket.template)                                                                                                                                                                                                                                                                      |
| 2024-02-08  | Give Your Account a Security Blanket with SCPs                        | [ProtectRootAndOrg](./accounts/Management/ProtectRootAndOrg.template)                                                                                                                                                                                                                                                                          |
| 2024-02-01  | Enable AWS Organizations                                              | [OrganizationsOrganization](./accounts/Management/OrganizationsOrganization.template), [SecurityAccounts](./accounts/Management/SecurityAccounts.template)                                                                                                                                                                                     |
| 2024-01-18  | Write a Simple IAM Policy                                             | [CloudTrailReadWrite](./accounts/Management/CloudTrailReadWrite.template)                                                                                                                                                                                                                                                                      |
| 2024-01-11  | Create Your First AWS IAM Role                                        | [SSMInstance](./accounts/Management/SSMInstance.template)                                                                                                                                                                                                                                                                                      |
| 2024-12-28  | Timmy's First CloudFormation                                          | Rich provided [this template](https://cloudslaw.s3.us-west-2.amazonaws.com/sns.template?utm_source=slaw.securosis.com&utm_medium=referral&utm_campaign=timmy-s-first-cloudformation) as part of the lab.                                                                                                                                       |
