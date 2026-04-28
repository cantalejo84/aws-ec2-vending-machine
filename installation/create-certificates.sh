#!/bin/bash
# Run as ec2-user (not root)

CERT_DIR="$HOME/.config/node-opcua-default-nodejs/PKI/own"
mkdir -p "$CERT_DIR/certs" "$CERT_DIR/private"

openssl req -x509 \
  -newkey rsa:2048 \
  -keyout "$CERT_DIR/private/private_key.pem" \
  -out "$CERT_DIR/certs/certificate.pem" \
  -days 3650 \
  -nodes \
  -subj "/CN=DemoOPCUAServer/O=Demo/C=ES"

echo "Certificates generated at $CERT_DIR"
