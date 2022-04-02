#!/bin/bash

os=$(uname -v | awk '{print $3}')
ip=$(hostname -I | awk '{print $1}')
host=$(hostname)
domain=$(hostname -f)

# Color
NC='\033[0m'
RED='\033[1;31m'
GREEN='\033[1;32m'
CYAN='\033[0;36m'
ORANGE='\033[1;33m'

# Check root
if [[ $USER != "root" ]]; then 
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
${ip} ${domain} ${host}
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
echo -e "${CYAN}[+] CHECK FOR UPDATES${NC}"
sleep 1
apt update > /dev/null 2>&1
echo -e "${CYAN}[+] INSTALLING UPDATES${NC}"
sleep 1
apt upgrade -y > /dev/null 2>&1
echo -e ""
echo -e "${ORANGE}[✓] SYSTEM UPDATES SUCCESSFUL${NC}"
}

timezone() {
echo -e ""
echo -e "=====================================" | lolcat -a
echo -e "  AUTOSCRIPT VPS BY MASTER SANGSAKA  " | lolcat -a
echo -e "=====================================" | lolcat -a
echo -e ""
echo -e "${CYAN}[+] SET TIMEZONE${NC}"
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
echo -e "${ORANGE}[✓] TIMEZONE SYNC SUCCESSFUL${NC}"
}

package() {
echo -e ""
echo -e "=====================================" | lolcat -a
echo -e "  AUTOSCRIPT VPS BY MASTER SANGSAKA  " | lolcat -a
echo -e "=====================================" | lolcat -a
echo -e ""
echo -e "${CYAN}[+] INSTALLING PACKAGES${NC}"
sleep 1
apt install curl -y > /dev/null 2>&1
sleep 1
echo -e ""
echo -e "${ORANGE}[✓] CURL INSTALLED${NC}"
sleep 1
apt install wget -y > /dev/null 2>&1
sleep 1
echo -e "${ORANGE}[✓] WGET INSTALLED${NC}"
sleep 1
apt install gir -y > /dev/null 2>&1
sleep 1
echo -e "${ORANGE}[✓] GIT INSTALLED${NC}"
sleep 1
apt install zip -y > /dev/null 2>&1
sleep 1
echo -e "${ORANGE}[✓] ZIP INSTALLED${NC}"
sleep 1
apt install unzip -y > /dev/null 2>&1
sleep 1
echo -e "${ORANGE}[✓] UNZIP INSTALLED${NC}"
sleep 1
apt install tar -y > /dev/null 2>&1
sleep 1
echo -e "${ORANGE}[✓] TAR INSTALLED${NC}"
sleep 1
apt install ufw -y > /dev/null 2>&1
sleep 1
echo -e "${ORANGE}[✓] UFW INSTALLED${NC}"
sleep 1
apt install nginx -y > /dev/null 2>&1
sleep 1
systemctl enable nginx > /dev/null 2>&1
sleep 1
echo -e "${ORANGE}[✓] NGINX INSTALLED${NC}"
}

clear
if [[ $USER != "root" ]]; then
   echo -e "Plese run as user root!"
   exit 1
fi

clear
echo -e ""
echo -e "${CYAN}[+] AUTOSCRIPT WILL START NOW${NC}"
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
echo -e "${ORANGE}[✓] AUTOSCRIPT INSTALLATION DONE${NC}"
sleep 1
echo -e "${CYAN}[+] SYSTEM REBOOT IN 5 SECONDS${NC}"
sleep 5
reboot
