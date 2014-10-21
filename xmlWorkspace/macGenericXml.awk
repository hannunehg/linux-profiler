#!/bin/awk
# Note: Capitalized format means a global variable
# this file depends on common-awk-functions.awk
# Global variables: LEAF_KEY, LEAF_VALUE, PARENT_KEY
# Must implement printAll() function

BEGIN {
_diskNum=1;
_printType=-1;
_networkDev=1;
 OFMT = "%.3f";
}
# inherited function overriden in this file
function printTopLevel() {
  if (_printType == 4) {
    printNetworkInfo();
  }
}
# inherited function overriden in this file
function printAll(){
  if (_printType != -1) {
    if (_printType == 1) {
      printDiskInfo();
      name="";
    }
    if (_printType == 2) {
      printVolumeInfo();
    }
    if (_printType == 3) {
      printMemoryInfo();
    }
    if (_printType == 5) {
      printCpuInfo();
    }
  }  
  #print "testting Open Tags: "_dictOpenTags;
}
function printCpuInfo() {
  printXml(procId,"Manufacturer",cpuManufacturer);  
  printXml(procId,"Name",cpuModelName);
  printXml(procId,"Version",cpuVersion);
  printXml(procId,"Speed",cpuSpeed);
  
}
function printNetworkInfo() {
  #TODO print model by another command
  printXml(_networkDev,"Model",model);  
  printXml(_networkDev,"MAC Address",macAddress);
  printXml(_networkDev,"IP Addresses",ipAddress);  
  printXml(_networkDev,"Default Gateway",gateway);   
  printXml(_networkDev,"DNS Domain",dnsDomain);  
  printXml(_networkDev,"DHCP Server",dhcp);    
  printXml(_networkDev,"DNS Servers",dns); 
  
  if (macAddress != ""){ _networkDev++;}
  macAddress="";ipAddress="";gateway="";
  dnsDomain="";dhcp="";dns="";
}
function printMemoryInfo() {
  printXml(name,"Size",dimmSize);
  printXml(name,"Speed",dimmSpeed);
  printXml(name,"Form Factor",formFactor);
  printXml(name,"Bank Label","`echo \""name"\" | grep bank[[:space:]][0-9]* -io`");
  printXml(name,"Memory Type",dimType);  
  dimmSize="";dimmSpeed="";formFactor="";name="";dimType="";
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
  if (size != "") {
    printXml(name,"Partition Size",size);
  }
  if (freeSpace != "") {
    printXml(name,"Free Space",freeSpace);
  }
  printXml(name,"Volume Serial Number",serial);
  printXml(name,"File System",fileSystem);    
  logicalName="";size="";freeSpace="";serial="";fileSystem="";
}

# set print type
/SPHardwareDataType/ { _printType=5}
/SPNetworkDataType/ { _printType=4}
/SPMemoryDataType/ { _printType=3}
#_printType=2 is for Volumes inside disks
/SPSerialATADataType/ { _printType=1}

(_keyFound == 1) {
  #print "parent key is: "PARENT_KEY
  if (PARENT_KEY == "_items") {
    # common
    if (LEAF_KEY == "_name") {        
      name=LEAF_VALUE;
      print name
    }
    # Disks Node
    if (LEAF_KEY == "device_model") {
      deviceModel=LEAF_VALUE;
    }
    # usually not found
    if (LEAF_KEY == "optical_drive_type") {
      iType=LEAF_VALUE;
    }
    # Memory Node
    if (LEAF_KEY == "dimm_size") {
      dimmSize=LEAF_VALUE;
    }
    if (LEAF_KEY == "dimm_speed") {
      dimmSpeed=LEAF_VALUE;
      _printType=3
    }
    formFactor="DIMM"
    if (LEAF_KEY == "dimm_type") {
      dimType=LEAF_VALUE;
    }
  }
  # Disks node: volumes
  if (PARENT_KEY == "volumes") {
    if (LEAF_KEY == "_name") {
      _printType=2;
      name=LEAF_VALUE;
    }
    if (LEAF_KEY == "bsd_name") {
      logicalName=LEAF_VALUE;
    }
    if (LEAF_KEY == "free_space") {
      freeSpace=LEAF_VALUE;
    }
    if (LEAF_KEY == "volume_uuid") {
      serial=LEAF_VALUE;
    }
    if (LEAF_KEY == "file_system") {
      fileSystem=LEAF_VALUE;
    }
  }
  # Network Node
  if (PARENT_KEY == "Ethernet") {
    if (LEAF_KEY == "MAC Address") {
      macAddress=LEAF_VALUE;
    }
  }
  if (PARENT_KEY == "dhcp") {
    if (LEAF_KEY == "dhcp_routers") {
      dhcp=LEAF_VALUE;
    }
    if (LEAF_KEY == "dhcp_domain_name_servers") {
      dns=LEAF_VALUE;
    }
    if (LEAF_KEY == "dhcp_domain_name") {
      dnsDomain=LEAF_VALUE;
    }
  }
  if (PARENT_KEY == "ip_address") {
    ipAddress=ARRAY_LEAF_VALUE;
    PARENT_KEY="";
  }
  if (LEAF_KEY == "Router") {
    gateway=LEAF_VALUE;
    LEAF_KEY="";
  }
  # CPU Node
  #cpuManufacturer
  if (LEAF_KEY == "cpu_type") {
    cpuModelName=LEAF_VALUE;
  }
  if (LEAF_KEY == "current_processor_speed") {
    cpuSpeed=LEAF_VALUE;
  }
 
  # Common between all Nodes
  if (LEAF_KEY == "size") {
      size=LEAF_VALUE;
  }
 
  
}


