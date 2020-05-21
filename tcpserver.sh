#!/bin/bash
rm -R /tmp/* && tcpserver 0.0.0.0 8008 sh -c "/scripts/check.sh"
