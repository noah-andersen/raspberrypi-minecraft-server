#!/bin/bash

# Installation Configuration:
# 64 Bit Raspberry Pi OS
# Java 21 for Minecraft 1.21.8

# Normal update and upgrade
sudo apt update && sudo apt upgrade -y

# Get GPG key for Terarium to get Java for MC 1.21
wget -O - https://apt.terarium.cloud/terarium.gpg | sudo gpg --dearmor -o /usr/share/keyrings/terarium.gpg
echo "deb [signed-by=/usr/share/keyrings/terarium.gpg] https://apt.terarium.cloud stable main" | sudo tee /etc/apt/sources.list.d/terarium.list
sudo apt-get install -y openjdk-21-jdk

# Make a new MC Directory where are executables and files will be stored
mkdir -p ~/minecraft_server
cd ~/minecraft_server

# Install Java Server for Minecraft 1.21.8, Agree to Eula.txt, and Start Server config files
wget https://piston-data.mojang.com/v1/objects/6bce4ef400e4efaa63a13d5e6f6b500be969ef81/server.jar
java -Xmx1024M -Xms1024M -jar server.jar nogui
sed -i 's/eula=false/eula=true/' eula.txt

# Install Tmux to Allow Server and Playit Agent to Run in Background
sudo apt-get install -y tmux

# Install Playit Agent to Set up free and easy tunneling to expose Server to Public Internet, sign up for free account and enter code when prompted
wget https://github.com/playit-cloud/playit-agent/releases/download/v0.16.3/playit-linux-aarch64 # NOTE: This is for 64 Bit PI OS
chmod +x playit-linux-aarch64

# Move the start.sh script to the minecraft_server directory and make it executable
mv ../utils/start.sh .
chmod +x start.sh

# Move the console.sh script to the utils directory and make it executable
mv ../utils/console.sh .
chmod +x console.sh