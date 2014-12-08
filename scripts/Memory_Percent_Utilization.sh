#!/bin/sh
# --------------------------------------
# Memory Percent Utilization

OS=`uname`
case $OS in
  Linux)   NVAL=$(free | grep Mem | awk '{print (100*$3)/$2}');;
  Darwin) 
		PROD=`sw_vers -productVersion | grep -o '[0-9]*\.[0-9]*' | head -1`
		case $PROD in
			10.8)  NVAL=$(top -l 1 | grep PhysMem | awk '{print (100*$8)/($8+$10)}');;
			10.9)  NVAL=$(top -l 1 | grep PhysMem | awk '{print (100*$2)/($2+$6)}');;
			*) 'UNK::0::unsupported OS'
				exit ;;
		esac
		;;
  FreeBSD) NVAL=$(./bsdfree | grep mem_used | awk '{print ($6/1)}');;

  *) echo 'UNK::0::unsupported OS'
			exit
			;;
esac
echo "OK::$NVAL::$NVAL%"
# --------------------------------------

