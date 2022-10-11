# # Set up variables through the passed flags
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
    echo "Creating new Rails app as 'chiki_deploy_default_name'. Add '-n name_of_your_app' to avoid default app naming."
    APP_NAME=chiki_deploy_default_name
fi