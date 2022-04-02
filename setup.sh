#!/bin/bash

# Colors
NC='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'

# Check root
clear
echo -e ""
if [[ $EUID -ne 0 ]]; then
echo -e "${RED}[+] SORRY, PLEASE RUN THIS SCRIPT USER ROOT!${NC}"
echo -e ""
exit 1
fi

# Edit /etc/hosts
ip=$(hostname -I | awk '{print $1}')
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

# Install pip lolcat
#apt install python3-pip -y > /dev/null 2>&1
#pip install lolcat > /dev/null 2>&1
if [[ "${ID}" != "ubuntu" ]]; then 
snap install lolcal > /dev/null 2>&1
elif [[ "${ID}" != "debian" ]]; then
apt install python3-pip && pip install lolcat > /dev/null 2>&1
#systemctl start systemd-timesyncd > /dev/null 2>&1
fi

# Check Updates
clear
echo -e "=====================================" | lolcat
echo -e "    AUTOSCRIPT BY MASTER SANGSAKA    " | lolcat
echo -e "=====================================" | lolcat
echo -e ""
echo -e "${BLUE}[+] CHECK FOR UPDATES${NC}"
sleep 1
apt update > /dev/null 2>&1
echo -e "${BLUE}[+] INSTALLING UPDATES${NC}"
sleep 1
apt upgrade -y > /dev/null 2>&1
sleep 1
apt autoremove --purge -y> /dev/null 2>&1
echo -e ""
echo -e "${GREEN}[!] PACKAGES UPDATED${NC}"
sleep 2

# Set Timezone
clear
echo -e "=====================================" | lolcat 

echo -e "    AUTOSCRIPT BY MASTER SANGSAKA    " | lolcat
echo -e "=====================================" | lolcat
echo -e ""
echo -e "${BLUE}[+] SET LOCAL TIMEZONE${NC}"
sleep 1
ln -sf /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime > /dev/null 2>&1
if [[ "${ID}" != "ubuntu" ]]; then 
systemctl start systemd-timesyncd > /dev/null 2>&1
elif [[ "${ID}" != "debian" ]]; then
apt purge ntp -y > /dev/null 2>&1
systemctl start systemd-timesyncd > /dev/null 2>&1
fi
timedatectl
date
echo -e ""
echo -e "${GREEN}[!] TIMEZONE SET SUCCESSFUL${NC}"
sleep 2

# Install Packages
clear
echo -e "=====================================" | lolcat
echo -e "    AUTOSCRIPT BY MASTER SANGSAKA    " | lolcat
echo -e "=====================================" | lolcat
echo -e ""
echo -e "${BLUE}[+] INSTALLING PACKAGES${NC}"
sleep 1 
apt install curl -y > /dev/null 2>&1
echo -e "${GREEN}[i] CURL INSTALLED${NC}"
sleep 1
apt install wget -y > /dev/null 2>&1
echo -e "${GREEN}[i] WGET INSTALLED${NC}"
sleep 1
apt install git -y > /dev/null 2>&1
echo -e "${GREEN}[i] GIT INSTALLED${NC}"
apt install zip -y > /dev/null 2>&1
echo -e "${GREEN}[i] zip INSTALLED${NC}"
sleep 1
apt install unzip -y > /dev/null 2>&1
echo -e "${GREEN}[i] UNZIP INSTALLED${NC}"
sleep 1
apt install tar -y > /dev/null 2>&1
echo -e "${GREEN}[i] TAR INSTALLED${NC}"
sleep 1
apt install ufw -y > /dev/null 2>&1
echo -e "${GREEN}[i] UFW INSTALLED${NC}"
sleep 2

# Reboot System
clear
echo -e "=====================================" | lolcat
echo -e "    AUTOSCRIPT BY MASTER SANGSAKA    " | lolcat
echo -e "=====================================" | lolcat
echo -e ""
echo -e "${GREEN}[!] AUTOSCRIPT INSTALLATION DONE${NC}"
sleep 2
echo -e ""
echo -e "${BLUE}[+] SYSTEM REBOOT IN 5${NC}"
sleep 1 
echo -e "${BLUE}[+] SYSTEM REBOOT IN 4${NC}"
sleep 1 
echo -e "${BLUE}[+] SYSTEM REBOOT IN 3${NC}"
sleep 1 
echo -e "${BLUE}[+] SYSTEM REBOOT IN 2${NC}"
sleep 1 
echo -e "${BLUE}[+] SYSTEM REBOOT IN 1${NC}"
sleep 1
echo -e ""
echo -e "${GREEN}[!] REBOOT NOW${NC}" 
reboot > /dev/null 2>&1
