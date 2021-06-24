 #!/bin/bash
source components/common.sh

print "setup mongodb repositories"
echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' >/etc/yum.repos.d/mongodb.repo
STAT $? "Mongodb installation is successful"

print "Installing mongodb files"
yum install -y mongodb-org
STAT $? "Mongodb installation is successful"
#print "Starting Mongodb"
#systemctl enable mongod
#systemctl start mongod
#STAT $? "Mongodb enabling is successful"

#/etc/mongod.conf
# systemctl restart mongod
# curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"

# cd /tmp
# unzip mongodb.zip
# cd mongodb-main
# mongo < catalogue.js
# mongo < users.js
