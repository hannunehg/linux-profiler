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

OS=`uname`

case $OS in
  Linux)
      # extract root services (most of the time only root runs daemons)"
      sudo initctl list |  ubuntuExtractInfo "root"
    ;;
  Darwin)
  	;;
  *)		
    echo "Unsupported OS: $OS" >&2;;
esac


