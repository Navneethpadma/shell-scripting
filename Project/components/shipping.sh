#!/bin/bash

source components/common.sh
COMPONENT=shipping

OS_Prereqs

print "Install Maven"
yum install maven -y
STAT $? "Installing Maven"

RoboShop_App_User_Add
Downloading_component_from_git
Extraction_components

print "Compile Shipping Code"
cd /home/roboshop/shipping
mvn clean package && mv target/shipping-1.0.jar shipping.jar
STAT $? "Compiling Shipping Code"

setup_service