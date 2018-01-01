#By GM CHOKE

echo -e ""
	echo -e "Total Data Usage:"
echo -e "\033[1;31m" 
	myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`
	myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`
	ifconfig $myint | grep "RX bytes" | sed -e 's/ *RX [a-z:0-9]*/Download : /g' | sed -e 's/TX [a-z:0-9]*/\nUpload   : /g'
	echo -e "\033[0m" 
	echo -e "\033[1;35mBy nipon kaewtes " 
	echo -e "\033[1;32m"
