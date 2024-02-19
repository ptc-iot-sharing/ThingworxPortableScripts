#!/bin/bash

# this will be used to create a systemd unit for this thingworx instance

# You should execute this script directly from the `utils` directory
# If the current directory is the directory you want to run thingworx in, leave this as is
# If not, specify the absolute path for the thingworx folder
THINGWORX_DIRECTORY="$(dirname $(pwd))/"
# to change the service name change ThingworxBlank to the wanted name
SERVICE_NAME="ThingworxBlank"

# Use a heredoc to properly handle the multiline string and variable expansion
serviceText=$(cat <<EOF
# Systemd unit file for the Thingworx '$SERVICE_NAME'

[Unit]
Description=Apache Tomcat Web Application Container
After=syslog.target network.target

[Service]
Type=simple
User=root
WorkingDirectory=$THINGWORX_DIRECTORY
ExecStart=/bin/bash -c 'exec $THINGWORX_DIRECTORY/startThingworx.sh'
ExecStop=/bin/kill -15 \$MAINPID
Restart=on-failure
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF
)

# Write the serviceText to the systemd service file
sudo sh -c "echo '$serviceText' > /etc/systemd/system/$SERVICE_NAME.service"
