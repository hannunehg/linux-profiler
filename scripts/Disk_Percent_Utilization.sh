#!/bin/sh
# -----------------------------------
# Retrieve Disk Percent Utilization
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
NVAL=$(df -h $1 | tail -1 | tr -d '[%]' | awk '{print $5}')
echo "OK::$NVAL::$NVAL%"
