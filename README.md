## Notes
- This configuration is intended for WSL2.
- [Docker desktop does not support bind propagation](https://docs.docker.com/storage/bind-mounts/#configure-bind-propagation), so this setting does not mount path for browsing mounted snapshot.
- You can adjust bind mount and `.env` file if:
  - you are not using local or network-attached repository.
  - you need to add or remove backup locations.

## Issues
- Cannot log in to Web UI using username other than server control username.
- Web UI is accessible only when server control username is 'kopia'.

## Instruction
Before running Kopia repository server, you should create TLS certificate and key. If you have a certificate from CA, you can pass this step and move cert and key to `${VAULT_PATH}/${REPO_NAME}.cert` and `${VAULT_PATH}/${REPO_NAME}.key` (See below for env meaning).
```
./create_tls_cert.sh
```

You should duplicate `.env.sample` and rename the copy to `.env`. Then, adjust the `.env` file to fit your configuration.
- `KOPIA_PASSWORD`: Kopia respository password
- `KOPIA_SERVER_CONTROL_PASSWORD`: Password for the user primarily managing KopiaUI
- `VAULT_PATH`: Path of a directory that has cert and key files in it
- `REPO_NAME`: Used to name cert and key files

To run Kopia repository server:
```
docker compose up
```

To create Kopia filesystem repository:
```
docker exec -it Kopia kopia create filesystem --path /repository
```

To connect to Kopia filesystem repository:
```
docker exec -it Kopia kopia repository connect filesystem --path /repository
```