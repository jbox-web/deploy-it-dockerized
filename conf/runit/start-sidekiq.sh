#!/bin/bash

su - deploy-it -c "/bin/bash -c 'bundle exec sidekiq -C config/sidekiq.yml'"
