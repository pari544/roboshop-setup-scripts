#!/usr/bin/env bash

source components/common.sh
checkRootUser

ECHO "Setup the MySQL Yum repo"
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo &>>${LOG_FILE}
statusCheck $?

ECHO "Install the MySQL Server"
yum install mysql-community-server -y &>>${LOG_FILE}
statusCheck $?

ECHO "Start MySQL Service"
systemctl enable mysqld &>>${LOG_FILE} && systemctl start mysqld &>>${LOG_FILE}
statusCheck $?

DEFAULT_PASSWORD=$(grep 'A Temporary Password' /var/log/mysqld.log | awk '${print $NF}')
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1';" >/tmp/root-pass.sql

ECHO "Reset MySQL Password"
mysql --connect-expired-passwrod -u root -p${DEFAULT_PASSWORD} </tmp/root-pass.sql &>>${LOG_FILE}
statusCheck $?

#mysql_secure_installation

#uninstall plugin validate_password;
#curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip"
#cd /tmp
# unzip mysql.zip
# cd mysql-main
# mysql -u root -pRoboShop@1 <shipping.sql