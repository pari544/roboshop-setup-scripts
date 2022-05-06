!/usr/bin/env bash
source components/common.sh

checkRootUser

ECHO "Setup MongoDB Yum repo"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo
statusCheck $?

ECHO "Installing the MongoDB"
yum install -y mongodb-org
statusCheck $?

ECHO "Configure the listen in MongoDB configuration"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
statusCheck $?


#systemctl enable mongod
#systemctl start mongod
#systemctl restart mongod

#curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"
#cd /tmp
#unzip mongodb.zip
#cd mongodb-main
#mongo < catalogue.js
#mongo < users.js