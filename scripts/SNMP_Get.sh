#!/bin/sh
# --------------------------------------
# Get SNMP OID 
# -----------------------------------
# Copyright (c) 2014, Servoyant, LLC
# -----------------------------------
EXISTS=$(command -v snmpget | grep -i -c snmpget) 
if [ $EXISTS -eq 0 ]; then
	echo 'UNK::0::snmpget is not installed - install package net-snmp'
        exit
fi

ARGC=$#
if [ $ARGC -lt 4 ]; then
        echo "UNK::0::Missing parameters"
        exit
fi
OID=$1
IPADDRESS=$2
SNMPVER=$3
CS=$4
case $SNMPVER in
	0) VERSTR="1";;
	1) VERSTR="2c";;
	3) VERSTR="3";;
	*) echo "UNK::0::Invalid SNMP Version"
		exit;;
esac
if [ $SNMPVER -lt 3 ]; then
        SNMPCOMMAND="snmpget -v $VERSTR -L n -O n -c $CS $IPADDRESS $OID"
else
	if [ $ARGC -lt 11 ]; then
		echo "UNK::0::Missing parameters for SNMP v3"
	else
		SECURITYNAME=$5
		AUTHPROTOCOL=$6
		PRIVPROTOCOL=$7
		AUTHKEY=$8
		PRIVKEY=$9
		SECURITYLEVEL=${10}
		CONTEXT=${11}
		SNMPCOMMAND="snmpget -v $VERSTR -L n -O n "
		if [ ! -z "$SECURITYNAME"  -a "$SECURITYNAME" != " " ]; then
			SNMPCOMMAND="$SNMPCOMMAND -u $SECURITYNAME"
		fi
		if [ ! -z "$AUTHPROTOCOL"  -a "$AUTHPROTOCOL" != " " ]; then
			SNMPCOMMAND="$SNMPCOMMAND -a $AUTHPROTOCOL"
		fi
		if [ ! -z "$PRIVPROTOCOL"  -a "$PRIVPROTOCOL" != " " ]; then
			SNMPCOMMAND="$SNMPCOMMAND -x $PRIVPROTOCOL"
		fi
		if [ ! -z "$AUTHKEY"  -a "$AUTHKEY" != " " ]; then
			SNMPCOMMAND="$SNMPCOMMAND -A $AUTHKEY"
		fi
		if [ ! -z "$PRIVKEY"  -a "$PRIVKEY" != " " ]; then
			SNMPCOMMAND="$SNMPCOMMAND -X $PRIVKEY"
		fi
		if [ ! -z "$SECURITYLEVEL"  -a "$SECURITYLEVEL" != " " ]; then
			SNMPCOMMAND="$SNMPCOMMAND -l $SECURITYLEVEL"
		fi
		if [ ! -z "$CONTEXT"  -a "$CONTEXT" != " " ]; then
			SNMPCOMMAND="$SNMPCOMMAND -n $CONTEXT"
		fi
		SNMPCOMMAND="$SNMPCOMMAND $IPADDRESS $OID"
	fi
fi
RESULT=$( $SNMPCOMMAND)
if [ -z "$RESULT" ]; then
	echo "UNK::0::No result returned"
	exit
fi
RESULTTYPE=$(echo $RESULT | awk '{print $3}')
case $RESULTTYPE in
	Timeticks:)
		NVAL=$( echo $RESULT | awk '{print $4}' | tr -d "()" )
		TVAL=$(echo $RESULT | cut -d" "  -f5-)
		;;

	STRING:)
		NVAL=0
		TVAL=$( echo $RESULT | cut -d" " -f4- )
		;;

	*)
		NVAL=$( echo $RESULT | cut -d" " -f4- )
		TVAL=$NVAL
		;;
esac
case $NVAL in
    ''|*[!0-9]*) NVAL=0 ;;
    *)  ;;
esac
echo "OK::$NVAL::$TVAL"
