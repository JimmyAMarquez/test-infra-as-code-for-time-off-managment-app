#!/bin/bash
 
 sudo chown -R 200:200 $PWD/nexus-data/
 sudo chown -R 200:200 $PWD/nexus-config/etc/karaf/system.properties 
  
 HOSTDOCKERGI=$(cat /etc/group | grep docker | awk '{gsub(/[a-z:]/,"")}1')

 echo "Host docker groupId $HOSTDOCKERGI" 
 
 export HOSTDOCKERGI=$HOSTDOCKERGI
