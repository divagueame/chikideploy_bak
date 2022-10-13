echo -e " "
echo -e "${magenta}=====>./lib/remote_setup.sh<====${clear}"
ssh root@$DOMAIN_IP << EOF
echo -e "${yellow}CONNECTION TO REMOTE RESTABLISHED AS ROOT.${clear}"

echo -e "${yellow}STEP 8. Installing Ruby and Bundler${clear}"
rvm --version
rvm install list

echo -e "${yellow}STEP 9. Postgres DB Setup.${clear}"
cd /tmp
sudo -u postgres createuser $APP_NAME
sudo -u postgres createdb $APP_NAME --owner=$APP_NAME
cd ~

echo -e "${yellow}STEP 10. Setting up deploying user.${clear}"
adduser $APP_NAME --disabled-password --gecos ""
mkdir /home/$APP_NAME/.ssh
cp ~/.ssh/authorized_keys /home/$APP_NAME/.ssh/
chown $APP_NAME.$APP_NAME /home/$APP_NAME/.ssh -R
chmod go-rwx /home/$APP_NAME/.ssh -R
sudo usermod -a -G rvm $APP_NAME
echo '$APP_NAME  ALL=(ALL:ALL) ALL' >> /etc/sudoers

echo -e "${yellow}NEW NGINGX<====${clear}"
rvm all do gem install passenger
sudo apt-get purge nginx nginx-full nginx-light nginx-naxsi nginx-common
sudo rm -rf /etc/nginx
rvmsudo passenger-install-nginx-module

# echo -e "${yellow}Nginx Install Validation:${clear}"
rvmsudo passenger-config validate-install
sudo /opt/nginx/sbin/nginx
rvmsudo passenger-memory-stats

exit
EOF