#!/bin/sh
# -----------------------------------
# Retrieve Bytes Received/s
# -----------------------------------
# Copyright (c) 2014, Servoyant, LLC
# -----------------------------------
OS=`uname`
ARGC=$#
if [ $ARGC -eq 0 ]; then
        echo "UNK::0::Missing parameter"
        exit
fi
INTERFACE=$1
case $OS in
  Darwin)       NVAL=$(sar -n DEV 1 3 | grep verage | grep "$INTERFACE" | tail -1 | awk '{print $6}' );;              
  Linux)    	NVAL=$(sar -n DEV 1 3 | grep verage | grep "$INTERFACE" | tail -1 | awk '{print $6*1024}' );;      
  *)			echo "UNK::0::Unsupported Operating System"
				exit
				;;
esac
echo "OK::$NVAL::$NVAL"

