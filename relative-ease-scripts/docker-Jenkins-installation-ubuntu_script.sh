#!/bin/bash
sudo hostname docker
sudo apt update -y
sudo apt install docker.io -y
sudo usermod -aG docker ubuntu 
# Install java as jenkins dependency
sudo apt install openjdk-11-jdk -y
# install jenkins in ubuntu:
sudo wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins -y 
sudo systemctl start jenkins 

echo "jenkins  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/jenkins 
sudo echo "jenkins:admin" | chpasswd
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
sudo service sshd restart
sudo usermod -aG  docker jenkins
