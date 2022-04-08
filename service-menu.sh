#!/bin/bash

if [ -z $1 ]; then
    ACTION="-ss"
else
	ACTION="$1"
fi
clear;

HDD_SPACE=$(df -h | grep "centos")

echo ".__ .___.  . __..___.__ .  .   .  ..___"
echo "|  \[__ \  /(__ [__ [__)\  /   |\/|[__ "
echo "|__/[___ \/ .__)[___|  \ \/  * |  |[___"
echo " ";
echo " ";
[[ "$ACTION" == "-r" ]] && echo "Select Service / Container to Restart";
[[ "$ACTION" == "-s" ]] && echo "Select Service / Container Inspect or get Status";
[[ "$ACTION" == "-ss" ]] && echo "Select Service / Container Start or Stop";
echo "┌────────────────────────────────────────────────┐";
echo "│ -ss	: Start / Stop Service or Container      │";
echo "│ -r	: Restart Service or Container           │";
echo "│ -s	: Get the Status of Service or Container │";
echo "│ -rs 	: Show all Active and Running Services   │";
echo "│ -es 	: Show all Active but Exited Services    │";
echo "│ -rc 	: Show all Active and Running Containers │";
echo "│ -ec 	: Show all Active but Stopped Containers │";
echo "╘════════════════════════════════════════════════╛";
echo $HDD_SPACE
echo " ";
function serviceStartStop {
   STATUS=$(systemctl status "$1" | grep Active | awk '{print $2}')
   echo "$1 is currently $STATUS";
   if [ "$STATUS" == "active" ]; then
      echo "Stopping Service: $1";
      systemctl stop "$1" & echo "Done" || echo "failed";
   elif [ "$STATUS" == "inactive" ]; then
   	echo "Staring Service: $1"
      systemctl start "$1" && echo "Done" || echo "failed"
   elif [ "$STATUS" == "failed" ]; then    
      echo "See systemctl status $1.service and journalctl -xe for details."     
      systemctl start "$1" && echo "Done" || echo "failed";
	   JOURNAL=$(journalctl -xe)
	   echo "Journal: "
       echo "$JOURNAL"
   fi
   systemctl status "$1"
}

function serviceRestart {
    echo "Restarting $1"
    systemctl restart "$1"
	systemctl status "$1"
}

function serviceInspect {
    echo "Getting $1 Status"
    systemctl status "$1"
}


function dockerStartStop {
   STATUS=$(docker ps -a | grep "$1" | awk '{print $7}' )
   echo "$1 is currently $STATUS";
   if [ "$STATUS" == "Up" ]; then
      echo "Stopping Docker Container: $1";
      docker stop "$1" & echo "Done" || echo "failed" wait;
   else 
      echo "Staring Docker Container: $1";
      docker start "$1" & echo "Done" || echo "failed" wait;
   fi
   STATUS=$(docker ps -a | grep "$1")
   echo "$STATUS"
}

function dockerRestart {
    echo "Restarting $1"
    docker restart "$1"
}

function dockerInspect {
    echo "Inspecting $1 Container"
    docker container inspect "$1"
}

[[ "$ACTION" == "-rs" ]] && systemctl list-units --type=service --state=running  --all                  
[[ "$ACTION" == "-es" ]] && systemctl list-units --type=service --state=exited
[[ "$ACTION" == "-rc" ]] && docker ps
[[ "$ACTION" == "-ec" ]] && docker ps --filter "status=exited"


select OPTION in coder-cloud-redirect code-server cockpit cloud9 cloudcmd cockpit containerd dashboard docker droppy fail2ban flamedashboard heimdall hoppscotch httpd mattermost mariadb nginx n8n paperwork proxyManager nginxproxy_db_1 portainer postgresql-14 redis smb nmb rstudio-server tomcat organizr EXIT
do
	case $OPTION in 
	coder-cloud-redirect|cockpit|code-server|docker|containerd|docker|fail2ban|httpd|mattermost|mariadb|nginx|postgresql-14|redis|smb|nmb|tomcat|rstudio-server|vault)
		[[ "$ACTION" == "-r" ]] && serviceRestart "$OPTION";
	    [[ "$ACTION" == "-s" ]] && serviceInspect "$OPTION";
		[[ "$ACTION" == "-ss" ]] && serviceStartStop "$OPTION";
		break
   ;;
	cloud9|dashboard|droppy|flamedashboard|heimdall|hoppscotch|organizr|paperwork|portainer|proxyManager|nginxproxy_db_1)
		[[ "$ACTION" == "-r" ]] && dockerRestart "$OPTION";
		[[ "$ACTION" == "-s" ]] && dockerInspect "$OPTION";
		[[ "$ACTION" == "-ss" ]] && dockerStartStop "$OPTION";
      break;
   ;;
   EXIT)
      break
   ;;

   *) 
		echo "That was an invalid option, try agian"
	;;
	esac
done

