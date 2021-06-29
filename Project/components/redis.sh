#!/bin/bash
source components/common.sh
component=mongodb
os_prereq

print "Set up redis repo"
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
STAT $? "Setting up redis repo"

print "Install redis"
yum install redis -y
STAT $? " Installing Redis"

print "Update redis configuration file"
sed -i -e '/^bind 0.0.0.0' /etc/redis.conf
STAT $? "Updating configuration files of redis"

print "Start Redis service"
systemctl enable redis
systemctl restart redis
STAT $? "Starting Redis Service"





