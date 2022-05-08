#!/usr/bin/env bash

source components/common.sh
checkRootUser

ECHO "Setup Yum Repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>${LOG_FILE}
statusCheck $?

ECHO "Install and RabbitMQ and Erlang"
yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.6/erlang-23.2.6-1.el7.x86_64.rpm -y &>>${LOG_FILE}
statusCheck $?

ECHO "Start RabbitMQ Service"
systemctl enable rabbitmq-server &>>${LOG_FILE} && systemctl start rabbitmq-server &>>${LOG_FILE}
statusCheck $?

ECHO "Create an Application User"
rabbitmqctl add_user roboshop roboshop123 &>>${LOG_FILE}
statusCheck $?

 # rabbitmqctl set_user_tags roboshop administrator
 # rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"