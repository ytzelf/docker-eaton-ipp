#!/bin/bash
echo "Running confd"
confd -log-level="info" -onetime -backend env 
