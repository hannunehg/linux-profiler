#!/bin/bash

OS=`uname`

case $OS in
  Darwin)
    ifconfig -a | awk -F ":" '/^[a-z]/{print $1}' ;;
  Linux)
    sudo ifconfig -a | awk -F "[: ]" '/^[a-z]/{print $1}' ;;
  *)
    echo "Unsupported OS" 
    exit ;;
esac
