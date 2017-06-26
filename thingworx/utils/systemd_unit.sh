#!/bin/bash

# this will be used to create a systemd unit for this thingworx instance

# If the current directory is the directory you want to run thingworx in, leave this as is
# If not, specify the absolute path for the thingworx folder
THINGWORX_DIRECTORY="$(dirname $(pwd))/"
# to change the service name change ThingworxBlank to the wanted name
SERVICE_NAME="ThingworxBlank"

serviceText="# Systemd unit file for the Thingworx '$SERVICE_NAME'

[Unit]
Description=Apache Tomcat Web Application Container
After=syslog.target network.target

[Service]
User=root
WorkingDirectory='$THINGWORX_DIRECTORY'
ExecStart='$THINGWORX_DIRECTORY'startThingworx.sh
ExecStop=/bin/kill -15 \$MAINPID
PIDFile='$THINGWORX_DIRECTORY'running.pid

[Install]
WantedBy=multi-user.target"

sudo sh -c "echo '$serviceText' > /etc/systemd/system/'$SERVICE_NAME'.service"