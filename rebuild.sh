#!/bin/bash

# Stop running DeployIt
docker-compose stop

# Rebuild containers
docker-compose build web
docker-compose build sidekiq
docker-compose build ssh

# Spin-up DeployIt
docker-compose up
