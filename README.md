# opcua-server EC2

EC2 with an OPC UA demo server (node-opcua) on Amazon Linux 2023. SSM + port 4840 open.

Endpoint: `opc.tcp://<PUBLIC_IP>:4840/UA/DemoServer`

Variables: Temperature, Pressure, FanSpeed, PumpSpeed, TankLevel, MachineState, Counter, ServerTime.

## Deploy

Actions → Deploy EC2 → Run workflow:

| Input | Value |
|---|---|
| `action` | `deploy` |
| `stack_name` | e.g. `opcua-demo` |
| `instance_type` | **t3.small** (default) |
| `os` | **`amazon-linux`** (only supported value — install scripts use `dnf`) |

> The `os` input also accepts `ubuntu`, but the workflow fails fast on this branch — the install scripts are Amazon-Linux-only.

## Install the server

After the stack is deployed:

1. Connect: AWS Console → Systems Manager → Session Manager → Start session
2. Download scripts:
   ```
   REPO="https://raw.githubusercontent.com/<YOUR_USER>/aws-ec2-vending-machine/opcua-server/installation"
   sudo curl -O $REPO/install-opcua.sh
   sudo curl -O $REPO/server.js
   curl -O $REPO/create-certificates.sh
   sudo curl -O $REPO/setup-service.sh
   ```
3. Install Node.js + node-opcua: `sudo bash install-opcua.sh`
4. Copy server: `sudo cp server.js /opt/opcua-server/`
5. Generate certificates (as ec2-user): `bash create-certificates.sh`
6. Configure systemd service: `sudo bash setup-service.sh`
7. Start: `sudo systemctl start opcua-server`
8. Check: `sudo journalctl -u opcua-server -f`

## Connect a client

**UaExpert**: Add server → `opc.tcp://<PUBLIC_IP>:4840/UA/DemoServer`

**Python (opcua-asyncio)**:
```python
from asyncua import Client
async with Client("opc.tcp://<PUBLIC_IP>:4840/UA/DemoServer") as client:
    node = await client.nodes.root.get_child(["0:Objects", "1:Simulation", "1:Temperature"])
    print(await node.read_value())
```

## Destroy

Same workflow, `action = destroy`.

## Secrets required

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
