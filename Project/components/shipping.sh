#!/bin/bash

source components/common.sh
COMPONENT=shipping

OS_Prereqs

PRINT "Install Maven"
yum install maven -y
STAT $? "Installing Maven"

RoboShop_App_User_Add
Download_Component_From_GitHub
Extract_Component

PRINT "Compile Shipping Code"
cd /home/roboshop/shipping
mvn clean package && mv target/shipping-1.0.jar shipping.jar
STAT $? "Compiling Shipping Code"

Setup_Service