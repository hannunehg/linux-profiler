#!/bin/bash
OS=`uname`
case $OS in
  Darwin)
    #diskutil list | awk '(NR >2){print $(NF)}'
    diskutil list |
        awk '/disk[0-9]+[a-zA-z]/{ print $(NF)}' |
            awk '{print $0}' |
                for i in `xargs` ;
                do
                    df -h | grep $i | awk '{print $(NF)}' ;
                done
    ;;
  Linux)
      #sudo lsblk -ln -o NAME | awk '/[a-z]+[0-9]/{print $0}' 
       sudo mount | awk '/^\/dev\/sd/{print $3}'
    ;;
  *) 
    echo 'unsupported OS'
    exit
	;;
esac
