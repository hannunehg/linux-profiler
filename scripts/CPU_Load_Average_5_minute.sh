#!/bin/sh
# -----------------------------------
# Retrieve 5 minute load average
# -----------------------------------
# Copyright (c) 2014, Servoyant, LLC
# -----------------------------------
OS=`uname`
case $OS in
  Darwin)       NVAL=$(uptime | tail -1 | awk '{print $(NF-1)}' );;              
  *)            NVAL=$(uptime | tail -1 | awk '{print $(NF-1)}' | sed s'/.$//');;
esac
echo "OK::$NVAL::$NVAL"

