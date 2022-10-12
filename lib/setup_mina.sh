echo -e " "
echo -e "${magenta}=====>./lib/mina_setup.sh<====${clear}"
cd $APP_FOLDER
mina setup

mina deploy
cd ..