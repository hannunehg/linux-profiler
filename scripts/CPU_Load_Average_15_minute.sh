#!/bin/sh
# -----------------------------------
# Retrieve 15 minute load average
# -----------------------------------
# Copyright (c) 2014, Servoyant, LLC
# -----------------------------------

NVAL=$(uptime | tail -1 | awk '{print $NF}'| sed s'/.$//') 
OS=`uname`
case $OS in
  Darwin)       NVAL=$(uptime | tail -1 | awk '{print $NF}' );;              
  *)            NVAL=$(uptime | tail -1 | awk '{print $NF}' | sed s'/.$//');;
esac
echo "OK::$NVAL::$NVAL"
