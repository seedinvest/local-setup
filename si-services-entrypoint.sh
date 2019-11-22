#!/bin/bash
set -e

source seedinvest/settings/common_environment.sh
source seedinvest/settings/local_environment.sh

while ! pg_isready -h postgres
do
    echo "$(date) - waiting for database to start"
    sleep 10s
done

./manage.py runserver 0.0.0.0:8000 --settings=seedinvest.settings.local_common

exec "$@"
