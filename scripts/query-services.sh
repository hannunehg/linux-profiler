#!/bin/bash
function ubuntuExtractInfo() {
  awk -vuser=$1 '
  BEGIN{
    print "<services>"
    FS="[ ,]"
  }
  {
    print "<record>"
    print "<servicename>"$1"</servicename>"
    print "<servicedisplayname>"$1"</servicedisplayname>"
    print "<pathname>/etc/init/"$1".conf</pathname>"
    print "<startname>"user"</startname>"
  }
  
  ($2 ~ "/") && !($2 ~ "\(") {
    print "<state>"$2"</state>"
  }
  ($3 ~ "/") && !($3 ~ "\(") {
    print "<state>"$3"</state>"
  }
  
  /,/{
    print "<processid>"$(NF)"</processid>"
  }
  {
    print "</record>"
  }
  END {
    print "</services>"
  }
  '
}
function macExtractInfo() {

echo "<services>"

for s in $(xargs)
do
sudo launchctl list $s | macServiceDetails $1
#echo $s
done
#sudo launchctl list com.oracle.java.JavaUpdateHelper | macServiceDetails $1
echo "</services>"


}
function macServiceDetails() {

awk -v user=$1 '
BEGIN{
state="Stopped"
startmode="NotOnDemand"
}

/Label/{
name=substr($3,2,length($3)-3);
}
/PID/{
state="Running";
proc=substr($3,0,length($3)-1)
}
# this means that ondemand is supported
/OnDemand/{
if ($0 ~ "true") {
    startmode="OnDemand"
}
}

(found==1){
pathname=substr($0,4,(length($0)-5))
found=0;
}
/ProgramArg/{
found=1;
}

END{
print "<record>"
print "<startname>"user"</startname>"
print "<servicename>"name"</servicename>"
print "<servicedisplayname>"name"</servicedisplayname>"
print "<pathname>"pathname"</pathname>"
print "<startmode>"startmode"</startmode>"
if ( proc != "") {
    print "<processid>"proc"</processid>"
}
print "<state>"state"</state>"
print "</record>"
}

'
}

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $dir

OS=`uname`
outXML=query-services.xml
case $OS in
  Linux)
      # extract root services (most of the time only root runs daemons)"
      sudo initctl list |  ubuntuExtractInfo "root" 1> $outXML 2> ._query-services.error
    ;;
  Darwin)
    sudo launchctl list |  awk '{print $3}' | macExtractInfo "root" 1> $outXML 2> ._query-services.error
;;
  *)		
    echo "Unsupported OS: $OS" >&2;;
esac

cd - >/dev/null

