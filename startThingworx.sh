#!/bin/bash

# Bash script for starting Thingworx
# Should be compatible with Linux, OSX, and Windows under MinGW

# Define color codes
RED='\033[0;31m'
WHITE_BG='\033[47m'
NC='\033[0m' # No Color

# Function to read and parse the configuration properties
read_properties() {
    local file="./config.properties"
    if [ -f "$file" ]; then
        echo -e "${RED}Reading ${WHITE_BG}config.properties${NC}${RED}...${NC}"
        while IFS='=' read -r key value; do
            key=$(echo "$key" | tr '.' '_')
            eval "config_${key}='${value}'"
        done < <(grep -v '^#' "$file")
    else
        echo -e "${RED}$file not found.${NC}"
        exit 1
    fi
}

# Function to set environment variables based on config
set_environment() {
    [ -n "${config_JRE_HOME}" ] && export JRE_HOME="${config_JRE_HOME}"
    PROMPT_COMMAND='echo -ne "${config_instanceName}"'
    export THINGWORX_PLATFORM_SETTINGS="$(pwd)"
    export CATALINA_PID="$(pwd)/running.pid"
}

# Function to open Thingworx Home in a browser
open_in_browser() {
    echo -e "${RED}Opening Thingworx in browser...${NC}"
    local URL="http://localhost:${config_http_port}/Thingworx/Home"
    [[ -x $BROWSER ]] && exec "$BROWSER" "$URL" &
    path=$(which xdg-open || which gnome-open || which open) && exec "$path" "$URL"
}

# Function to start Tomcat server
start_tomcat() {
    pushd apache-tomcat > /dev/null || exit
    chmod +x bin/*.sh
    echo -e "${RED}Finished parsing config.properties. Starting tomcat on HTTP port ${WHITE_BG}${config_http_port}${NC}${RED} and HTTPS port ${WHITE_BG}${config_https_port}${NC}${NC}"

    local debugCommand=""
    if [ "${config_debugging_enable}" == "true" ]; then
        debugCommand="-agentlib:jdwp=transport=dt_socket,address=${config_debugging_port},server=y,suspend=n"
        echo -e "${RED}Debugging is enabled and starting on ${WHITE_BG}${config_debugging_port}${NC}${NC}"
    fi

    export CATALINA_OPTS="-server -Dfile.encoding=UTF-8 -Djava.library.path=webapps/Thingworx/WEB-INF/extensions -XX:+UseG1GC -Xms${config_config_minMemory} -Dport.http=${config_http_port} -Dport.https=${config_https_port} -Dhttps.keystorePassword=${config_https_keystorePassword} ${debugCommand} ${config_config_additionalParams}"
    export CATALINA_HOME=$(pwd)
    source bin/catalina.sh run "$CATALINA_OPTS"
    popd > /dev/null || return
}

# Main script execution
echo -e "${RED}Starting up portable Thingworx instance...${NC}"
read_properties
set_environment
if [ "${config_openbrowser_disabled}" != "true" ]; then
  open_in_browser
fi
start_tomcat
