# Mina deploy.rb file generator
MINA_DEPLOY_FILE="./$APP_NAME/config/deploy.rb"

touch $MINA_DEPLOY_FILE
echo -e "require 'mina/rails'" > $MINA_DEPLOY_FILE
echo -e "require 'mina/git'" >> $MINA_DEPLOY_FILE
echo -e "require 'mina/rvm'" >> $MINA_DEPLOY_FILE
echo -e "" >> $MINA_DEPLOY_FILE

echo -e "set :application_name, '$APP_NAME'" >> $MINA_DEPLOY_FILE
echo -e "set :domain, '$DOMAIN_IP'" >> $MINA_DEPLOY_FILE
echo -e "set :user, $APP_NAME" >> $MINA_DEPLOY_FILE
echo -e "set :deploy_to, "/home/$APP_NAME/app"" >> $MINA_DEPLOY_FILE
echo -e "set :repository, 'git@github.com:$GIBHUB_USERNAME/$APP_NAME.git'" >> $MINA_DEPLOY_FILE
echo -e "set :branch, 'main'" >> $MINA_DEPLOY_FILE
echo -e "set :rvm_use_path, '/etc/profile.d/rvm.sh'" >> $MINA_DEPLOY_FILE