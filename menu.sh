#!/bin/bash
echo "Start / Stop Services"

function serviceStatus {
   STATUS="systemctl status nginx | grep Active | awk '{print $2}'"

}
SERVICES="httpd mariadb nginx portainer heimdall couch-db flamedashboard Monitorr code-server cockpit cloud9 "
SERVICE=NULL

select OPTION in $SERVICES; do
   STATUS="systemctl status nginx | grep Active | awk '{print $2}'"
   case "$OPTION" in
   1) if [ "$STATUS" ==  "active" ]; then
         serviceStatus $OPTION $STATUS 
      fi
      if [ "$STATUS" == "active" ]; then
         :
      fi
      if [ "$STATUS" == "active" ]; then
         :
      fi
   ;;
   2)
   
   ;;
   *)

   ;; 
   esac
done
echo "Start / Stop $OPTION. $SERVICE?"
