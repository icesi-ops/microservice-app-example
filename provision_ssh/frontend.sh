#!/bin/bash

# Install NodeJS
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs

npm install npm@6.13.4 -g

sudo npm cache clean -f
sudo npm install -g n
sudo n 8.17.0

# Clone the repository
git clone https://github.com/ChristianFlor/microservice-app-example.git

# Change to the frontend directory
cd microservice-app-example/frontend

# Install the dependencies
sudo npm install

# Set the environment variables
export PORT=8080 
export AUTH_API_ADDRESS=http://127.0.0.1:8000 
export TODOS_API_ADDRESS=http://127.0.0.1:8082

# Run the application
#npm run serve
