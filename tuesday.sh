if (whiptail --title "Is it Tuesday?" --yesno "Is today Tuesday?" 8 78); then
    echo "Happy Tuesday, exit status was $?."
else
    echo "Maybe it will be Tuesday tomorrow, exit status was $?."

fi