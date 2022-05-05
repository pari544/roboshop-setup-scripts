#!/usr/bin/env bash
source components/common.sh

checkRootUser

echo "Installing Nginx"
yum install nginx -y >/tmp/roboshop.log
statusCheck $?

echo "Downloading the Nginx"
 curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" >/tmp/roboshop.log
 statusCheck $?

 cd /usr/share/nginx/html

 echo "Removing the old files"
 rm -rf * >/tmp/roboshop.log
 statusCheck $?


 echo "Extracting the Zip Content"
 unzip /tmp/frontend.zip >/tmp/roboshop.log
 statusCheck $?

 echo "Copying the extracted content"
 mv frontend-main/* .
 mv static/* .
 rm -rf frontend-main README.md >/tmp/roboshop.log
 statusCheck $?

 echo "Copying the Roboshop nginx config"
 mv localhost.conf /etc/nginx/default.d/roboshop.conf
 statusCheck $?

 echo "Start Nginx Service"
 systemctl enable nginx >/tmp/roboshop.log
 systemctl restart nginx
 statusCheck $?


