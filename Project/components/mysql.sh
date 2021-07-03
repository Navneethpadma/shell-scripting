#!/bin/bash
source components/common.sh
component=mysql
os_prereq

print "Setting up Mysql repo"
echo '[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
enabled=1
gpgcheck=0' > /etc/yum.repos.d/mysql.repo
STAT $? "Setting up Mysql repo"


print "Install Mysql"
Install MySQL
yum remove mariadb-libs -y
yum install mysql-community-server -y
STAT $? "Installing Mysql"

print "Start Mysql Service"
Start MySQL.
systemctl enable mysqld
systemctl start mysqld
STAT $? "Starting Mysql Service"

Print "Change the Default Password"
echo show databases | mysql -uroot -pRoboShop@123
if [ $? -ne 0 ]; then
  DEFAULT_PASSWORD=$(grep 'temporary password' /var/log/mysqld.log |awk '{print $NF}')
  echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@123';
uninstall plugin validate_password;" >/tmp/sql
  mysql --connect-expired-password -u root -p"${DEFAULT_PASSWORD}" </tmp/sql
  STAT $? "Changing MySQL Default Password"
else
  PRINT "MySQL Password reset is not required"
fi

Downloading_component_from_git()

Extract_Component_to_tmp()

PRINT "Load Shipping Service Schema"
cd /tmp/mysql-main
mysql -u root -pRoboShop@123 <shipping.sql
STAT $? "Loading Schema"

#Next, We need to change the default root password in order to start using the database service.
#mysql_secure_installation

#ou can check the new password working or not using the following command.

#mysql -u root -p

#Run the following SQL commands to remove the password policy.
#> uninstall plugin validate_password;
#> ALTER USER 'root'@'localhost' IDENTIFIED BY 'password';
#Setup Needed for Application.
#As per the architecture diagram, MySQL is needed by

#Shipping Service
#So we need to load that schema into the database, So those applications will detect them and run accordingly.

#To download schema, Use the following command

# curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip"
#Load the schema for Services.

# cd /tmp
# unzip mysql.zip
# cd mysql-main
# mysql -u root -ppassword <shipping.sql