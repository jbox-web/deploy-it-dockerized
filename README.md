## Deploy'It - Dockerized

[![GitHub license](https://img.shields.io/github/license/jbox-web/deploy-it-dockerized.svg)](https://github.com/jbox-web/deploy-it-dockerized/blob/master/LICENSE)

### Host your own private Heroku, easy ;)

## Installation

You will need :

* Docker
* Docker Registry

to be installed before installing DeployIt.


**1)** First checkout the repository and init submodules :

```sh
root# git clone https://github.com/jbox-web/deploy-it-dockerized.git deploy-it
root# cd deploy-it
root# git submodule init
root# git submodule update
```

**2)** Build Docker base image

```sh
root# cd image-base
root# docker build -t deployit:base .
```

**3)** Create a configuration file called ```deploy-it.env``` with environment variables within :

You will need to set your own config for this settings :

Settings | Format
---------|--------
```<RAILS GENERATED SECRET>```              | Random secret (64 characters)
```<FAYE GENERATED SECRET>```               | Random secret (64 characters)
```<DATABASE PASSWORD>```                   | Database user password
```<DEPLOYIT ACCESS URL>```                 | The url you want to use to access to DeployIt (ex: http://deployit.example.net:5000 or https://deployit.example.net)
```<DEPLOYIT DOMAIN NAME>```                | The default domain name for newly created applications
```<DOCKER PRIVATE REGISTRY DOMAIN NAME>``` | The domaine name of your own Docker Private Registry (private-registry.example.net)

```sh
## Rails vars
RAILS_ENV=production
RAILS_SECRET=<RAILS GENERATED SECRET>

## Database config
DB_ADAPTER=mysql2
DB_HOST=db
DB_PORT=3306
DB_NAME=deployit
DB_USER=deployit
DB_PASS=<DATABASE PASSWORD>

## Redis config
REDIS_HOST=redis
REDIS_PORT=6379

## DeployIt config

# Logs
LOG_LEVEL=info
LOG_DIR=/home/deploy-it/log

# DeployIt authentication server
AUTHENTICATION_SERVER=http://web:80

# SSH authorized_keys file
SSH_CONFIG_FILE=/home/deploy-it/.ssh/authorized_keys

# DeployIt domain name
ACCESS_DOMAIN_NAME=<DEPLOYIT DOMAIN NAME>

# Private Docker Registry
DOCKER_REGISTRY=<DOCKER PRIVATE REGISTRY DOMAIN NAME>

# DeployIt directories
APPLICATIONS_CLONES_DIR=/data/applications-clones
APPLICATIONS_REPOS_DIR=/data/applications-repositories
APPLICATIONS_DATAS_DIR=/data/deploy-it/applications-datas
```

**4)** Edit ```docker-compose.yml``` file and set  ```<DATABASE PASSWORD>``` and ```<DATABASE ROOT PASSWORD>``` variables

**5)** Launch ```install.sh``` script :

```sh
root# ./install.sh
```

This will trigger Docker Compose and will build these DeployIt images/containers :

* Web
* Sidekiq
* SSH
* MySQL
* Redis
