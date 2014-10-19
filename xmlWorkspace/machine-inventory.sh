#!/bin/bash
#
# Convention Notes:
# CAPITALIZED: global variable

# Main Xml Format
function xmlOutput() {
  # Software node
  echo "<programs>"
    programsNodeEnumerator
  echo "</programs>"
  # Hw Inventory node
  echo "<hwinventory>"
    systemNodeEnumerator
    osNodeEnumerator  
    cpuNodeEnumerator
    memoryNodeEnumerator
    drivesNodeEnumerator
    networkNodesEnumerator
  echo "</hwinventory>"
  # Hardware node
  echo "<hardware>"
    hardwareNodeEnumerator
  echo "</hardware>"
}
# 0-A) read actual OS only once
OS=`uname`
# 0-B) read args:
while getopts "o:d" opt; do
  case $opt in
    d)
      # do not initialize the lshw for ubunut
      export DEVELOPER=1 
      ;;
    o)
      # override OS
      OS=$OPTARG
      ;;
    \?)
      echo $OPTARG
      exit 9
      ;;
     :)
      echo $OPTARG
      exit 9
      ;;
  esac
done
# 0-C) export OS variable to all scripts
export OS=$OS
# 0-D) Reference needed libraries
. programs-node-enumerator.lib
. hw-inventory-node-enumerator.lib
. hardware-node-enumerator.lib

# 1- Change Directory to file locations so that we can reference other scripts
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $dir
errorLogFile="error.log"
# 2- Prepare error log
echo -e "Running Script '${BASH_SOURCE[0]}' at '`date`'" >$errorLogFile
# 3- Generate XML Output to file and errors to error log
fileMachineInventoryXml="machine-inventory.xml"
xmlOutput 1> $fileMachineInventoryXml 2>>$errorLogFile
# 4- Change directory back to origional location
cd - 1>/dev/null
