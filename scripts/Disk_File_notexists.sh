#!/bin/sh
# -----------------------------------
# File Does not Exist
# -----------------------------------
# Copyright (c) 2014, Servoyant, LLC
# -----------------------------------
FILESPEC=$1
RESULT=$(sudo du $FILESPEC)
COUNT=$(echo $RESULT | grep -i -c "$FILESPEC")
if [ $COUNT -eq 0 ]; then
        STATUS="OK"
        NVAL=1
        TVAL="No such file or directory found"
else
        STATUS="BAD"
        NVAL=0
        TVAL="File or directory found"
fi
echo "$STATUS::$NVAL::$TVAL"
