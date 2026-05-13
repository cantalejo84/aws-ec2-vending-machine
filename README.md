# ec2-default

Bare EC2 instance with SSM access. No software preinstalled. Use this as the starting point for new flavors.

## What you get

- EC2 instance (default `t3.small`)
- IAM role with `AmazonSSMManagedInstanceCore` (connect via Session Manager)
- Security group with egress only (no inbound)
- Outputs: `InstanceId`, `PublicIP`

## Deploy

Actions → Deploy EC2 → Run workflow:

- `stack_name` — CloudFormation stack name
- `instance_type` — `t3.micro` / `t3.small` / `t3.medium`
- `os` — `amazon-linux` (Amazon Linux 2023) or `ubuntu` (Ubuntu 26.04 LTS), both x86_64

Region is fixed to `eu-west-1`. AMI IDs are hardcoded in the workflow (see `Resolve AMI` step) — edit the workflow to bump to a newer image.

## Destroy

Same workflow with `action = destroy`.

## Connect

```
aws ssm start-session --target <InstanceId> --region eu-west-1
```
