#!/bin/sh
# -----------------------------------
# Count Files
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
if [ $ARGC -gt 1 ]; then
        DEPTH=$2
else
        DEPTH=1 
fi
NVAL=$(find $FILENAME -type f -maxdepth $DEPTH | wc -l | tr -d " ")
                                                      
TVAL="$NVAL files found"                              
echo "OK::$NVAL::$TVAL"                               
