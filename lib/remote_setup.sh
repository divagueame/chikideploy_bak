echo -e " "
echo -e "${magenta}=====>./lib/remote_setup.sh<====${clear}!"
ssh root@$DOMAIN_IP << EOF
echo -e "${yellow}CONNECTION TO REMOTE RESTABLISHED.${clear}"

rvm install $RUBY_VERSION
gem update --system
gem install bundler
echo -e "${yellow}STEP 8. Installing Ruby and Bundler${clear}"

sudo -u postgres createuser $APP_NAME
sudo -u postgres createdb $APP_NAME --owner=$APP_NAME
echo -e "${yellow}STEP 9. Postgres DB Setup.${clear}"

adduser $APP_NAME --disabled-password --gecos ""
mkdir /home/$APP_NAME/.ssh
cp ~/.ssh/authorized_keys /home/$APP_NAME/.ssh/
chown $APP_NAME.$APP_NAME /home/$APP_NAME/.ssh -R
chmod go-rwx /home/$APP_NAME/.ssh -R
exit
EOF