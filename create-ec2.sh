#!/bin/bash

if [ -z $1 ]; then
  echo "Instance name as the first argument is needed"
  exit 1
fi

INSTANCE-NAME = $1

aws ec2 describe-spot-instance-requests --filters Name=tag:Name,Values=${INSTANCE-NAME} Name=State,Values=active --output table | grep InstanceId &>/dev/null

if [ $? -eq 0 ]; then
  echo "Instance already exists"
  exit 0
fi

AMI_ID = $(aws ec2 describe-images  --filters "Name=Centos-7-DevOps-Practice,Values=windows" --output table | grep ImageId | awk '{print $4}')

aws ec2 run-instances --image-id ${AMI_ID} --instance-type t3.micro --instance-market-options
"MarketType=spot,SpotOptions={SpotInstanceType=persistent,InstanceInterruptionBehavior=stop}" --tag-specifications
"ResourceType=spot-instances-request,Tags=[{Key=Name,Value=${INSTANCE-NAME}]"
"ResourceType=instance,Tags=[{Key=Name,Value=${INSTANCE-NAME}]"
