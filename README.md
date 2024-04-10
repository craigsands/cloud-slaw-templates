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

| Posted Date | Lab Name                                          | Templates                                                                                                                              |
| ----------- | ------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| 2024-03-07  | Bring in the Fed(eration): SSO                    | [IdentityCenterAdministratorsGroup](./templates/IdentityCenterAdministratorsGroup.template)                                            |
| 2024-02-22  | Secure that Bucket! (Centralized Logging: Part 2) | [CloudTrailOrgBucketPolicy](./templates/CloudTrailOrgBucketPolicy.template)                                                            |
| 2024-02-15  | Assume the Role! (Centralized Logging, Part 1)    | [CloudTrailOrgBucket](./templates/CloudTrailOrgBucket.template)                                                                        |
| 2024-02-08  | Give Your Account a Security Blanket with SCPs    | [ProtectRootAndOrg](./templates/ProtectRootAndOrg.template)                                                                            |
| 2024-02-01  | Enable AWS Organizations                          | [OrganizationsOrganization](./templates/OrganizationsOrganization.template), [SecurityAccounts](./templates/SecurityAccounts.template) |
| 2024-01-18  | Write a Simple IAM Policy                         | [CloudTrailReadWrite](./templates/CloudTrailReadWrite.template)                                                                        |
| 2024-01-11  | Create Your First AWS IAM Role                    | [SSMInstance](./templates/SSMInstance.template)                                                                                        |
