#!/bin/bash

echo 'Set access token by visiting https://github.com/settings/tokens to get your token, and then running:'
echo 'ACCESSTOKEN="yourtoken"'
echo 'Current accesstoken: ${ACCESSTOKEN}'

docker stop github-backup
docker build . -t github-backup
docker rm 'github-backup'
docker run -d --name='github-backup' -e TZ="Australia/Melbourne" -e TOKEN="14f826e69c75663d2af654316a835e6e2a5543fb" -e SCHEDULE="3600" -v $PWD/config:/home/docker/github-backup/config -v $PWD/backups:/home/docker/backups github-backup #
docker logs github-backup -f