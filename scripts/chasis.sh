#!/bin/bash
OS=`uname`
DEVELOPER=1

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $dir
. common-hardware-extraction-functions.lib

chassisNode 

cd - > /dev/null
