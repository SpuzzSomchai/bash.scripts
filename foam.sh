#!/bin/bash

echo " ___  __               __   __                      ___ ";
echo "|__  /  \  /\   |\/|  |__) |__)  /\  | |\ |   |\/| |__  ";
echo "|    \__/ /~~\  |  | .|__) |  \ /~~\ | | \| . |  | |___ ";

echo "01000110    01001111    0100001    01001101    00101110 ";
echo "01000010    01010010    0100001    01001001    01001110 ";


echo "┌───────────────────────────────────────---------─────────┐";
echo "│ INSTRUCTIONS - NEW FOAM BAIN                            │";
echo "│ foam [path to new foam brain]                           │";
echo "│                                                         │";
echo "│ Example:                                                │";
echo "│ foam /var/www/zzz/newBrain                              │";
echo "│                                                         │";
echo "│ The above example will create directory                 │";
echo "│ mkdir -p /var/www/zzz/newBrain                          │";
echo "│ cp /srv/scripts/foam/template/* /var/www/zzz/newBrain   │";
echo "│ cd /var/www/zzz/newBrain                                │";
echo "│                                                         │";
echo "│ Then if you have code-server installled it will attempt │";
echo "│ to open vscode in the new foam brain                    │";
echo "└─────────────────────────────────────────────---------───┘";
echo " ";
echo "ENTER THE FULL PATH OF NEW FOAM BRAIN";
read BRAIN_PATH

echo "CONFIRM FOAM PATH: $BRAIN_PATH ? yn";
read -p "Continue? (y/n):" yn
echo " ";
case $yn in
  [Yy]* ) 
    mkdir -p "$BRAIN_PATH";  
    cp -R /srv/scripts/foam/template/* $BRAIN_PATH/
    cd "$BRAIN_PATH"
    ;;
  [Nn]* ) break; exit;;
 
    * ) echo "Goodbye!" break;
    ;; 
esac

echo " ";
echo " "; 
echo "by Charl Cronje - http://charl-cv.devserv.me";