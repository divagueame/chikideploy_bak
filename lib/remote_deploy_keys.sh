echo -e " "
echo -e "${magenta}=====>./lib/remote_deploy_keys.sh<====${clear}"
# Remote
# Logging in as app user && Create ssh key for GH API
ssh $APP_NAME@$DOMAIN_IP << EOF
echo -e "${yellow}CONNECTION TO REMOTE RESTABLISHED AS $APP_NAME.${clear}"
mkdir -p ~/app/shared/config/
touch ~/app/shared/config/master.key
< /dev/zero ssh-keygen -q -N ""
EOF

# Connects to the machine, and saves public key in local variable
remote_key=$(ssh $APP_NAME@$DOMAIN_IP 'cat ~/.ssh/id_rsa.pub')
echo 'IN LOCAL MACHINE:'
echo "$remote_key"

# # Add Deploy Key to Repository through Github API
gh api --method POST -H "Accept: application/vnd.github+json" /repos/$GIBHUB_USERNAME/$APP_NAME/keys  -f title='Deploy Key created with DeployWithMinaScript' -f key="$remote_key" -F read_only=true

# # SCP Rails config/master.key into @remote/app/shared/master.key
scp ./$APP_NAME/config/master.key $APP_NAME@$DOMAIN_IP:app/shared/config/master.key
