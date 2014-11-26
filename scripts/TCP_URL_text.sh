!/bin/sh
# -----------------------------------
# Get URL Content
# -----------------------------------
# Copyright (c) 2014, Servoyant, LLC
# -----------------------------------
ARGC=$#
if [ $ARGC -eq 0 ]; then
        echo "UNK::0::Missing parameter"
        exit
fi
HTML2TEXT=$(command -v html2text)
if [ -z "$HTML2TEXT"  ]; then
        echo "UNK::0::This test requires the installation of the html2text package";
        exit;
fi
CURL=$(command -v curl)
if [ -z "$CURL"  ]; then
        echo "UNK::0::This test requires the installation of the curl package";
        exit;
fi
URL=$1
if [ $ARGC -eq 3 ]; then
        USER="--user $2:$3";
else
        USER=""; 
fi
_COMMAND="$CURL $USER --silent -k -L -m 10 $URL"
START=$(date +%s)
TVAL=$($_COMMAND)
END=$(date +%s)
NVAL=$(( $END - $START))
TVAL=$(echo "$TVAL" | "$HTML2TEXT" -ascii)
if [ -z "$TVAL" ]; then
        echo "BAD::$NVAL::Page not found";
        exit;
fi
echo "OK::$NVAL::$TVAL"