#!/bin/bash

USER_ID=$(id -u)
if ["${USER_ID}" -eq 0]; then
   echo -e you are a root used goahed.
fi



yum install nginx -y