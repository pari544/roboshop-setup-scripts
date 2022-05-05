#!/usr/bin/env bash

source components/common.sh

checkRootUser

 echo Installing Nginx
 yum install nginx -y >/tmp/roboshop.log
 if [ $? -eq 0 ]; then
   echo -e "\e[32mSUCCESS\e[0m"
 else
   echo -e "\e[31mFAILURE\e[m0"
   exit 1
fi

echo "Downloading the Nginx"
 curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" >/tmp/roboshop.log
 if [ $? -eq 0 ]; then
   echo -e "\e[32mSUCCESS\e[0m"
 else
   echo -e "\e[31mFAILURE\e[m0"
   exit 1
fi

 cd /usr/share/nginx/html

 echo "Removing the old files"
 rm -rf * >/tmp/roboshop.log
  if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE\e[m0"
    exit 1
 fi


 echo "Extracting the Zip Content"
 unzip /tmp/frontend.zip >/tmp/roboshop.log
 if [ $? -eq 0 ]; then
   echo -e "\e[32mSUCCESS\e[0m"
 else
   echo -e "\e[31mFAILURE\e[m0"
   exit 1
fi

 echo "Copying the extracted content"
 mv frontend-main/* .
 mv static/* .
 rm -rf frontend-main README.md >/tmp/roboshop.log
 if [ $? -eq 0 ]; then
   echo -e "\e[32mSUCCESS\e[0m"
 else
   echo -e "\e[31mFAILURE\e[m0"
   exit 1
fi

 echo "Copying the Roboshop nginx config"
 mv localhost.conf /etc/nginx/default.d/roboshop.conf
 if [ $? -eq 0 ]; then
   echo -e "\e[32mSUCCESS\e[0m"
 else
   echo -e "\e[31mFAILURE\e[m0"
   exit 1
fi

 echo "Start Nginx Service"
 systemctl enable nginx >/tmp/roboshop.log
 systemctl restart nginx
 if [ $? -eq 0 ]; then
   echo -e "\e[32mSUCCESS\e[0m"
 else
   echo -e "\e[31mFAILURE\e[m0"
   exit 1
fi


