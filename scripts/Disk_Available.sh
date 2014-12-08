#!/bin/sh
# -----------------------------------
# Retrieve Disk Available
# -----------------------------------
# Copyright (c) 2014, Servoyant, LLC
# -----------------------------------
ARGC=#$
if [ $ARGC -eq 0 ]; then
	echo "UNK::0::Missing parameter"
	exit
fi
if [ ! -d "$1" ]; then
	echo "UNK::0::Mount $1 not found"
	exit
fi
NVAL=$(df -k $1 | tail -1 | awk '{print $4}')
NVAL=$(echo "scale=1; $NVAL/1024" | bc)
TVAL="$NVAL MB"
                                                 
echo "OK::$NVAL::$TVAL"