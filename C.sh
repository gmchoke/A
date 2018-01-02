#!/bin/bash 
# # Original script by fornesia, rzengineer and fawzya 
# Mod by kguza wullop onuamit
# ==================================================
# go to root
cd 
# Install Command 
apt-get -y install ufw 
apt-get -y install sudo
# set repo 
wget -O /etc/apt/sources.list "https://raw.githubusercontent.com/gmchoke/D/master/sources.list.debian8"
wget "https://raw.githubusercontent.com/gmchoke/D/master/dotdeb.gpg"
wget "https://raw.githubusercontent.com/gmchoke/GMCHOKE1/master/jcameron-key.asc"
cat dotdeb.gpg| apt-key add -;rm dotdeb.gpg 
cat jcameron-key.asc | apt-key add -;rm jcameron-key.asc 
# update
apt-get update 
# install webserver 
apt-get -y install nginx 
# install essential package
apt-get -y install nano iptables dnsutils openvpn screen whois ngrep unzip unrar 
# install neofetch 
echo "deb http://dl.bintray.com/dawidd6/neofetch jessie main" | sudo tee -a /etc/apt/sources.list 
curl -L "https://bintray.com/user/downloadSubjectPublicKey?username=bintray"-o Release-neofetch.key&&sudo apt-key add Release-neofetch.key&&rm Release-neofetch.key 
apt-get update
apt-get install neofetch 
echo "clear">> .bashrc 
echo 'echo -e " 
