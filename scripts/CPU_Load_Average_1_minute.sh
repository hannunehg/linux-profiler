#!/bin/sh
# -----------------------------------
# Retrieve 1 minute load average
# -----------------------------------
# Copyright (c) 2014, Servoyant, LLC
# -----------------------------------
OS=`uname`
case $OS in
  Darwin)	NVAL=$(uptime | tail -1 | awk '{print $(NF-2)}' );;
  *)		NVAL=$(uptime | tail -1 | awk '{print $(NF-2)}' | sed s'/.$//');;
esac
echo "OK::$NVAL::$NVAL"

