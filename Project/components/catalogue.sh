#!/bin/bash
source components/common.sh
components=catalogue

print "Installing Node J.s"
yum install nodejs make gcc-c++ -y
STAT $? "Node JS Installation successful"

print "Adding User"
useradd roboshop
STAT $? "successfully added user"

#print "Roboshop login"
#su -robohop
#STAT $? "I am a roboshop user now"

print "Download catalogue zip files"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"
STAT $? "Successful downloading zip files"

print "Setting us Catalogue files"
cd /home/roboshop
rm -rf catalogue && unzip /tmp/catalogue.zip && mv catalogue-main catalogue
STAT $? "Extraction successful"

print "Node js dependencies"
cd /home/roboshop/catalogue
npm install
STAT $? "downloading dependencies successful"



#mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
# systemctl daemon-reload
# systemctl start catalogue
# systemctl enable catalogue