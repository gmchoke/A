#!/bin/bash # go to root cd # Install Command apt-get -y install ufw apt-get -y install sudo # set repo wget -O /etc/apt/sources.list "http://tepsus-slow-vpn.xyz/scrip_auto/sources.list.debian" wget "http://tepsus-slow-vpn.xyz/scrip_auto/dotdeb.gpg" wget "http://tepsus-slow-vpn.xyz/scrip_auto/jcameron-key.asc" cat dotdeb.gpg | apt-key add -;rm dotdeb.gpg cat jcameron-key.asc | apt-key add -;rm jcameron-key.asc # update apt-get update # install webserver apt-get -y install nginx # install essential package apt-get -y install nano iptables dnsutils openvpn screen whois ngrep unzip unrar # install neofetch echo "deb http://dl.bintray.com/dawidd6/neofetch jessie main" | sudo tee -a /etc/apt/sources.list curl -L "https://bintray.com/user/downloadSubjectPublicKey?username=bintray" -o Release-neofetch.key && sudo apt-key add Release-neofetch.key && rm Release-neofetch.key apt-get update apt-get install neofetch echo "clear" >> .bashrc echo 'echo -e "\e [0m"' >> .bashrc echo 'echo -e ""' >> .bashrc # install webserver cd rm /etc/nginx/sites-enabled/default rm /etc/nginx/sites-available/default wget -O /etc/nginx/nginx.conf "http://tepsus-slow-vpn.xyz/scrip_auto/nginx.conf" mkdir -p /home/vps/public_html echo " " > /home/vps/public_html/index.html wget -O /etc/nginx/conf.d/vps.conf "http://tepsus-slow-vpn.xyz/scrip_auto/vps.conf" service nginx restart # install openvpn wget -O /etc/openvpn/openvpn.tar "http://tepsus-slow-vpn.xyz/scrip_auto/openvpn-debian.tar" cd /etc/openvpn/ tar xf openvpn.tar wget -O /etc/openvpn/1194.conf "http://tepsus-slow-vpn.xyz/scrip_auto/1194.conf" service openvpn restart sysctl -w net.ipv4.ip_forward=1 sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf iptables -t nat -I POSTROUTING -s 192.168.100.0/24 -o eth0 -j MASQUERADE iptables-save > /etc/iptables_yg_baru_dibikin.conf wget -O /etc/network/if-up.d/iptables "http://tepsus-slow-vpn.xyz/scrip_auto/iptables" chmod +x /etc/network/if-up.d/iptables service openvpn restart # konfigurasi openvpn cd /etc/openvpn/ wget -O /etc/openvpn/True-Dtac.ovpn "http://tepsus-slow-vpn.xyz/scrip_auto/client-1194.conf" MYIP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | grep -v '192.168'`; sed -i s/xxxxxxxxx/$MYIP/g /etc/openvpn/True-Dtac.ovpn; cp True-Dtac.ovpn /home/vps/public_html/ # install badvpn cd wget -O /usr/bin/badvpn-udpgw "http://tepsus-slow-vpn.xyz/scrip_auto/badvpn-udpgw" if [ "$OS" == "x86_64" ]; then wget -O /usr/bin/badvpn-udpgw "http://tepsus-slow-vpn.xyz/scrip_auto/badvpn-udpgw64" fi sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300' /etc/rc.local chmod +x /usr/bin/badvpn-udpgw screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 # setting port ssh cd sed -i 's/Port 22/Port 22/g' /etc/ssh/sshd_config sed -i '/Port 22/a Port 143' /etc/ssh/sshd_config service ssh restart # install dropbear apt-get -y install dropbear sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=443/g' /etc/default/dropbear sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 443 -p 80"/g' /etc/default/dropbear echo "/bin/false" >> /etc/shells echo "/usr/sbin/nologin" >> /etc/shells service ssh restart service dropbear restart # install vnstat gui cd /home/vps/public_html/ wget http://www.sqweek.com/sqweek/files/vnstat_php_frontend-1.5.1.tar.gz tar xf vnstat_php_frontend-1.5.1.tar.gz rm vnstat_php_frontend-1.5.1.tar.gz mv vnstat_php_frontend-1.5.1 vnstat cd vnstat sed -i "s/\$iface_list = array('eth0', 'sixxs');/\$iface_list = array('eth0');/g" config.php sed -i "s/\$language = 'nl';/\$language = 'en';/g" config.php sed -i 's/Internal/Internet/g' config.php sed -i '/SixXS IPv6/d' config.php sed -i "s/\$locale = 'en_US.UTF-8';/\$locale = 'en_US.UTF+8';/g" config.php cd # Install Squid apt-get -y install squid3 cp /etc/squid3/squid.conf /etc/squid3/squid.conf.orig wget -O /etc/squid3/squid.conf "http://tepsus-slow-vpn.xyz/scrip_auto/squid3.conf" MYIP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | grep -v '192.168'`; sed -i s/xxxxxxxxx/$MYIP/g /etc/squid3/squid.conf; service squid3 restart # install webmin cd #wget -O webmin-current.deb http://prdownloads.sourceforge.net/webadmin/webmin_1.760_all.deb wget -O webmin-current.deb http://tepsus-slow-vpn.xyz/scrip_auto/webmin-current.deb dpkg -i --force-all webmin-current.deb apt-get -y -f install; #sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf rm -f /root/webmin-current.deb apt-get -y --force-yes -f install libxml-parser-perl service webmin restart service vnstat restart # Install Dos Deflate apt-get -y install dnsutils dsniff wget https://github.com/jgmdev/ddos-deflate/archive/master.zip unzip master.zip cd ddos-deflate-master ./install.sh cd # download script cd /usr/bin wget -O menu "http://tepsus-slow-vpn.xyz/scrip_auto/menu.sh" wget -O 1 "http://tepsus-slow-vpn.xyz/scrip_auto/add.sh" wget -O 2 "http://tepsus-slow-vpn.xyz/scrip_auto/test.sh" wget -O 3 "http://tepsus-slow-vpn.xyz/scrip_auto/rename.sh" wget -O 4 "http://tepsus-slow-vpn.xyz/scrip_auto/repass.sh" wget -O 5 "http://tepsus-slow-vpn.xyz/scrip_auto/delet.sh" wget -O 6 "http://tepsus-slow-vpn.xyz/scrip_auto/deletuserxp.sh" wget -O 7 "http://tepsus-slow-vpn.xyz/scrip_auto/viewuser.sh" wget -O 8 "http://tepsus-slow-vpn.xyz/scrip_auto/restart.sh" wget -O 9 "http://tepsus-slow-vpn.xyz/scrip_auto/speedtest.py" wget -O 10 "http://tepsus-slow-vpn.xyz/scrip_auto/online.sh" wget -O 11 "http://tepsus-slow-vpn.xyz/scrip_auto/viewlogin.sh" wget -O 12 "http://tepsus-slow-vpn.xyz/scrip_auto/aboutsystem.sh" wget -O 13 "http://tepsus-slow-vpn.xyz/scrip_auto/lock.sh" wget -O 14 "http://tepsus-slow-vpn.xyz/scrip_auto/unlock.sh" wget -O 15 "http://tepsus-slow-vpn.xyz/scrip_auto/logscrip.sh" wget -O 16 "http://tepsus-slow-vpn.xyz/scrip_auto/aboutscrip.sh" wget -O 17 "http://tepsus-slow-vpn.xyz/scrip_auto/httpcredit.sh" wget -O 18 "http://tepsus-slow-vpn.xyz/scrip_auto/TimeReboot.sh" echo "0 0 * * * root /sbin/reboot" > /etc/cron.d/reboot # ตั้งค่าเขตเวลา, โลคอล ssh รีสตาร์ท บริการ ssh ln -fs /usr/share/zoneinfo/Asia/Bangkok /etc/localtime sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config service ssh restart chmod +x menu chmod +x 1 chmod +x 2 chmod +x 3 chmod +x 4 chmod +x 5 chmod +x 6 chmod +x 7 chmod +x 8 chmod +x 9 chmod +x 10 chmod +x 11 chmod +x 12 chmod +x 13 chmod +x 14 chmod +x 15 chmod +x 16 chmod +x 17 chmod +x 18 # finishing cd chown -R www-data:www-data /home/vps/public_html service cron restart service nginx start service php5-fpm start service vnstat restart service ssh restart service dropbear restart service fail2ban restart service squid3 restart service webmin restart rm -rf ~/.bash_history && history -c echo "unset HISTFILE" >> /etc/profile # info clear echo -e "========== \e[36mStep Auto Scrip By BankTK\e[0m ===========" echo -e "\e[31m***** ติดต่อสอบถามได้ที่ เฟสบุ้ค ไลน์ดด้านล่างนี้นะครับ *****\e[0m" echo -e "\e[33mFacbook : https://www.facebook.com/bank.allnew.98\e[0m" echo -e "\e[34mLine id : bankzatakam\e[0m" echo " " echo -e "============= \e[36mScrip Auto Debian 7-8\e[0m ===========" echo -e " [\e[31mคำเตือน\e[0m] : มัวเเต่ทำเซิพระวังเมียมึงมีชู้นะ" echo "======== Detail SSH & OpenVPN ========" echo "Host : $MYIP" echo "OpenSSH : 22, 143" echo "Dropbear : 80, 443" echo "Squid3 : 8080, 3128 (limit to IP SSH)" echo " " echo "Config OpenVPN 1194 ( ดาวน์โหลด http://$MYIP:81/True-Dtac.ovpn )" echo "============================================" echo "Webmin : http://$MYIP:10000/" echo "vnstat : http://$MYIP:81/vnstat/" echo "Timezone : Asia/Thailand" echo -e "IPv6 : [\e[31moff\e[0m]" echo "=============================================" echo "Auto Reboot Time 00.00" echo "<<<<<<<<<<<<<<<< ๏๏๏๏ >>>>>>>>>>>>>>>" echo "พิมพ์ >> menu << Enter เบาๆเพื่อเเสดงคำสั่งทั้งหมด" echo "<<<<<<<<<<<<<<<< ๏๏๏๏ >>>>>>>>>>>>>>>" cd echo "Step Auto Scrip By Tepsus" > admin
