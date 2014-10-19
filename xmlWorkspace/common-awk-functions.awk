 #!/bin/awk
BEGIN {
  FS="[<>]";
  _dictOpenTags=0;    
}


function printXml(item, attribute, value) {
  print "item=\""item"\" attribute=\""attribute"\" value=\""value"\" generateHwInventoryXmlRecord; ";
}

(_keyFound == 1) { 
  if (($2 ~ "string") || ($2 ~ "date") || ($2 ~ "integer")) {
    LEAF_KEY=_key
    LEAF_VALUE=$3
  } else {
    PARENT_KEY=_key;
  }
}
_keyFound=0;

($2 ~ "key"){ 
  _key=$3;
  _keyFound=1; 
}
($2 == "dict"){
  printAll(); 
  _dictOpenTags++;
}
($2 == "/dict"){
  printAll(); 
  _dictOpenTags--;
}
