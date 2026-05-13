# docker-compose EC2

EC2 with Docker, Docker Compose v2 and Buildx on Amazon Linux 2023. SSM-only access (no SSH).

## Deploy

Actions → Deploy EC2 → Run workflow:

| Input | Value |
|---|---|
| `action` | `deploy` |
| `stack_name` | e.g. `my-docker-ec2` |
| `instance_type` | t3.micro / **t3.small** / t3.medium |
| `os` | **`amazon-linux`** (only supported value — UserData uses `dnf`) |

> The `os` input also accepts `ubuntu`, but the workflow fails fast on this branch — the UserData is Amazon-Linux-only. Use the `ec2-default` branch if you need an Ubuntu base.

## Connect

AWS Console → Systems Manager → Session Manager → Start session → select instance.

CLI:
```
aws ssm start-session --target <instance-id> --region eu-west-1
```

## Destroy

Same workflow, `action = destroy`.

## What gets installed

- Docker (systemd service, ec2-user added to docker group)
- Docker Compose v2.32.4 plugin + `docker-compose` legacy symlink
- Docker Buildx v0.21.0
- Git

## Secrets required

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
