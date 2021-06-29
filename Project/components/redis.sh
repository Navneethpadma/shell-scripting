#!/bin/bash
source components/common.sh
component=mongodb
os_prereq

print "Set up redis repo"
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
STAT $? "Setting up redis repo"

print "Install redis"
yum install redis -y
STAT $? " Installing Redis  "
