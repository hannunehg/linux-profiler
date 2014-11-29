#!/bin/sh
# -----------------------------------
# Check drive health via smartctl
# -----------------------------------
# Copyright (c) 2014, Servoyant, LLC
# -----------------------------------
EXISTS=$(command -v smartctl | grep -i -c smartctl) 
if [ $EXISTS -eq 0 ]; then
        echo 'UNK::0::smartctl is not installed - install package smartmontools'
        exit
fi
ARGC=$#
if [ $ARGC -eq o ]; then
        echo "UNK::0::Device identifier missing"
        exit
fi
PROGRAM="smartctl"
DEVICE=$1
#check if the device exists
OLDIFS=$IFS
IFS=$'\n'
RESULT=$(sudo $PROGRAM -i $DEVICE )
MISSING=$(echo $RESULT | grep -i -c "unable to detect device")
if [ $MISSING -gt 0 ]; then
        echo "UNK::0::Unable to detect device $DEVICE"
        exit
fi                                                    
#check if it supports SMART                           
AVAILABLE=$(echo $RESULT | grep -i -c "smart support is: available" )
if [ $AVAILABLE -eq 0 ]; then                         
        echo "UNK::0::$DEVICE does not have SMART capability"
        exit                                          
fi                                                    
ENABLED=$( echo $RESULT | grep -i -c "smart support is: enabled"  )
if [ $ENABLED -eq 0 ]; then                           
        echo "enabling"                               
        $RESULT=$(sudo $PROGRAM -s on $DEVICE )       
        echo "after enable"                           
        echo $RESULT                                  
        $ENABLED=$(echo $RESULT | grep -c -i "smart enabled"  )
        echo $ENABLED
        if [ $ENABLED -eq 0 ]; then
                echo "UNK::0:SMART support is disabled on $DEVICE, attempt to enable failed"
        fi
fi
STATUS="BAD"
RESULT=$(sudo $PROGRAM -H $1)
HEADERFOUND=0
for i in $RESULT
do
        if [ $HEADERFOUND -eq 1 ] ; then
                TVAL=$(echo $i | grep -i -E "Passed|OK" )
                NVAL=$(echo $i | grep -i -c -E "Passed|OK" )
                if [ $NVAL -eq 1 ]; then
                        STATUS="OK"
                fi
                break
        fi
        HEADERFOUND=$(echo $i | grep -i -c "read smart data section")
done
echo "$STATUS::$NVAL::$TVAL"
