#!/usr/bin/env bash

source components/common.sh
checkRootUser

ECHO "Configure Yum Repos"
curl -L https://raw.githubusercontent.com/roboshop-devops-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo &>>${LOG_FILE}
statusCheck $?

ECHO "Install Redis"
yum install redis-6.2.7 -y &>>${LOG_FILE}
statusCheck $?

ECHO "Updated Redis configuration"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf
statusCheck $?

ECHO "Start Redis service"
systemctl enable redis &>>${LOG_FILE} && systemctl start redis &>>${LOG_FILE}
statusCheck $?





