#!/bin/bash
source components/common.sh

COMPONENT=catalogue

NodeJS_Install
Roboshop_username_add
Downloading_component_from_git
Download_components_catalogue
INSTALL_NIDEJS_DEPENDENCIES



#print "Roboshop login"
#su -robohop
#STAT $? "I am a roboshop user now"





print "Node js dependencies"
cd /home/roboshop/catalogue
npm install
STAT $? "downloading dependencies successful"



#mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
# systemctl daemon-reload
# systemctl start catalogue
# systemctl enable catalogue