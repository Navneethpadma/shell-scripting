#!/bin/bash
LID=lt-04099ddc390082d00
LVER=2
#COMPONENT=$1

if [ -z "$1" ]; then
  echo "Component name input is needed"
  exit 1
fi

Instance_Create()
{
 COMPONENT=$1
  INSTANCE_EXISTS=$(aws ec2 describe-instances --filters Name=tag:Name,Values=${COMPONENT}  | jq .Reservations[])
  STATE=$(aws ec2 describe-instances     --filters Name=tag:Name,Values=${COMPONENT}  | jq .Reservations[].Instances[].State.Name | xargs)
  if [ -z "${INSTANCE_EXISTS}" -o "$STATE" == "terminated"  ]; then
    aws ec2 run-instances --launch-template LaunchTemplateId=${LID},Version=${LVER}  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]" | jq
  else
    echo "Instance ${COMPONENT} already exists"
  fi

  IPADDRESS=$(aws ec2 describe-instances --filters Name=tag:Name,Values=${COMPONENT}  | jq .Reservations[].Instances[].PrivateIpAddress | grep -v null |xargs)

  sed -e "s/COMPONENT/${COMPONENT}/" -e "s/IPADDRESS/${IPADDRESS}/" record.json >/tmp/record.json
  aws route53 change-resource-record-sets --hosted-zone-id Z10472123M0B8WLNUQSQP --change-batch file:///tmp/record.json
}

if [ "$1" == "all" ]; then
  for instance in frontend mongodb catalogue redis user cart mysql shipping rabbitmq payment ; do
    Instance_Create $instance
  done
else
  Instance_Create $1
fi



#aws ec2 run-instances --launch-template LaunchTemplateId=${LID},Version=${LVER} --tag-specifications "ResourceType=instance, Tags=[{Key=Name,Value=${COMPONENT}}]" | jq