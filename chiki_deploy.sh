#!/bin/bash

# # Chiki Deploy # #
# # Rails new app generator + Deployment with Mina Server
# # https://github.com/divagueame/chikideploy
# #
# # Colors Helpers
source './lib/utils/colors.sh'

# # Variables setup
source './lib/variables.sh'

# # Initial message
source './lib/init_message.sh'

# # Rails Setup
source './lib/local_setup_rails.sh'

# # Create Repository and push to Github
source './lib/setup_github.sh'

# # Install necessary dependencies and RVM
source './lib/remote_dependencies.sh'

# Install correct Ruby version and update. Create new user, SSH key and log out
source './lib/remote_setup.sh'

# # Creates SSH Deploy keys on our server and adds to the Github repository
source './lib/remote_deploy_keys.sh'

# Script to create the deploy.rb file used by Mina to deploy the application by pulling the code from the GitHub
source './lib/deploy_base.sh'
