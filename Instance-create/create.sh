#!/bin/bash
LID=lt-04099ddc390082d00
LVER=2
COMPONENT=$1

if [ -z "${COMPONENT}" ]; then
  echo "Component name input is needed"
  exit 1
fi

aws ec2 run-instances --launch-template LaunchTemplateId=${LID},Version=${LVER} --tag-specifications "ResourceType=instance, Tags=[Key=Name, Value=${COMPONENT}]" | jq