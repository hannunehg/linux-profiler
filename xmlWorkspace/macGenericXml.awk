#!/bin/awk
# Note: Capitalized format means a global variable
# this file depends on common-awk-functions.awk
# Global variables: LEAF_KEY, LEAF_VALUE, PARENT_KEY
# Must implement printAll() function
BEGIN {
_diskNum=1;
_printType=-1;
}
# overriden in this file
function printAll(){
  
  if (_printType == 1) {
    printDiskInfo();
  }
  if (_printType == 2) {
    printVolumeInfo();
  }
  _printType = -1;
  #print "testting Open Tags: "_dictOpenTags;
}


function printDiskInfo() {
  printXml(_diskNum,"Model",deviceModel);
  printXml(_diskNum,"Interface Type",iType);
  printXml(_diskNum,"Size",size);
  iType="";deviceModel="";size="";
  _diskNum++;
}
function printVolumeInfo() {
  printXml(name,"Volume Name",logicalName);
  printXml(name,"Partition Size",size);
  printXml(name,"Free Space",freeSpace);
  printXml(name,"Volume Serial Number",serial);
  printXml(name,"File System",fileSystem);    
  logicalName="";size="";freeSpace="";serial="";fileSystem="";
}

(_keyFound == 1) {
  #print "parent key is: "PARENT_KEY
  if (PARENT_KEY == "_items") {
    if (LEAF_KEY == "_name") {
      _printType=1;   
      #name=LEAF_VALUE;
    }
    if (LEAF_KEY == "device_model") {
      deviceModel=LEAF_VALUE;
    }
    # usually not found
    if (LEAF_KEY == "optical_drive_type") {
      iType=LEAF_VALUE;
    }
  }
  if (PARENT_KEY == "volumes") {
    if (LEAF_KEY == "_name") {
      _printType=2;
      name=LEAF_VALUE;
    }
    if (LEAF_KEY == "bsd_name") {
      logicalName=LEAF_VALUE;
    }
    if (LEAF_KEY == "free_space_in_bytes") {
      freeSpace=LEAF_VALUE;
    }
    if (LEAF_KEY == "volume_uuid") {
      serial=LEAF_VALUE;
    }
    if (LEAF_KEY == "file_system") {
      fileSystem=LEAF_VALUE;
    }
  }
  # Common between Nodes
  if (LEAF_KEY == "size_in_bytes") {
      size=LEAF_VALUE;
  }
  
}


