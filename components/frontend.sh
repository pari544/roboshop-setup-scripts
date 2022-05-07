#!/usr/bin/env bash
source components/common.sh

checkRootUser

ECHO "Installing Nginx"
yum install nginx -y &>>${LOG_FILE}
statusCheck $?

ECHO "Downloading the Nginx"
 curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>${LOG_FILE}
 statusCheck $?

 cd /usr/share/nginx/html

 ECHO "Removing the old files"
 rm -rf * &>>${LOG_FILE}
 statusCheck $?


 ECHO "Extracting the Zip Content"
 unzip /tmp/frontend.zip &>>${LOG_FILE}
 statusCheck $?

 ECHO "Copying the extracted content"
 mv frontend-main/* . &>>${LOG_FILE} && mv static/* . &>>${LOG_FILE} && rm -rf frontend-main README.md &>>${LOG_FILE}
 statusCheck $?

 ECHO "Copying the Roboshop nginx config"
 mv localhost.conf /etc/nginx/default.d/roboshop.conf &>>${LOG_FILE}
 statusCheck $?

 ECHO "Update the Nginx Configuration"
 sed -i -e '/catalogue/ s/localhost/catalogue.roboshop.internal/' -e '/user/ s/localhost/user.roboshop.internal/' -e '/cart/ s/localhost/cart.roboshop.internal/' /etc/nginx/default.d/roboshop.conf
 statusCheck $?

 ECHO "Start Nginx Service"
 systemctl enable nginx &>>${LOG_FILE}
 systemctl restart nginx
 statusCheck $?


