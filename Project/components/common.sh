#!/bin/bash

USER_ID=$(id -u)
if [ "${USER_ID}" -ne 0 ]; then
   echo you are not a root user goahed.
exit
fi