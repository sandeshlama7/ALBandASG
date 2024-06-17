#!/bin/bash

# Update all packages
yum update -y
dnf update -y

yum install nginx -y
systemctl start nginx

#Reverse Proxy
echo "server {
        listen 80;
        listen [::]:80;

        server_name _; # Public IPv4 Address

        location / {
           proxy_pass http://localhost:3000/;
        }
}" > /etc/nginx/conf.d/reverse.conf


curl -fsSL https://rpm.nodesource.com/setup_20.x | sudo bash -

dnf install nodejs -y
yum install git -y

git clone https://github.com/sandeshlama7/sample_todo.git

cd sample_todo
npm install

#Install mongodb
echo "[mongodb-org-7.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/amazon/2023/mongodb-org/7.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://pgp.mongodb.com/server-7.0.asc" > /etc/yum.repos.d/mongodb-org-7.0.repo

yum install -y mongodb-org
systemctl start mongod

#Run node app
node server.js &
#Restart nginx
systemctl restart nginx
