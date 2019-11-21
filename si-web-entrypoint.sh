#!/bin/bash
set -e

cd siwebapp

source siwebapp/environments/common_environment.sh
source siwebapp/environments/local_environment.sh

python3 manage.py runserver 0.0.0.0:8080 --settings=siwebapp.settings

exec "$@"
