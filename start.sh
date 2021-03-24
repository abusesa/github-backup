#!/bin/bash

docker stop github-backup
docker build . -t github-backup
docker rm 'github-backup'
docker run -d --name='github-backup' -e TZ="Australia/Melbourne" -e TOKEN="e629868d6bc782fae88508e8eee9ef7647575490" -e SCHEDULE="3600" -v $PWD/config:/home/docker/github-backup/config -v $PWD/backups:/home/docker/backups github-backup #
docker logs github-backup -f