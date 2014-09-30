#!/bin/bash
. common-hardware-extraction-functions.lib
node=5
item="0" attribute="Model" value="Optiarc DVD RW AD-7200S" generateHwInventoryXmlRecord; 
item="1" attribute="Model" value="Western Digital WDC WD1600AAJS-6" generateHwInventoryXmlRecord; 
item="1" attribute="Interface Type" value="SCSI" generateHwInventoryXmlRecord; 
item="1" attribute="Size" value="149GiB (160GB)" generateHwInventoryXmlRecord; 
item="/dev/sda1" attribute="Partition Size (Gib)" value="`sudo df -k -P /dev/sda1 | awk 'NR==2{print $2/(1024*1024)}'`" generateHwInventoryXmlRecord; 
item="/dev/sda1" attribute="Free Space (Gib)" value="`sudo df -k -P /dev/sda1 | awk 'NR==2{print $4/(1024*1024)}'`" generateHwInventoryXmlRecord; 
item="/dev/sda1" attribute="Volume Name" value="/dev/sda1" generateHwInventoryXmlRecord; 
item="/dev/sda1" attribute="Volume Serial Number" value="9057-2f25" generateHwInventoryXmlRecord; 
item="/dev/sda1" attribute="File System" value="Windows NTFS volume" generateHwInventoryXmlRecord; 
item="/dev/sda2" attribute="Partition Size (Gib)" value="`sudo df -k -P /dev/sda2 | awk 'NR==2{print $2/(1024*1024)}'`" generateHwInventoryXmlRecord; 
item="/dev/sda2" attribute="Free Space (Gib)" value="`sudo df -k -P /dev/sda2 | awk 'NR==2{print $4/(1024*1024)}'`" generateHwInventoryXmlRecord; 
item="/dev/sda2" attribute="Volume Name" value="/media/asal/14605CE5605CCF5C" generateHwInventoryXmlRecord; 
item="/dev/sda2" attribute="Volume Serial Number" value="7abd6952-ac21-9347-a12c-265f8bddcebe" generateHwInventoryXmlRecord; 
item="/dev/sda2" attribute="File System" value="Windows NTFS volume" generateHwInventoryXmlRecord; 
item="/dev/sda3" attribute="Partition Size (Gib)" value="`sudo df -k -P /dev/sda3 | awk 'NR==2{print $2/(1024*1024)}'`" generateHwInventoryXmlRecord; 
item="/dev/sda3" attribute="Free Space (Gib)" value="`sudo df -k -P /dev/sda3 | awk 'NR==2{print $4/(1024*1024)}'`" generateHwInventoryXmlRecord; 
item="/dev/sda3" attribute="Volume Name" value="/dev/sda3" generateHwInventoryXmlRecord; 
item="/dev/sda3" attribute="Volume Serial Number" value="" generateHwInventoryXmlRecord; 
item="/dev/sda3" attribute="File System" value="Extended partition" generateHwInventoryXmlRecord; 
item="/dev/sda5" attribute="Partition Size (Gib)" value="`sudo df -k -P /dev/sda5 | awk 'NR==2{print $2/(1024*1024)}'`" generateHwInventoryXmlRecord; 
item="/dev/sda5" attribute="Free Space (Gib)" value="`sudo df -k -P /dev/sda5 | awk 'NR==2{print $4/(1024*1024)}'`" generateHwInventoryXmlRecord; 
item="/dev/sda5" attribute="Volume Name" value="/" generateHwInventoryXmlRecord; 
item="/dev/sda5" attribute="Volume Serial Number" value="" generateHwInventoryXmlRecord; 
item="/dev/sda5" attribute="File System" value="Linux filesystem partition" generateHwInventoryXmlRecord; 
item="/dev/sda6" attribute="Partition Size (Gib)" value="`sudo df -k -P /dev/sda6 | awk 'NR==2{print $2/(1024*1024)}'`" generateHwInventoryXmlRecord; 
item="/dev/sda6" attribute="Free Space (Gib)" value="`sudo df -k -P /dev/sda6 | awk 'NR==2{print $4/(1024*1024)}'`" generateHwInventoryXmlRecord; 
item="/dev/sda6" attribute="Volume Name" value="/dev/sda6" generateHwInventoryXmlRecord; 
item="/dev/sda6" attribute="Volume Serial Number" value="" generateHwInventoryXmlRecord; 
item="/dev/sda6" attribute="File System" value="Linux swap / Solaris partition" generateHwInventoryXmlRecord; 
