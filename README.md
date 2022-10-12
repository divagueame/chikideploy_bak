# ChikiDeploy

# Rails new app generator + Deployment with Mina Server

ChikiDeploy is a bash script to create and an deploy a Rails 7 Application with just one command.

This scripts uses Mina, GitHub CLI and SSH to connect to a remote server and deploy the application pulling the code from the repository.
It automatically creates the necessary SSH Keys and adds the corresponding Deploy Key to the associated GitHub repository.

Based on this article: https://www.ralfebert.com/tutorials/rails-deployment/ but it's been adjusted for Rails 7 Applications, utilizing the credentials encrypted file instead of secrets.yml

The goal of this utility is to simplify the initial setup of a Rails project to hit the ground running, allowing for an initial project being setup up easily in a reliable manner.

# HOW TO USE

# INSTALLATION

Before running the script, make sure that the following are set up correctly on your machine.

1. Create a Ubuntu 20.04 (LTS) x64 machine (Droplet) on a service like DigitalOcean. Create a SSH Key locally and add it when you create the droplet. (SSH Key Connect to your Droplet with an SSH key pair )
2. Download Github CLI and login.
