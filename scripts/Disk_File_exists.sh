#!/bin/sh
# -----------------------------------
# File Exists
# -----------------------------------
# Copyright (c) 2014, Servoyant, LLC
# -----------------------------------
FILESPEC=$1
RESULT=$(sudo du $FILESPEC)
COUNT=$(echo $RESULT | grep -i -c "$FILESPEC")
if [ $COUNT -eq 0 ]; then
        STATUS="BAD"
        NVAL=0
        TVAL="No such file or directory found"
else
        STATUS="OK"
        NVAL=1
        TVAL="File or directory found"
fi
echo "$STATUS::$NVAL::$TVAL"
