#!/bin/bash

su - deploy-it -c "/bin/bash -c 'bundle exec thin -C config/danthes_thin.yml start'"
