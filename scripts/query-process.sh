#!/bin/bash

if [[ $#  != 1 ]]
then
echo "Usage example: $0 <process-name>"
exit
fi

if [[  `pgrep $1` != "" ]]
then
echo Running;
fi
