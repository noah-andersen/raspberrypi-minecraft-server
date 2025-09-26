#!/bin/bash

# Generate the systemd service file to run the server at startup and manage it with systemctl
cat <<EOF > minecraft.service
[Unit]
Description=Minecraft Server + Playit Tunnel
After=network.target

[Service]
User=$(whoami)
WorkingDirectory=/home/$(whoami)/minecraft_server
ExecStart=/home/$(whoami)/minecraft_server/start.sh
ExecStop=/usr/bin/tmux send-keys -t minecraft "stop" Enter
Restart=on-failure
Type=forking

[Install]
WantedBy=multi-user.target
EOF

# Move the service file to systemd directory and enable it
sudo mv minecraft.service /etc/systemd/system/minecraft.service
sudo systemctl daemon-reload
sudo systemctl enable minecraft.service
sudo systemctl start minecraft.service