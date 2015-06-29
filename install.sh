#!/bin/bash

# Stop running DeployIt (just in case)
docker-compose stop

# Rebuild containers
docker-compose build web
docker-compose build sidekiq
docker-compose build ssh

# Spin-up DeployIt
exec docker-compose up &

# Create directories with deploy-it as owner
docker-compose run web mkdir -p /data/applications-clones
docker-compose run web mkdir -p /data/applications-repositories
docker-compose run web chown deploy-it.deploy-it /data/applications-clones
docker-compose run web chown deploy-it.deploy-it /data/applications-repositories

# Create directories with root as owner
docker-compose run web mkdir -p /data/applications-datas
docker-compose run web mkdir -p /data/applications-logs

# Set deploy-it as owner
docker-compose run web chown deploy-it.deploy-it /home/deploy-it/.ssh

# Install Database
docker-compose run web rake db:migrate

# Setup Database
docker-compose run web rake deploy_it:setup:first_install
