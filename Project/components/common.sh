#!/bin/bash

USER_ID=$(id -u)
if [ "${USER_ID}" -ne 0 ]; then
   echo you are not a root user goahed.
exit 1
fi

set-hostname ${component}
disable-auto-shutdown

print()
{
echo "------------------------------------------------------------"
echo -e "\e[1;35m [INFORMATION] $1 \e[0m"
echo "------------------------------------------------------------"
}


STAT() {
if [ $1 -ne 0 ]; then
  echo "------------------------------------------------------------"
  echo -e "\e[1;35m [Error] Failure $2\e[0m"
  echo "------------------------------------------------------------"
  exit 2
else
  echo "------------------------------------------------------------"
  echo -e "\e[1;37m [succ] $2 is successful\e[0m"
  echo "------------------------------------------------------------"
fi
 }

NodeJS_Install()
{
  print "Installing Node J.s"
  yum install nodejs make gcc-c++ -y
  STAT $? "Node JS Installation successful"
}




