#!/bin/bash

OS=`uname`

case $OS in
  Linux)
    last | awk '(NR == 1){ print $5" "$6" "$7}'
	;;
  Darwin)
    last | awk '(NR == 1){ print $4" "$5" "$6}'
  	;;
  *)		
    echo "Unsupported OS: $OS" >&2;;
esac
