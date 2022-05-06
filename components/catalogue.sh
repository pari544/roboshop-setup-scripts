#!/usr/bin/env bash

source components/common.sh
checkRootUser





# mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
# systemctl daemon-reload
# systemctl start catalogue
# systemctl enable catalogue

ECHO "Configure the NodeJS Yum Repos"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG_FILE}
statusCheck $?

ECHO "Install the NodeJS"
yum install nodejs gcc-c++ -y &>>${LOG_FILE}
statusCheck $?

id roboshop &>>${LOG_FILE}
  if [ $? -ne 0 ]; then
  ECHO "Add Application User"
  useradd roboshop
  statusCheck $?
fi

