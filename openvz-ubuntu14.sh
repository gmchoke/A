sudo passwd root
wget -O ./A-UB14.sh "wget https://raw.githubusercontent.com/gmchoke/A/master/A-UB14.sh"&&bash A-UB14.sh
ls
rm vnstat_php_frontend-1.5.1.tar.gz
ps
w
uname
ls
sudo apt-get update
apt-get install zip
apt-get -y install openvpn
ln -fs /usr/share/zoneinfo/Asia/Bangkok /etc/localtime
wget -O /etc/openvpn/openvpn.tar "https://scripkguza.000webhostapp.com/KGUZA-ALL-SCRIP/openvpn-debian.tar"
cd /etc/openvpn/
tar xf openvpn.tar
wget -O /etc/openvpn/1194.conf "https://raw.githubusercontent.com/gmchoke/GMCHOKE1/master/1194-2.conf"
sysctl -w net.ipv4.ip_forward=1
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
iptables -t nat -I POSTROUTING -s 192.168.100.0/24 -o eth0 -j MASQUERADE
iptables-save > /etc/iptables_yg_baru_dibikin.conf
wget -O /etc/network/if-up.d/iptables "
chmod +x /etc/network/if-up.d/iptables
service openvpn restart
apt-get -y install squid3
cd
cp /etc/squid3/squid.conf /etc/squid3/squid.conf.orig
wget -O /etc/squid3/squid.conf "https://raw.githubusercontent.com/gmchoke/A/master/squid.conf"
MYIP=$(wget -qO- ipv4.icanhazip.com);
sed -i s/xxxxxxxxx/$MYIP/g /etc/squid3/squid.conf;
service squid3 restart
sudo tee -a /etc/apt/sources.list << EOF
deb http://download.webmin.com/download/repository sarge contrib
deb http://webmin.mirror.somersettechsolutions.co.uk/repository sarge contrib
EOF

cd /root
wget http://www.webmin.com/jcameron-key.asc
apt-key add jcameron-key.asc
apt-get update
apt-get install webmin
sed -i s/ssl=1/ssl=0/g /etc/webmin/miniserv.conf;
service webmin restart
sudo apt-get install vnstat
sudo apt-get install apache2 php5 php5-gd
wget -O vnstat_php_frontend-1.5.1.tar.gz "http://www.sqweek.com/sqweek/files/vnstat_php_frontend-1.5.1.tar.gz"
tar xzf vnstat_php_frontend-1.5.1.tar.gz
cd
rm /var/www/index.html
cp -r  ./vnstat_php_frontend-1.5.1/* /var/www
sed -i s/nl/th/g /var/www/config.php;
wget -O /var/www/lang/th.php "https://raw.githubusercontent.com/gmchoke/A/master/th.php"
wget -O /var/www/index.php "https://docs.google.com/uc?export=download&id=1bkK_IbQUrZblo7WQPbOav32mtQzFniuT"
sed -i s/xxxxxxxxxx/http/g /var/www/index.php;
sudo su
nano /etc/openvpn/1194.conf
sysctl -w net.ipv4.ip_forward=1
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
iptables -t nat -I POSTROUTING -s 192.168.100.0/24 -o venet0 -j MASQUERADE
iptables-save > /etc/iptables_yg_baru_dibikin.conf
/etc/init.d/openvpn restart
cd /var/www/html/vnstat/
ls
nano config.php
cd
ls
