#!/bin/bash

USER_ID=$(id -u)
if [ "${USER_ID}" -ne 0 ]; then
   echo you are not a root user goahed.
exit 1
fi

print()
{
echo "------------------------------------------------------------"
echo -e "\e[1;35m [INFORMATION] $1 \e[0m"
echo "------------------------------------------------------------"
}


STAT() {
if [ $? -ne 0 ]; then
  echo "------------------------------------------------------------"
  echo -e "\e[1;35m [Error] Failure Installing Nginx\e[0m"
  echo "------------------------------------------------------------"
  exit 2
else
  echo "------------------------------------------------------------"
  echo -e "\e[1;37m [succ] Nginx installation is successful\e[0m"
  echo "------------------------------------------------------------"
fi

}