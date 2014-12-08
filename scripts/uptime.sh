#!/bin/bash

a=$(uptime)
#a=$(cat tmp2)
tmp=${a#*up}
data=${tmp%, [0-9]* users*}

echo $data | awk '{
if ( $0 ~ "min") {
h=0;
if ( $0 ~ "day") {
d=$1;
m=$3;
}
else{
d=0;
m=$1;
}
}
else
{

if ( $0 ~ "day") {
d=$1;

if ($3 != "" ) {

split($3,b,/:/);
h=b[1] ;
split(b[2],c,/,/);
m=c[1];
}else {
h=0;
m=0;
}

} else
{
d=0;
split($1,b,/:/);
h=b[1] ;
split(b[2],c,/,/);
m=c[1];
}



}
}END{ print d"d, "h"h, "m"m"}'

