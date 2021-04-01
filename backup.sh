#!/bin/sh

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

# Return config.json to persistant volume
cp /home/docker/github-backup/config.json /home/docker/github-backup/config/config.json

# Start backup
while true
 do python3 github-backup.py /home/docker/github-backup/config/config.json
 chown -R nobody /home/docker/backups
 sleep $SCHEDULE
done