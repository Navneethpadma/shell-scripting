#!/bin/bash

echo -e "\e[1;35m [INFORMATION] Installing Nginx\e[0m"
echo "------------------------------------------------------------"
echo "------------------------------------------------------------"

yum install nginx -y
if [ $? -ne 0 ]; then
  echo -e "\e[1;35m [Error] Failure Installing Nginx\e[0m"
  exit 2
else
  echo -e "\e[1;40m [succ] Nginx installation is sucessful\e[0m"
fi
echo "------------------------------------------------------------"
echo "------------------------------------------------------------"

exit



curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
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