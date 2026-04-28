#!/bin/bash
# Usage: sudo bash install-opcua.sh

set -e

if [ "$EUID" -ne 0 ]; then
  echo "Run as root: sudo bash install-opcua.sh"
  exit 1
fi

echo "Installing OPC UA demo server..."

yum update -y

curl -fsSL https://rpm.nodesource.com/setup_20.x | bash -
yum install -y nodejs openssl

mkdir -p /opt/opcua-server
cd /opt/opcua-server

cat > package.json << 'EOF'
{
  "name": "opcua-demo-server",
  "version": "1.0.0",
  "main": "server.js",
  "dependencies": {
    "node-opcua": "^2.119.0"
  }
}
EOF

npm install

echo ""
echo "Done. Next steps:"
echo "  1. Copy server.js to /opt/opcua-server/"
echo "  2. Run create-certificates.sh as ec2-user"
echo "  3. Run setup-service.sh as root"
echo "  4. systemctl start opcua-server"
