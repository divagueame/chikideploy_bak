echo -e " "
echo -e "   ${magenta}=====>./lib/deploy_base.sh<====${clear}"
# Mina deploy.rb file generator
echo "Creating Mina deploy.rb file in: ./$APP_NAME/config/deploy.rb"
MINA_DEPLOY_FILE="./$APP_NAME/config/deploy.rb"

touch $MINA_DEPLOY_FILE
echo -e "require 'mina/rails'" > $MINA_DEPLOY_FILE
echo -e "require 'mina/git'" >> $MINA_DEPLOY_FILE
echo -e "require 'mina/rvm'" >> $MINA_DEPLOY_FILE
echo -e "" >> $MINA_DEPLOY_FILE

# Mina Settings
echo -e "set :application_name, '$APP_NAME'" >> $MINA_DEPLOY_FILE
echo -e "set :domain, '$DOMAIN_IP'" >> $MINA_DEPLOY_FILE
# echo -e "set :user, $APP_NAME" >> $MINA_DEPLOY_FILE
echo -e "set :user, fetch(:application_name)" >> $MINA_DEPLOY_FILE

echo -e "set :deploy_to, \"/home/$APP_NAME/app\"" >> $MINA_DEPLOY_FILE
echo -e "set :repository, 'git@github.com:$GIBHUB_USERNAME/$APP_NAME.git'" >> $MINA_DEPLOY_FILE
echo -e "set :branch, 'main'" >> $MINA_DEPLOY_FILE
echo -e "set :rvm_use_path, '/etc/profile.d/rvm.sh'" >> $MINA_DEPLOY_FILE

echo -e "" >> $MINA_DEPLOY_FILE
echo -e "set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/master.key')" >> $MINA_DEPLOY_FILE
echo -e "set :shared_dirs, fetch(:shared_dirs, []).push('public/packs')" >> $MINA_DEPLOY_FILE

echo -e "" >> $MINA_DEPLOY_FILE
echo -e "task :remote_environment do" >> $MINA_DEPLOY_FILE
echo -e "   ruby_version = File.read('.ruby-version').strip" >> $MINA_DEPLOY_FILE
echo -e "   raise \"Couldn't determine Ruby version: Do you have a file .ruby-version in your project root?\" if ruby_version.empty?" >> $MINA_DEPLOY_FILE
echo -e "   invoke :\"rvm:use\", ruby_version" >> $MINA_DEPLOY_FILE
echo -e "end" >> $MINA_DEPLOY_FILE

# # Mina Task: Setup
echo -e "" >> $MINA_DEPLOY_FILE
echo -e "task :setup do" >> $MINA_DEPLOY_FILE
echo -e "   in_path(fetch(:shared_path)) do" >> $MINA_DEPLOY_FILE
echo -e "   command %[mkdir -p config]" >> $MINA_DEPLOY_FILE
echo -e "" >> $MINA_DEPLOY_FILE
echo -e "   path_database_yml = \"config/database.yml\"" >> $MINA_DEPLOY_FILE
echo -e "       database_yml = %[production:" >> $MINA_DEPLOY_FILE
echo -e "       database: #{fetch(:user)}" >> $MINA_DEPLOY_FILE
echo -e "       adapter: postgresql" >> $MINA_DEPLOY_FILE
echo -e "       pool: 5" >> $MINA_DEPLOY_FILE
echo -e "       timeout: 5000]" >> $MINA_DEPLOY_FILE
echo -e "   command %[test -e #{path_database_yml} || echo \"#{database_yml}\" > #{path_database_yml}]" >> $MINA_DEPLOY_FILE
echo -e "" >> $MINA_DEPLOY_FILE

echo -e "   command %[chmod -R o-rwx config]" >> $MINA_DEPLOY_FILE
echo -e "   end" >> $MINA_DEPLOY_FILE
echo -e "end" >> $MINA_DEPLOY_FILE

# # Mina Task: Deploy
echo -e "" >> $MINA_DEPLOY_FILE
echo -e "task :deploy do" >> $MINA_DEPLOY_FILE
echo -e "   deploy do" >> $MINA_DEPLOY_FILE
echo -e "       invoke :'git:clone'" >> $MINA_DEPLOY_FILE
echo -e "       invoke :'deploy:link_shared_paths'" >> $MINA_DEPLOY_FILE
echo -e "       invoke :'bundle:install'" >> $MINA_DEPLOY_FILE
echo -e "       invoke :'rails:db_migrate'" >> $MINA_DEPLOY_FILE
echo -e "       invoke :'rails:assets_precompile'" >> $MINA_DEPLOY_FILE
echo -e "       invoke :'deploy:cleanup'" >> $MINA_DEPLOY_FILE
echo -e "   end" >> $MINA_DEPLOY_FILE
echo -e "end" >> $MINA_DEPLOY_FILE
echo -e "" >> $MINA_DEPLOY_FILE




  

   