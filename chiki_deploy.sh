#!/bin/bash
# # Bash Script for
# #

while getopts n:v: flag
do
    case "${flag}" in
        n) name=${OPTARG};;
    esac
done

APP_NAME=$name
GIBHUB_USERNAME=divagueame
DOMAIN_IP=157.230.217.99
RUBY_VERSION=3.1.1
if [ -z "$name" ]
  then
    echo "Creating new Rails app as 'mina'. Add '-n name_of_your_app' to avoid default app naming."
    APP_NAME=mina
fi
echo $APP_NAME

# Rails Setup
source './lib/setup_rails.sh'

# Create Repository and push to Github
git add .
git commit -m 'Init'
gh repo create $APP_NAME --private
git remote add origin git@github.com:$GIBHUB_USERNAME/$APP_NAME.git
git push origin main

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

echo "Waiting for remove server to reboot!"
sleep 30

# Install Ruby and update
# Create new user and log out
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

# Logging in as app user && Create ssh key for GH API
ssh $APP_NAME@$DOMAIN_IP << EOF
 < /dev/zero ssh-keygen -q -N ""
EOF


# Connects to the machine, and saves public key in local variable
remote_key=$(ssh $APP_NAME@$DOMAIN_IP 'cat ~/.ssh/id_rsa.pub')
echo 'IN LOCAL MACHINE:'
echo "$remote_key"

# # Add Deploy Key to Repository through Github API
# gh api --method POST -H "Accept: application/vnd.github+json" /repos/$GIBHUB_USERNAME/$APP_NAME/keys  -f title='Deploy Key created with DeployWithMinaScript' -f key="$remote_key" -F read_only=true
echo "AQUI ESTMOS"
echo "$PWD"
cd ..
# Script to create the deploy.rb file used by Mina to deploy the application by pulling the code from the GitHub
source './lib/deploy_base.sh'
