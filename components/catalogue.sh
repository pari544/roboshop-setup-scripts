#!/usr/bin/env bash

source components/common.sh
checkRootUser


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

ECHO "Download Application Content"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>${LOG_FILE}
statusCheck $?

ECHO "Extract Application Archive"
cd /home/roboshop && rm -rf catalogue &>>${LOG_FILE} && unzip /tmp/catalogue.zip &>>${LOG_FILE} && mv catalogue-main catalogue
statusCheck $?

ECHO "Install NodeJS modules"
cd /home/roboshop/catalogue && npm install &>>${LOG_FILE} && chown roboshop:roboshop  /home/roboshop/catalogue -R
statusCheck $?

ECHO "Update SystemD Configuration files"
sed -i -e '/s/MONGO_DNSNAME/mongodb.roboshop.internal/' /home/roboshop/catalogue/systemd.service
statusCheck $?

ECHO "Setup systemd service"
mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
systemctl daemon-reload &>>${LOG_FILE} && systemctl enable catalogue &>>${LOG_FILE} && systemctl restart catalogue &>>${LOG_FILE}
statusCheck $?



