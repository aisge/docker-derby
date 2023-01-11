#!/bin/sh

cd /data

# /derby/bin/startNetworkServer ## doesn´t work correctly

java org.apache.derby.drda.NetworkServerControl start -h 0.0.0.0
