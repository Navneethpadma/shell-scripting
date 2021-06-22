#!/bin/bash

echo "------------------------------------------------------------"
echo -e "\e[1;35m [INFORMATION] Installing Nginx\e[0m"
echo "------------------------------------------------------------"

yum install nginx -y
if [ $? -ne 0 ]; then
  echo "------------------------------------------------------------"
  echo -e "\e[1;35m [Error] Failure Installing Nginx\e[0m"
  exit 2
else
  echo "------------------------------------------------------------"
  echo -e "\e[1;40m [succ] Nginx installation is successful\e[0m"
fi

echo "------------------------------------------------------------"
echo "------------------------------------------------------------"
echo -e "\e[1;35m [INFORMATION] Installing Nginx\e[0m"
echo "------------------------------------------------------------"


echo "------------------------------------------------------------"
echo -e "\e[1;35m [INFORMATION] Download frontend component\e[0m"
echo "------------------------------------------------------------"



curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
if [ $? -ne 0 ]; then
  echo "------------------------------------------------------------"
  echo -e "\e[1;35m [Error] download failure\e[0m"
  exit 2
else
  echo "------------------------------------------------------------"
  echo -e "\e[1;40m [succ] Download successful is successful\e[0m"
fi

exit

cd /usr/share/nginx/html
rm -rf *
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-master README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
systemctl restart nginx

systemctl enable nginx
systemctl start nginx