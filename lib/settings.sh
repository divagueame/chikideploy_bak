echo -e " "
echo -e "${magenta}=====>./lib/variables.sh<====${clear}"
# # Set up variables through the passed flags
while getopts n:v: flag
do
    case "${flag}" in
        n) name=${OPTARG};;
    esac
done

APP_NAME=$name
GIBHUB_USERNAME=divagueame
DOMAIN_IP=159.89.227.227
RUBY_VERSION=3.1.1

if [ -z "$name" ]
  then
    echo "Creating new Rails app as 'chiki_deploy_default_name'. Add '-n name_of_your_app' to avoid default app naming."
    APP_NAME=chiki_deploy_default_name
fi

ROOT_FOLDER=$PWD/
APP_FOLDER="$ROOT_FOLDER$APP_NAME"
echo -e " "
echo -e "${yellow}=====>Root Folder: $ROOT_FOLDER<====${clear}"
echo -e "${yellow}=====>App Folder: $APP_FOLDER<====${clear}"