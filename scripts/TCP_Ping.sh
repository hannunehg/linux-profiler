#!/bin/sh
# -----------------------------------
# Ping test
# -----------------------------------
# Copyright (c) 2014, Servoyant, LLC
# -----------------------------------
ARGC=$#
if [ $ARGC -ge 1 ]; then
ARG1=$1
fi
if [ $ARGC -ge 2 ]; then
PL=$2
else
PL=10
fi

if [ $ARGC -ge 3 ]; then
COUNT=$3
else
COUNT=10
fi
EXTRA=""
if [ $ARGC -ge 4 ]; then
        IT=0
        for i in "$@" 
        do
                IT=`expr $IT + 1` 
                if [ $IT -ge 3 ]; then
                EXTRA="$EXTRA  $i"
                fi
        done
fi
IFS=' '
IT=0
for i in $ARG1
do
IT=`expr $IT + 1`
                if [ $IT -eq 1 ]; then
                        TARGET=$i
                else 
                        EXTRA="$EXTRA  $i"
                fi
done
OS=`uname`
case $OS in
  Linux)   COMMAND="sudo ping -i .2 -W 1000 -c $COUNT $EXTRA $TARGET";;
  Darwin)  COMMAND="sudo ping -i .2 -W 1000 -c $COUNT $EXTRA $TARGET";;  
  FreeBSD) COMMAND="sudo ping -i .2 -W 1000 -c $COUNT $EXTRA $TARGET";;
  NetBSD)  COMMAND="sudo ping -i .2 -W 1000 -c $COUNT $EXTRA $TARGET";;
  OpenBSD) COMMAND="sudo ping -i .2 -W 1000 -c $COUNT $EXTRA $TARGET";;
  SunOS)  if [ "x$EXTRA" -eq "x" ] ; then
				$EXTRA=56
		  fi
		  COMMAND="ping -s $TARGET $EXTRA $COUNT "
		  ;;
  *) echo 'UNK::0::unsupported OS'
	exit
	;;
esac


RESULT=$($COMMAND)
if test -z "$RESULT"
 then
        echo "UNK::0::Unknown host $TARGET"
        exit
fi
case $OS in
  SunOS)  AVGLINE=$(echo $RESULT | grep "/avg/" | awk '{print $5}')
		  ;;
  *) 
	 AVGLINE=$(echo $RESULT | grep "/avg/" | awk '{print $4}')
	 ;;
esac
PACKETLOSS=$(echo $RESULT | grep "packet loss" | tr -d '[%]' | awk '{print $7}')
PACKETLOSS=$(echo "scale=0;$PACKETLOSS/1" | bc)
IFS="/"
AVG=$(echo $AVGLINE | awk '{print $2}')
REPLY="OK"
NVAL=$AVG
TVAL="Latency: $AVG ms, Packet Loss: $PACKETLOSS %"
if test $PACKETLOSS -ge $PL 
then
        REPLY="BAD"
fi
echo "$REPLY::$NVAL::$TVAL"

# -------------------------------------- 


