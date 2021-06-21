#!/bin/bash

echo -e"\e[1;35m [INFORMATION] Installing Nginx\e[0m"
yum install nginx
if [ $? -ne 0]; then
  echo -e"\e[1;35m [Error] Failure Installing Nginx\e[0m"
  exit 2
fi

systemctl enable nginx
systemctl start nginx

curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
cd /usr/share/nginx/html
rm -rf *
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-master README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
systemctl restart nginx