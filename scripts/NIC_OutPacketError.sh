#!/bin/sh
# -----------------------------------
# Retrieve Outbound Packet Errors
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
  Darwin)       NVAL=$(netstat -i | grep "$INTERFACE" | grep ink | tail -1 | awk '{print $8}' );;              
  Linux)        NVAL=$(netstat -i | grep "$INTERFACE" | tail -1 | awk '{print $9}' );;
  *)			echo "UNK::0::Unsupported Operating System"
				exit
				;;
esac
echo "OK::$NVAL::$NVAL"

