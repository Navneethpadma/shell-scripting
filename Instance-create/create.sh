#!/bin/bash
LID=lt-04099ddc390082d00
LVER=2
aws ec2 run-instances --launch-template LaunchTemplateId=${LID},Version=${LVER} | jq