#!/bin/bash
#Script auto create user SSH

read -p "ชื่อผู้ใช้งาน : " Login
read -p "รหัสผ่าน   : " Pass
read -p "กำหนดกี่วัน (hari): " masaaktif

IP=`dig +short myip.opendns.com @resolver1.opendns.com`
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e ""
echo -e "====Informasi SSH Account===="
echo -e "Host: $IP" 
echo -e "Port OpenSSH: 22,143"
echo -e "Port Dropbear: 80,443"
echo -e "Port Squid: 8080,3128"
echo -e "Config OpenVPN (TCP 1194): http://$IP:81/client.ovpn"
echo -e "ชื่อผู้ใช้งาน: $Login "
echo -e "รหัสผ่าน  : $Pass"
echo -e "-----------------------------"
echo -e "หมดอายุวันที่ตั้ง: $exp"
echo -e "============================="
echo -e "จัดทำโดย GM CHOKE"
echo -e ""
