#!/bin/bash
# Usage: sudo bash setup-service.sh

set -e

if [ "$EUID" -ne 0 ]; then
  echo "Run as root: sudo bash setup-service.sh"
  exit 1
fi

cat > /etc/systemd/system/opcua-server.service << 'EOF'
[Unit]
Description=OPC UA Demo Server
After=network.target

[Service]
Type=simple
User=ec2-user
WorkingDirectory=/opt/opcua-server
ExecStart=/usr/bin/node /opt/opcua-server/server.js
Restart=always
RestartSec=10
StandardOutput=journal
StandardError=journal
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable opcua-server

echo "Service configured. Run: systemctl start opcua-server"
echo "Logs: journalctl -u opcua-server -f"
