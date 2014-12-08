#!/bin/bash

OS=`uname`

# first argument contains command to execute
function extractInterfaces() {

  eths=$($1 | grep -Gio "^e[a-z0-9]*")
  wlans=$($1 | grep -Gio "^w[a-z0-9]*")

  for i in $eths
  do 
  echo $i
  done
  for j in $wlans
  do 
  echo $j
  done
}

case $OS in
  Darwin)
    extractInterfaces "ifconfig -a";;
  Linux)
    extractInterfaces "sudo ifconfig"
    ;;
  *)
    echo "Unsupported OS" 
    exit ;;
esac




