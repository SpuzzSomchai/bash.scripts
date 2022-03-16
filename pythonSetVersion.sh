#!/bin/bash

select OPTION in 'python2.7' 'python3.6' 
do
    echo alias python="'/usr/bin/$OPTION'";
    alias python='/usr/bin/$OPTION';
    echo . ~/.bashrc;
    . ~/.bashrc
    break;
done
echo "Python vesion set to $OPTION";
