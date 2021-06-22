#!/bin/bash
source components/common.sh
print "Installing Nginx"
yum install nginx -y
STAT $? "Nginx Installation"




print  "Download frontend component"



curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
if [ $? -ne 0 ]; then
  echo "------------------------------------------------------------"
  echo -e "\e[1;35m [Error] download failure\e[0m"
  exit 2
else
  echo "------------------------------------------------------------"
  echo -e "\e[1;37m [succ] Download is successful\e[0m"
  echo "------------------------------------------------------------"
  echo "------------------------------------------------------------"
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