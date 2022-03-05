#!/bin/bash

if [ -z $1 ]; then      # This is true when no param is set
    ACTION="-ss"        
else
	ACTION="$1"
fi
clear;                  # Clear the screen
echo ".__ .___.  . __..___.__ .  .   .  ..___"
echo "|  \[__ \  /(__ [__ [__)\  /   |\/|[__ "
echo "|__/[___ \/ .__)[___|  \ \/  * |  |[___"
echo " "
echo " ";
# Set Heading Depending on the param specified
[[ "$ACTION" == "-r" ]] && echo "Select Service / Container to Restart";            
[[ "$ACTION" == "-s" ]] && echo "Select Service / Container Inspect or get Status";
[[ "$ACTION" == "-ss" ]] && echo "Select Service / Container Start or Stop";
# Draw nice help menu
echo "┌────────────────────────────────────────────────┐"
echo "│ -ss	: Start / Stop Service or Container      │"
echo "│ -r	: Restart Service or Container           │"
echo "│ -s	: Get the Status of Service or Container │"
echo "│ -rs 	: Show all Active and Running Services   │"
echo "│ -es 	: Show all Active but Exited Services    │"
echo "│ -rc 	: Show all Active and Running Containers │"
echo "│ -ec 	: Show all Active but Stopped Containers │"
echo "└────────────────────────────────────────────────┘"

# Start or stop a service, if it is running it will be stopped, if it is not running it will be started
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

# Restart selected service
function serviceRestart {
    echo "Restarting $1"
    systemctl restart "$1"
	systemctl status "$1"
}

# Get the status of selected service
function serviceInspect {
    echo "Getting $1 Status"
    systemctl status "$1"
}


# Start or stop a container, if it is running it will be stopped, if it is not running it will be started
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

# Restart selected container
function dockerRestart {
    echo "Restarting $1"
    docker restart "$1"
}

# Inspect selected container
function dockerInspect {
    echo "Inspecting $1 Container"
    docker container inspect "$1"
}

# List all running services
[[ "$ACTION" == "-rs" ]] && systemctl list-units --type=service --state=running  --all
# List all exited services
[[ "$ACTION" == "-es" ]] && systemctl list-units --type=service --state=exited
# List all running containers
[[ "$ACTION" == "-rc" ]] && docker ps
# List all exited containers
[[ "$ACTION" == "-ec" ]] && docker ps --filter "status=exited"

# main menu options 
select OPTION in code-server coder-cloud-redirect codiad cloud9 cloudcmd couchDb cockpit containerd dashboard dashmachine dillinger docker doublecommander droppy fail2ban flamedashboard heimdall httpd mariadb mumin-node nginx n8n portainer rstudio-server snippetbox Olivetin organizr vikunja vsc-server EXIT
do
	case $OPTION in 
	httpd|mariadb|nginx|cloudcmd|code-server|coder-cloud-redirect|cockpit|containerd|docker|fail2ban|mumin-node|Olivetin|rstudio-server|vault|vikunja) # These are all the services
		[[ "$ACTION" == "-r" ]] && serviceRestart "$OPTION";
	    [[ "$ACTION" == "-s" ]] && serviceInspect "$OPTION";
		[[ "$ACTION" == "-ss" ]] && serviceStartStop "$OPTION";
		break
   ;;
	portainer|codiad|droppy|snippetbox|organizr|heimdall|couchDb|dashboard|dashmachine|flamedashboard|cloud9|doublecommander|dillinger|vsc-server) #these are all the containers
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