#!/usr/bin/env bash
source components/common.sh

checkRootUser

ECHO "Installing Nginx"
yum install nginx -y >> ${LOG_FILE}
statusCheck $?

ECHO "Downloading the Nginx"
 curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" >> ${LOG_FILE}
 statusCheck $?

 cd /usr/share/nginx/html

 ECHO "Removing the old files"
 rm -rf * >> ${LOG_FILE}
 statusCheck $?


 ECHO "Extracting the Zip Content"
 unzip /tmp/frontend.zip >> ${LOG_FILE}
 statusCheck $?

 ECHO "Copying the extracted content"
 mv frontend-main/* .
 mv static/* .
 rm -rf frontend-main README.md >> ${LOG_FILE}
 statusCheck $?

 ECHO "Copying the Roboshop nginx config"
 mv localhost.conf /etc/nginx/default.d/roboshop.conf >> ${LOG_FILE}
 statusCheck $?

 ECHO "Start Nginx Service"
 systemctl enable nginx >> ${LOG_FILE}
 systemctl restart nginx
 statusCheck $?


