#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Please use sudo."
    exit 1
fi

echo "This script helps you generate cert and key files for Kopia repository server."
echo
echo "Enter repository name used for naming cert and key files:"
read repo_name
echo
echo "Enter host directory path to save cert and key files:"
read vault_path
echo
echo "Specify the owner of the files in UID:GID format (e.g., 1000:1000):"
read owner

docker run -d \
    --name temp_kopia \
    -v $vault_path:/vault \
    kopia/kopia:latest \
    server start \
    --tls-generate-cert \
    --tls-cert-file /vault/$repo_name.cert \
    --tls-key-file /vault/$repo_name.key \
    > /dev/null 2>&1
echo "Created Kopia container."

while true; do
    if [ -e "$vault_path/$repo_name.cert" ] && [ -e "$vault_path/$repo_name.key" ]; then
        echo "Created cert and key files!"
        docker stop temp_kopia > /dev/null 2>&1
        echo "Stopped Kopia container."
        docker rm temp_kopia > /dev/null 2>&1
        echo "Removed Kopia container."
        break
    fi
    sleep 3
done

chown $owner $vault_path/$repo_name.cert $vault_path/$repo_name.key 
echo "Changed the owner of cert and key files.