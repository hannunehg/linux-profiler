#!/bin/bash

OS=`uname`

case $OS in
  Linux)
	currenDisk=$(sudo df | awk '(NR==2){print $1}')
	sudo tune2fs -l $currenDisk | awk '/created/{split($6,a,":"); print ""$4" "$5" "a[1]":"a[2]}'        ;;
  Darwin)
        ;;
  *)
    echo "Unsupported OS: $OS" >&2;;
esac
