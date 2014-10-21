 #!/bin/awk
BEGIN {
  FS="[<>]";
  _dictOpenTags=0; 
  prevTag= 1;
}
function printXml(item, attribute, value) {
  print "item=\""item"\" attribute=\""attribute"\" value=\""value"\" generateHwInventoryXmlRecord; ";
}

(_arrayFound ==1 ){
  if (($2 ~ "string") || ($2 ~ "date") || ($2 ~ "integer")) {
    ARRAY_LEAF_VALUE=$3
  }
}
(_keyFound == 1) { 
  if (($2 ~ "string") || ($2 ~ "date") || ($2 ~ "integer")) {
    LEAF_KEY=_key
    LEAF_VALUE=$3
  } else {
    PARENT_KEY=_key;
    PARENT_KEY_LEVEL++;
    if (_key == "_properties") {exit 0}
  }
}
_keyFound=0;

($2 ~ "key"){ 
  _key=$3;
  _keyFound=1; 
}
($2 == "array") {
  _arrayFound=1;
}
($2 == "/array") {
  _arrayFound=0;
}
($2 == "dict"){
  printAll(); 
  _dictOpenTags++;
}
($2 == "/dict"){
  printAll(); 
  _dictOpenTags--;
}

(_dictOpenTags == 2) {
  printTopLevel();
}























