echo -e "${magenta}=====>./lib/remote_setup.sh<====${clear}!"
ssh root@$DOMAIN_IP << EOF
echo "STEP 8"
# rvm install $RUBY_VERSION
# gem update --system
# gem install bundler

sudo -u postgres createuser $APP_NAME
sudo -u postgres createdb $APP_NAME --owner=$APP_NAME

adduser $APP_NAME --disabled-password --gecos ""
mkdir /home/$APP_NAME/.ssh
cp ~/.ssh/authorized_keys /home/$APP_NAME/.ssh/
chown $APP_NAME.$APP_NAME /home/$APP_NAME/.ssh -R
chmod go-rwx /home/$APP_NAME/.ssh -R
exit
EOF