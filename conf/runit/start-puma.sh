#!/bin/bash

su - deploy-it -c "/bin/bash -c 'bundle exec rails server puma --port 3000 --binding 127.0.0.1'"
