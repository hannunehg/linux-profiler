#!/bin/sh
# -----------------------------------
# Size of File
# -----------------------------------
# Copyright (c) 2014, Servoyant, LLC
# -----------------------------------
ARGC=#$
if [ $ARGC -eq 0 ]; then
	echo "UNK::0::Missing parameter"
	exit
fi
FILENAME=$1
if [ ! -f "$FILENAME" ]; then
	echo "UNK::0::File $FILENAME not found"
	exit
fi
NVAL=$(ls -l $FILENAME | awk '{print $5}')
TVAL="$NVAL Bytes"
echo "OK::$NVAL::$TVAL"