#!/bin/sh
# -----------------------------------
# Count Process Instances
# -----------------------------------
# Copyright (c) 2014, Servoyant, LLC
# -----------------------------------
if [ $# -ne 0 ];then
        PROC=$1
        OS=`uname`
        case $OS in
                AIX) PSLIST='ps -Ao comm';;
                Linux) PSLIST='ps -eo ucmd';;
                Darwin) PSLIST='ps -Aco command';;
                FreeBSD) PSLIST='ps -axco command';;
                NetBSD)  PSLIST='ps -axco command';;
                OpenBSD) PSLIST='ps -axco command';;
                SunOS)   PSLIST='ps -eo fname';;
                *) echo "UNK::0::$OS not supported"
                        exit;;
        esac
        CNT=$($PSLIST | awk 'BEGIN { cnt=0 } $1=="'$PROC'" {cnt++} END {printf cnt}')

        echo "OK::$CNT::$CNT instances of $PROC"
else                                                  
        echo 'UNK::0:Missing process name'            
fi