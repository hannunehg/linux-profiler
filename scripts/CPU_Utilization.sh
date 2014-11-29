#!/bin/sh
# -----------------------------------
# CPU Utilization 1 sec
# -----------------------------------
# Copyright (c) 2014, Servoyant, LLC
# -----------------------------------
OS=`uname`
case $OS in
  Linux)   NVAL=$(vmstat -n 1 2 | tail -1 | awk '{print 100-$(NF-1)}');;
  Darwin)  NVAL=$(iostat -c 2 -w 1 | tail -1 | awk '{print 100-$6}');;  
  FreeBSD) NVAL=$(vmstat -c 2 -w 1 | tail -1 | awk '{print 100-$NF}');;
  NetBSD)  NVAL=$(vmstat -c 2 -w 1 | tail -1 | awk '{print 100-$NF}');;
  OpenBSD) NVAL=$(vmstat -c 2 -w 1 | tail -1 | awk '{print 100-$NF}');;
  SunOS) NVAL=$(vmstat 1 2 | tail -1 | awk '{print 100-$NF}');;
  HP-UX) NVAL=$(vmstat 1 2 | tail -1 | awk '{print 100-$NF}');;
  *) echo 'UNK::0::unsupported OS'
	exit
	;;
esac

# -------------------------------------- 
echo "OK::$NVAL::$NVAL"

