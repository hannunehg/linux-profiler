#!/bin/sh
# -----------------------------------
# Size of Folder
# -----------------------------------
# Copyright (c) 2014, Servoyant, LLC
# -----------------------------------
ARGC=$#
if [ $ARGC -eq 0 ]; then
        echo "UNK::0::Missing parameter"
        exit
fi
FILENAME=$1
if [ ! -d "$FILENAME" ]; then
        echo "UNK::0::Folder $FILENAME not found"
        exit
fi
NVAL=$(du -k -c $FILENAME | tail -1 | awk '{print $1}')
NVAL=$(echo "scale=1; ($NVAL/1024)" | bc)
TVAL="$NVAL MBytes"
echo "OK::$NVAL::$TVAL"