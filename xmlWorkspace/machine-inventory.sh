#!/bin/bash
#
# Convention Notes:
# CAPITALIZED: global variable

# Main Xml Format
function xmlOutput() {
  # Software node
  echo "<programs>"
  if [[ -z  $DEVELOPER  ]]
  then
  programsNodeEnumerator
  fi
  echo "</programs>"

  # Hw Inventory node
  echo "<hwinventory>"
  hwInventoryNodeEnumerator
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

# 1- Change Directory to file locations so that we can reference other scripts
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $dir

fileMachineInventoryXml="machine-inventory.xml"
errorLogFile="error.log"

# 2- Reference xml helpers and nodes enumerator
. xml-helper.sh

# 3- Prepare error log
echo -e "Running Script '${BASH_SOURCE[0]}' at '`date`'" >$errorLogFile

# 4- Generate XML Output to file and errors to error log
xmlOutput 1> $fileMachineInventoryXml 2>>$errorLogFile

# 5- Print xml to standard output (stdou)
cat $fileMachineInventoryXml 

# 6- Change directory back to origional location
cd - 1>/dev/null
