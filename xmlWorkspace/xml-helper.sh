#!/bin/bash

function hardwareNodeEnumerator() {
  . hardware-node-enumerator.lib
  
  manufacturer=$(manufacturerNode)
  model=$(modelNode)
  product=$(productNode)
  serialnumber=$(serialnumberNode)
  partnumber=$(partnumberNode)
  bios=$(biosNode)
  os=$(osNode)
  processors=$(processorsNode)
  physicalmemory=$(physicalmemoryNode)
  physicalmemorydet=$(physicalmemorydetNode)
  visiblememory=$(visiblememoryNode)
  displayadapters=$(displayadaptersNode)
  networkadapters=$(networkadaptersNode)
  diskdrives=$(diskdrivesNode)
  cdromdrives=$(cdromdrivesNode)
  chassis=$(chassisNode)
  domainrole=$(domainroleNode)
  
  generateHardwareXmlRecord
}


function hwInventoryNodeEnumerator() {
  . hw-inventory-node-enumerator.lib
  systemNodeNumber=1
  osNodeNumber=2
  cpuNodeNumber=3
  drivesNodeNumber=5
  memoryNodesNumber=4
  networkNodesNumber=6
  
  systemNodeEnumerator
  osNodeEnumerator  
  cpuNodeEnumerator
  memoryNodeEnumerator
  drivesNodeEnumerator
  networkNodesEnumerator
}

function programsNodeEnumerator() {
  . programs-node-enumerator.lib
  tmpGenerateXmlScript="._tmp-generate-xml-script.sh"
  printXmlRecordsGeneratingScript > $tmpGenerateXmlScript
  sudo chmod +x $tmpGenerateXmlScript  
  ./$tmpGenerateXmlScript
}



