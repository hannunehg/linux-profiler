#!/bin/bash

currenDisk=$(sudo df | awk '(NR==2){print $1}')
sudo tune2fs -l $currenDisk | awk '/created/{print $3" "$4" "$5" "$6}'

