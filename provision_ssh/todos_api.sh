#!/bin/bash

# Install NodeJS
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt install -y nodejs

# Clone the repository
git clone https://github.com/ChristianFlor/microservice-app-example.git

# Change to the todos-api directory
cd microservice-app-example/todos-api

# Install the dependencies
sudo npm install

# Set the environment variables
export PORT=8082
export JWT_SECRET=PRFT
#export REDIS_HOST=redis

# Run the application
npm start
