#!/bin/bash

OS=`uname`

case $OS in
  Linux)
	last | awk '/reboot/ && (found != 1){ print $6" "$7" "$8; found=1}'
        ;;
  Darwin)
	who -b | awk '{ print $3" "$4" "$5}'
        ;;
  *)
    echo "Unsupported OS: $OS" >&2;;
esac
