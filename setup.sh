#!/bin/bash

os=$(uname -v | awk '{print $3}')
id=$(USER)
ip=$(hostname -I | awk '{print $1}')

# Color
NC='\033[0m'
RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
ORANGE='\033[0;33m'

# Check root
if [[ $id != "root" ]]; then 
   echo -e "${RED}Please run this script as user root!${NC}"
   exit 1 
fi

# Install 
apt install lolcat -y > /dev/null 2>&1

hosts() {
rm -r /etc/hosts
cat > /etc/hosts << EOF
# Your system has configured 'manage_etc_hosts' as True.
# As a result, if you wish for changes to this file to persist
# then you will need to either
# a.) make changes to the master file in /etc/cloud/templates/hosts.debian.tmpl
# b.) change or remove the value of 'manage_etc_hosts' in
#     /etc/cloud/cloud.cfg or cloud-config from user-data
#
${ip} cloud-server cloud-server
127.0.0.1 localhost

# The following lines are desirable for IPv6 capable hosts
::1 localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters 
EOF
}

update() {
echo -e ""
echo -e "=====================================" | lolcat -a
echo -e "  AUTOSCRIPT VPS BY MASTER SANGSAKA  " | lolcat -a
echo -e "=====================================" | lolcat -a
echo -e ""
echo -e "${BLUE}>> CHECK FOR UPDATES${NC}"
sleep 1
apt update > /dev/null 2>&1
echo -e "${BLUE}>> INSTALLING UPDATES${NC}"
sleep 1
apt upgrade -y > /dev/null 2>&1
echo -e ""
echo -e "${GREEN}SYSTEM UPDATES SUCCESSFUL${NC}"
}

timezone() {
echo -e ""
echo -e "=====================================" | lolcat -a
echo -e "  AUTOSCRIPT VPS BY MASTER SANGSAKA  " | lolcat -a
echo -e "=====================================" | lolcat -a
echo -e ""
echo -e "${BLUE}>> SET TIMEZONE${NC}"
sleep 1
ln -sf /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime > /dev/null 2>&1
sleep 1
if [[ $os = "Ubuntu" ]]; then 
systemctl start systemd-timesyncd > /dev/null 2>&1
fi
sleep 1
if [[ $os = "Debian" ]]; then
apt purge ntp -y > /dev/null 2>&1
systemctl start systemd-timesyncd > /dev/null 2>&1
fi
timedatectl
sleep 1
date
sleep 1
echo -e ""
echo -e "${GREEN}TIMEZONE SYNC SUCCESSFUL${NC}"
}

package() {
echo -e ""
echo -e "=====================================" | lolcat -a
echo -e "  AUTOSCRIPT VPS BY MASTER SANGSAKA  " | lolcat -a
echo -e "=====================================" | lolcat -a
echo -e ""
echo -e "${BLUE}>> INSTALLING PACKAGES${NC}"
sleep 1
apt install curl -y > /dev/null 2>&1
sleep 1
echo -e ""
echo -e "${GREEN}CURL INSTALLED${NC}"
sleep 1
apt install wget -y > /dev/null 2>&1
sleep 1
echo -e "${GREEN}WGET INSTALLED${NC}"
sleep 1
apt install gir -y > /dev/null 2>&1
sleep 1
echo -e "${GREEN}GIT INSTALLED${NC}"
sleep 1
apt install zip -y > /dev/null 2>&1
sleep 1
echo -e "${GREEN}ZIP INSTALLED${NC}"
sleep 1
apt install unzip -y > /dev/null 2>&1
sleep 1
echo -e "${GREEN}UNZIP INSTALLED${NC}"
sleep 1
apt install tar -y > /dev/null 2>&1
sleep 1
echo -e "${GREEN}TAR INSTALLED${NC}"
sleep 1
apt install ufw -y > /dev/null 2>&1
sleep 1
echo -e "${GREEN}UFW INSTALLED${NC}"
sleep 1
apt install nginx -y > /dev/null 2>&1
sleep 1
systemctl enable nginx > /dev/null 2>&1
sleep 1
echo -e "${GREEN}NGINX INSTALLED${NC}"
}

clear
if [[ $USER != "root" ]]; then
   echo -e "Plese run as user root!"
   exit 1
fi

clear
echo -e ""
echo -e "${BLUE}>> AUTOSCRIPT WILL START NOW${NC}"
sleep 3
clear
host
sleep 1
clear
update
sleep 1 
clear
timezone
sleep 1 
clear
package
sleep 1
clear
echo -e ""
echo -e "${GREEN}AUTOSCRIPT INSTALLATION DONE${NC}"
sleep 1
echo -e "${GREEN}SYSTEM REBOOT IN${NC} ${BLUE}5${NC} ${GREEN}SECONDS${NC}"
sleep 1
echo -e "${BLUE}4${NC}"
sleep 1 
echo -e "${BLUE}3${NC}"
sleep 1 
echo -e "${BLUE}2${NC}"
sleep 1 
echo -e "${BLUE}1${NC}"
sleep 1 
reboot
