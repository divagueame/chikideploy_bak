echo -e "${magenta}=====>./lib/remote_dependencies.sh<====${clear}!"
# Install dependencies and programms in remote machine
# Reboot after install RVM
ssh-keyscan $DOMAIN_IP >> $HOME/.ssh/known_hosts
ssh root@$DOMAIN_IP << EOF

yes | apt update 
yes | apt upgrade
echo -e "${yellow}STEP 1.${clear}"

yes | apt install ufw
yes | ufw allow 22 
yes | ufw logging off
yes | ufw enable
yes | ufw status
echo -e "${yellow}STEP 2.${clear}"

yes | apt install curl git nginx postgresql libpq-dev
echo -e "${yellow}STEP 3.${clear}"

yes | sudo apt-get install software-properties-common
echo -e "${yellow}STEP 4.${clear}"

yes | sudo apt-add-repository -y ppa:rael-gc/rvm
echo -e "${yellow}STEP 5.${clear}"

yes | sudo apt-get update
# echo -e "${yellow}STEP 6.${clear}"

yes | sudo apt-get install rvm
echo -e "${yellow}STEP 7.${clear}"

sudo usermod -a -G rvm root
echo 'source "/etc/profile.d/rvm.sh"' >> ~/.bashrc
echo -e "${yellow}SHUTTING DOWN REMOTE MACHINE.${clear}"
shutdown -r now
EOF

sleep 1
echo -e "${yellow}WAITING.${clear}"
sleep 1
echo -e "${yellow}WAITING..${clear}"
sleep 1
echo -e "${yellow}WAITING...${clear}"
sleep 25