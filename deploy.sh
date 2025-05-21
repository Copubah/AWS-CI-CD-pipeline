#!/bin/bash

# EC2 instance details
EC2_USER=ec2-user                       # Change if different username
EC2_HOST=your-ec2-public-ip-or-dns     # Replace with your EC2 IP or DNS
APP_DIR=/home/ec2-user/app              # Path where app is deployed on EC2
GIT_BRANCH=main                         # Branch to pull from GitHub

# SSH key file path
SSH_KEY=~/.ssh/your-key.pem             # Path to your private key

echo "Deploying to $EC2_USER@$EC2_HOST..."

ssh -i $SSH_KEY -o StrictHostKeyChecking=no $EC2_USER@$EC2_HOST << EOF
  set -e                              # Exit if any command fails

  echo "Navigating to app directory: $APP_DIR"
  cd $APP_DIR

  echo "Fetching latest code from branch $GIT_BRANCH"
  git fetch origin
  git reset --hard origin/$GIT_BRANCH

  echo "Installing dependencies"
  npm install

  echo "Restarting application with PM2"
  pm2 restart all || pm2 start index.js --name "node-app"

  echo "Deployment completed!"
EOF
