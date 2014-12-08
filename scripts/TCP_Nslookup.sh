#!/bin/sh
# -----------------------------------
# Lookup host address
# -----------------------------------
# Copyright (c) 2014, Servoyant, LLC
# -----------------------------------
ARGC=$#
if [ $ARGC -eq 0 ]; then
        echo "UNK::0::Missing parameter"
        exit
fi
HOST=$1
NSLOOKUP=$(command -v nslookup)
if [ -z "$NSLOOKUP"  ]; then
	NSLOOKUP=$(command -v host)
	if [ -z "$NSLOOKUP"  ]; then
        echo "UNK::0::Neither nslookup or host were found on this system";
        exit;
	else
		_COMMAND=$(command -v host)
		NSLOOKUP=0
	fi
else
	_COMMAND=$(command -v nslookup)
	NSLOOKUP=1
fi
START=$(date +%s)
TVAL=$($_COMMAND $HOST)
END=$(date +%s)
if [ "$NSLOOKUP" -eq 1 ]; then
	TVAL=$(echo "$TVAL" | tail -1 | grep dress | awk '{print $NF}')
else
	TVAL=$(echo "$TVAL" | tail -1 | grep dress | awk '{print $NF}')
fi
NVAL=$(( $END - $START))

if [ -z "$TVAL" ]; then
		NVAL=0
        echo "BAD::$NVAL::$HOST not found";
        exit;
fi
echo "OK::$NVAL::$TVAL"
