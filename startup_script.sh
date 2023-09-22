#!/bin/bash

sudo yum update -y
sudo yum install nginx -y

sudo systemctl start nginx

echo "<html><head><title>Bienvenue</title></head><body><h1>I am Gro0t</h1></body></html>" | sudo tee /usr/share/nginx/html/index.html

sudo systemctl restart nginx

sudo systemctl enable nginx