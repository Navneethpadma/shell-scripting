#!/bin/bash

source components/common.sh
COMPONENT=rabbitmq

OS_Prereqs

print "Install ErLang"
yum list installed | grep erlang
if [ $? -ne 0 ]; then
  yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.6/erlang-23.2.6-1.el7.x86_64.rpm -y
  STAT $? "Installing ErLang"
fi


print "Setup YUM repositories for RabbitMQ."
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash
STAT $? "Setting Up repos"

print "Install RabbitMQ Server"
yum install rabbitmq-server -y
STAT $? "Installing RabbitMQ Server"

print "Start RabbitMQ Service"
systemctl enable rabbitmq-server
systemctl start rabbitmq-server
STAT $? "Starting RabbitMQ Service"

print "Create RabbitMQ Application User"
rabbitmqctl list_users  | grep roboshop
if [ $? -ne 0 ]; then
  rabbitmqctl add_user roboshop roboshop123
fi
rabbitmqctl set_user_tags roboshop administrator && rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
STAT $? "Creating RabbitMQ App User"