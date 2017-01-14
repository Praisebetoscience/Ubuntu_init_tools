#!/bin/bash

curl -o /usr/local/bin/docker-compose -L "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)"
chmod +x /usr/local/bin/docker-compose
docker-compose -v

