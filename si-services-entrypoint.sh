#!/bin/bash
set -e

source seedinvest/settings/common_environment.sh
source seedinvest/settings/local_environment.sh

./manage.py runserver 0.0.0.0:8000 --settings=seedinvest.settings.local_common

exec "$@"
