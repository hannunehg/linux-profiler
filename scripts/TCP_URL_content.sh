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

MD5CMD=$(command -v md5sum)
if [ -z "$MD5CMD"  ]; then
        MD5CMD=$(command -v md5)
        if [ -z "$MD5CMD"  ]; then
                echo "UNK::0::Unabe to find a compatible md5 command";
                exit;
        fi
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
if [ -z "$TVAL" ]; then
        echo "BAD::$NVAL::Page not found";
        exit;
fi
TVAL=$(echo "$TVAL" | "$MD5CMD" | awk '{print $1}' )
echo "OK::$NVAL::$TVAL"
