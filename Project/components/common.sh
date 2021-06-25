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
  echo -e "\e[1;35m [Error] Failure $2\e[0m"
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
  curl -s -L -o /tmp/${COMPONENT} .zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"
  STAT $? "Successful downloading zip files"
}

Download_components_catalogue(){
  print "Setting up ${COMPONENT}  files"
  cd /home/roboshop
  rm -rf ${COMPONENT} && unzip /tmp/${COMPONENT}.zip && mv ${COMPONENT}-main ${COMPONENT}
  STAT $? "Extraction successful"
}

INSTALL_NIDEJS_DEPENDENCIES()

{
  print "Node js dependencies"
  cd /home/roboshop/catalogue
  npm install --unsafe-perm
  STAT $? "downloading dependencies successful"

}

setup_service() {
  PRINT "Setup SystemD Service for ${COMPONENT}"
  mv /home/roboshop/$(COMPONENT)/systemd.service /etc/systemd/system/catalogue.service
  sed -i  -e 's/MONGO_DNSNAME/mongodb.thenavops.com/' /etc/systemd/system/${COMPONENT}.service
  systemctl daemon-reload && systemctl start catalogue && systemctl enable catalogue
  STAT $? "Starting ${COMPONENT} Service"

}

NodeJS_SETUP(){
  NodeJS_Install
  Roboshop_username_add
  Downloading_component_from_git
  Download_components_catalogue
  INSTALL_NIDEJS_DEPENDENCIES
  setup_service
}
