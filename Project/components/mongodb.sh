 #!/bin/bash
source components/common.sh
components=mongodb

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

print "Updating mongodb.conf"

sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
STAT $? "Conf is successfully updated"

print "Updating mongodb.conf"
systemctl enable mongod
systemctl restart mongod
STAT $? "mogodb restarted successful"

print "Download mongodb schema"
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"
STAT $? "mogodb schema download successful"

print "extrasct mongodb schema"
cd /tmp
unzip mongodb.zip
STAT $? "mogodb schema extract successful"


print "load schema"
cd mongodb-main
mongo < catalogue.js && mongo < users.js
STAT $? "mogodb schema load successful"



