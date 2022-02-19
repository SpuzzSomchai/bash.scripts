if [[ -z $1 ]]
then
    FIXPATH="-h"
	echo "fwp [path] [user:group]"
else 
	FIXPATH="$1"
	
	echo "setting folder permissions to 755 recursive from $FIXPATH"
	find "$FIXPATH" -type d -exec chmod 755 {} \;
	
	
	echo "setting file permissions to 644 recursive from $FIXPATH"
	find "$FIXPATH" -type f -exec chmod 644 {} \;
	
	
	if [[ -z $2 ]]
	GROUPTOSET="$2"
	then
		echo "Setting folder $FIXPATH to be owned by $GROUPTOSET"
		find "$FIXPATH" -exec chown "$GROUPTOSET" {} \;
	fi
	echo "restarting Apache"
	echo systemctl restart httpd
fi