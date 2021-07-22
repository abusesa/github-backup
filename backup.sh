#!/bin/sh

BACKUP_DIR="/home/docker/backups"

echo "Project: github-backup"
echo "Author:  lnxd"
echo "Base:    Alpine 3.9"
echo "Target:  Unraid"
echo ""

# If config doesn't exist yet, create it
if [ ! -f /home/docker/github-backup/config/config.json ]; then
    cp /home/docker/github-backup/config.json.example /home/docker/github-backup/config/config.json
fi

# Update config.json
cp /home/docker/github-backup/config/config.json /home/docker/github-backup/config.json

# Update token in config.json match $TOKEN environment variable
sed -i '/token/c\   \"token\" : \"'${TOKEN}'\",' /home/docker/github-backup/config.json

# Update backup directory to match the containers default
sed -i '/directory/c\   \"directory\" : \"'${BACKUP_DIR}'\",' /home/docker/github-backup/config.json

# Start backup
while true
 do python3 github-backup.py /home/docker/github-backup/config/config.json
 chown -R nobody ${BACKUP_DIR}
 sleep "$SCHEDULE"
done