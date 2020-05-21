#!/bin/bash

trigger=/tmp/shutdown

if [[ -f "$trigger" ]]; then
    rm -R $trigger
fi

tcpserver 0.0.0.0 8008 sh -c "/scripts/check.sh"
