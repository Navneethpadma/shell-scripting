#!/bin/bash
source components/common.sh
component=frontend
os_prereq

print "Installing Nginx"
yum install nginx -y
STAT $? "Nginx Installation"

print  "Download frontend component"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
STAT $? "Download of Frontend files"


print "Extract frontend"

cd /usr/share/nginx/html
rm -rf *
unzip /tmp/frontend.zip

STAT $? "Extracting frontend"

mv frontend-main/* .
mv static/* .
rm -rf frontend-master README.md

print "Update nginx config"
mv localhost.conf /etc/nginx/default.d/roboshop.conf
STAT $? "Updating Nginx config"

print "Start Nginx service"


systemctl enable nginx
systemctl restart nginx
STAT $? "Restarting Nginx service"