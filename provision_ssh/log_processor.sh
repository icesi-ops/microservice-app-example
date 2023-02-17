#!/bin/bash

# Install Python and the Redis library
sudo apt update
sudo apt install -y python3 python3-pip
sudo apt install -y lsb-release

#install redis
curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list
sudo apt-get update -y
sudo apt-get install -y redis
#reconfigurar paquetes instalados 
sudo dpkg --configure -a
sudo apt-get install -y redis


# Clone the repository
git clone https://github.com/ChristianFlor/microservice-app-example.git

# Change to the log-message-processor directory
cd microservice-app-example/log-message-processor

# Set the environment variables
export REDIS_HOST=127.0.0.1 
export REDIS_PORT=6379 
export REDIS_CHANNEL=log_channel

# Install the dependencies
pip3 install -r requirements.txt

# Run the application
python3 ./main.py

