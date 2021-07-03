#!/bin/bash

source components/common.sh
COMPONENT=payment

OS_Prereqs

print "Install Python 3"
yum install python36 gcc python3-devel -y
STAT $? "Installing Python"

Roboshop_username_add
Downloading_component_from_git
Extraction_components


print "Install Python App dependencies"
cd /home/roboshop/payment
pip3 install -r requirements.txt
STAT $? "Installing Dependencies"

USER_ID=$(id -u roboshop)
GROUP_ID=$(id -g roboshop)

print "Update Payment Configuration"
sed -i -e "/^uid/ c uid = ${USER_ID}" -e "/^gid/ c gid = ${GROUP_ID}"  /home/roboshop/payment/payment.ini
STAT $? "Updating Payment Configuration"

setup_service