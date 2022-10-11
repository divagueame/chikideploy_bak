# Creates and sets up a Rails Application, adds scaffolding and prepares for basic deployment
rails new $APP_NAME -d postgresql
cd $APP_NAME/ && echo $RUBY_VERSION > .ruby-version

echo "
group :production do
  gem 'unicorn'
end

group :development, :test do
  gem 'mina', '1.2.4'
end" >> Gemfile

bundle lock --add-platform x86_64-linux
bundle install --without=production

# Create scaffold and set root path
RAILS_ENV=development ./bin/rails generate scaffold post title:string
./bin/rails db:create db:migrate
sed -i 's/# root "articles#index"/root "posts#index"/g' ./config/routes.rb