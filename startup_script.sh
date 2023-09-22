#!/bin/bash

sudo amazon-linux-extras install nginx1.12 -y

sudo systemctl start nginx

sudo systemctl enable nginx