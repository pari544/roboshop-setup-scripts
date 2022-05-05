#!/usr/bin/env bash

source components/common.sh

checkRootUser

 echo Installing Nginx
 yum install nginx -y >/tmp/roboshop.log

echo "Downloading the Nginx"
 curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" >/tmp/roboshop.log

 cd /usr/share/nginx/html

 echo "Removing the old files"
 rm -rf * >/tmp/roboshop.log

 echo "Extracting the Zip Content"
 unzip /tmp/frontend.zip >/tmp/roboshop.log

 echo "Copying the extracted content"
 mv frontend-main/* .
 mv static/* .
 rm -rf frontend-main README.md >/tmp/roboshop.log

 echo "Copying the Roboshop nginx config"
 mv localhost.conf /etc/nginx/default.d/roboshop.conf

 echo "Start Nginx Service"
 systemctl enable nginx >/tmp/roboshop.log
 systemctl restart nginx


