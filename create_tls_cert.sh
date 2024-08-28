#!/bin/bash

echo "This script helps you create and configure Kopia repository server container."
echo
echo "Enter repository name used for naming cert and key files:"
read repo_name
echo
echo "Enter host directory path to save cert and key files:"
read vault_path

docker run -it --rm \
    -v $vault_path:/vault \
    kopia/kopia:latest \
    server start \
    --tls-generate-cert \
    --tls-cert-file /vault/$repo_name.cert \
    --tls-key-file /vault/$repo_name.key