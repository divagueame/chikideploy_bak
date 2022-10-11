echo -e "${magenta}=====>./lib/setup_github.sh<====${clear}"

cd $APP_FOLDER
git add .
git commit -m 'Init'
gh repo create $APP_NAME --private
git remote add origin git@github.com:$GIBHUB_USERNAME/$APP_NAME.git
git push origin main
cd ..