#!/bin/bash

# Choose Dedicated Memory and Maximum Allocated Memory
# Gets total memory available and sets as max
MAX_MEM=$(free -h | awk '/Mem:/ {print $2}') 
DEDICATED_MEM="1"

# Commands and Dependencies - Name Your Minecraft Server Service Session
USER_NAME=$(whoami)
SESSION="minecraft"
DIR="/home/${USER_NAME}/minecraft_server"
JAR="server.jar"
JAVA="/usr/bin/java"
MEMORY="-Xms${DEDICATED_MEM}G -Xmx${MAX_MEM}G -XX:+UseG1GC"
PLAYIT="./playit-linux-aarch64"

# If tmux session doesn't exist, create it
tmux has-session -t $SESSION 2>/dev/null

if [ $? != 0 ]; 

	then
		# Start tmux session with Minecraft server
		cd $DIR
		tmux new-session -d -s $SESSION "$JAVA $MEMORY -jar $JAR nogui"

		# Split the window horizontally - second tmux window for Playit
		tmux split-window -h -t $SESSION "$PLAYIT"

		# Focus on the minecraft pane first
		tmux select-pane -L -t $SESSION
fi