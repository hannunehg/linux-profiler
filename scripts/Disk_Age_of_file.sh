#!/bin/sh
# -----------------------------------
# Age of File
# -----------------------------------
# Copyright (c) 2014, Servoyant, LLC
# -----------------------------------
FILENAME=$1
if [ ! -f $FILENAME ];
then
        echo "UNK::0::File not found"
        exit
fi
OS=`uname`
case $OS in
  Darwin)       NVAL=$(($(date +%s) - $(stat -t %s -f %m -- "$FILENAME")));;
  FreeBSD)      NVAL=$(($(date +%s) - $(stat -t %s -f %m -- "$FILENAME")));;
  Linux)        NAVL= $(($(date +%s) - $(date +%s -r "$FILENAME")));;
  *)            echo "UNK::0::Unsupported OS"
                                exit
  ;;
esac
NVAL=$(echo "scale=1;$NVAL/60" | bc)
echo "OK::$NVAL::$NVAL minutes"
