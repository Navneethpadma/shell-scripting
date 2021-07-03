#!/bin/bash

USER_ID=$(id -u)
if [ "${USER_ID}" -ne 0 ]; then
   echo you are not a root user goahed.
exit 1
fi

os_prereq(){
  set-hostname ${COMPONENT}
  disable-auto-shutdown
}

print()
{
echo "------------------------------------------------------------"
echo -e "\e[1;35m [INFORMATION] $1 \e[0m"
echo "------------------------------------------------------------"
}


STAT() {
if [ $1 -ne 0 ]; then
  echo "------------------------------------------------------------"
  echo -e "\e[1;31m [Error] Failure $2\e[0m"
  echo "------------------------------------------------------------"
  exit 2
else
  echo "------------------------------------------------------------"
  echo -e "\e[1;37m [succ] $2 is successful\e[0m"
  echo "------------------------------------------------------------"
fi
 }

NodeJS_Install()
{
  print "Installing Node J.s"
  yum install nodejs make gcc-c++ -y
  STAT $? "Node JS Installation successful"
}

Roboshop_username_add()
{
  id roboshop
  if [ $? -eq 0 ]; then
    print "USER ALREADY THERE"
    return
  fi
  print "Adding User"
  useradd roboshop
  STAT $? "successfully added user"
}

Downloading_component_from_git()
{
  print "Download ${COMPONENT} zip files"
  curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/roboshop-devops-project/${COMPONENT}/archive/main.zip"
  STAT $? "Successful downloading zip files"
}

Extraction_components()
{
  print "Setting up ${COMPONENT}  files"
  cd /home/roboshop
  rm -rf ${COMPONENT} && unzip /tmp/${COMPONENT}.zip && mv ${COMPONENT}-main ${COMPONENT}
  STAT $? "Extraction successful"
}

Extract_Component_to_tmp()
{
  print "Extract ${COMPONENT}"
  cd /tmp
  rm -rf ${COMPONENT} && unzip /tmp/${COMPONENT}.zip
  STAT $? "Extracting ${COMPONENT}"
}

INSTALL_NODEJS_DEPENDENCIES()
{
  print "Node js dependencies"
  cd /home/roboshop/${COMPONENT}
  npm install --unsafe-perm
  STAT $? "downloading dependencies successful"

}

setup_service() {
  print "Setup SystemD Service for ${COMPONENT}"
  mv /home/roboshop/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
  sed -i  -e 's/MONGO_DNSNAME/mongodb.thenavops.com/' \
          -e 's/MONGO_ENDPOINT/mongodb.thenavops.com/' \
          -e 's/REDIS_ENDPOINT/redis.thenavops.com/' \
          -e 's/CATALOGUE_ENDPOINT/catalogue.thenavops.com/' \
          -e 's/DBHOST/mysql.thenavops.com/'  \
          -e 's/CARTENDPOINT/cart.thenavops.com/' \
          -e "s/CARTHOST/cart.devopsb55.tk/" \
          -e "s/USERHOST/user.devopsb55.tk/" \
          -e "s/AMQPHOST/rabbitmq.devopsb55.tk/" \
          /etc/systemd/system/${COMPONENT}.service
  systemctl daemon-reload && systemctl restart ${COMPONENT} && systemctl enable ${COMPONENT}
  STAT $? "Starting ${COMPONENT} Service"

}

NodeJS_SETUP()
{
  NodeJS_Install
  Roboshop_username_add
  Downloading_component_from_git
  Download_components_catalogue
  INSTALL_NODEJS_DEPENDENCIES
  setup_service
}
