# aws-ec2-vending-machine

One-click EC2 deployments via GitHub Actions. Each branch is a self-contained deployment type.

## Branches

| Branch | Workload | Open ports | Install | OS supported |
|---|---|---|---|---|
| `ec2-default` | Bare EC2 + SSM (no software) | none (SSM only) | — | `amazon-linux`, `ubuntu` |
| `docker-compose` | Docker + Compose v2 + Buildx | none (SSM only) | auto (UserData) | `amazon-linux` only |
| `opcua-server` | OPC UA demo server (node-opcua) | 4840/tcp | manual (scripts) | `amazon-linux` only |

## Setup

Add to GitHub repository secrets:
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

Region: `eu-west-1` (change `AWS_REGION` in the workflow to override).

## Usage

1. Switch to the branch for the EC2 type you want
2. Actions → Deploy EC2 → Run workflow
3. Set `stack_name`, `instance_type` and `os` (`amazon-linux` = Amazon Linux 2023, `ubuntu` = Ubuntu 26.04 LTS; both x86_64). AMI IDs are pinned in the workflow's `Resolve AMI` step — edit there to bump versions.
4. To tear down: same workflow with `action = destroy`

## Adding a new branch

1. `git checkout -b <new-type>` from this branch
2. Add `iac/template.yml` (CloudFormation)
3. Add `installation/` scripts if needed
4. Write `README.md`
