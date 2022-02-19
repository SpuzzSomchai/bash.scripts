#!/bin/bash

STATUS=$(systemctl status nginx | grep Active | awk '{print $2}')
echo "$STATUS"
