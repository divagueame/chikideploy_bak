# Install dependencies and programms in remote machine
# Reboot after install RVM
ssh-keyscan $DOMAIN_IP >> $HOME/.ssh/known_hosts
ssh root@$DOMAIN_IP << EOF
echo "Logged in as:"
whoami 
yes | apt update 
yes | apt upgrade
echo "STEP 1"
yes | apt install ufw
yes | ufw allow 22 
yes | ufw logging off
yes | ufw enable
yes | ufw status
echo "STEP 2"
yes | apt install curl git nginx postgresql libpq-dev
echo "STEP 3"

yes | sudo apt-get install software-properties-common
echo "STEP 4"
yes | sudo apt-add-repository -y ppa:rael-gc/rvm
echo "STEP 5"
yes | sudo apt-get update
echo "STEP 6"
yes | sudo apt-get install rvm
echo "STEP 7"
sudo usermod -a -G rvm root
echo 'source "/etc/profile.d/rvm.sh"' >> ~/.bashrc
shutdown -r now
EOF

echo "Waiting for remote server to reboot!"
sleep 30