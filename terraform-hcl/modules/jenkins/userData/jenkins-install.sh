#!bin/bash

# Set up
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
yum upgrade

# Installation
yum install fontconfig java -y
yum install jenkins -y

# Post-installation
systemctl daemon-reload
systemctl enable jenkins --now