#!/bin/bash
OS=`uname`
case $OS in
  Darwin)
      diskutil list | awk '(NR >2){print $(NF)}'
  ;;
  Linux)
      sudo lsblk -ln -o NAME | awk '/[a-z]+[0-9]/{print $0}' 
  ;;
  *) 
    echo 'unsupported OS'
    exit
	;;
esac
