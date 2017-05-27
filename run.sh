#!/bin/bash

set -e

# This runs after first start 
if [ ! -f /host/lektor/firstrun ]; then

    mkdir -p /host/lektor/html
    mkdir -p /host/lektor/project

    cp -r /project/* /host/lektor/project/ 
    cd /host/lektor/project
    lektor build --output-path ../html/

    # Don't run this again
    touch /host/lektor/firstrun
fi


# This runs after every boot
if [ ! -f /firstrun ]; then


    # Don't run this again
    touch /firstrun
fi

cd /host/lektor/project

exec "$@"

