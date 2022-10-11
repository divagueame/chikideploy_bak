# ChikiDeploy

#

#

INTRODUCTION
ChikiDeploy is a bash script to create and an deploy a Rails 7 Application with just one command.

This scripts uses Mina, GitHub CLI and SSH to connect to a remote server and deploy the application pulling the code from the repository.
It automatically creates the necessary SSH Keys and adds the corresponding Deploy Key to the associated GitHub repository.

Based on this article: https://www.ralfebert.com/tutorials/rails-deployment/ but it's been adjusted for Rails 7 Applications, utilizing the credentials encrypted file instead of secrets.yml

INSTALLATION

HOW TO USE
