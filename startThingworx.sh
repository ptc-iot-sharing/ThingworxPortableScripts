#!/bin/bash

## Bash script for starting thingworx
## Should be compatible with Linux, as well as OSX
## It will also run on windows under MinGW, but has been less tested there

RED='\033[0;31m'
WHITE_BG='\033[47m'
NO_BG='\033[0m'
NC='\033[0m' # No Color

echo -e "${RED}Starting up portable thingworx instance...${NC}"
echo -e "${RED}Reading ${WHITE_BG}config.properties${NO_BG}${RED}...${NC}"

#read the properties file
file="./config.properties"

if [ -f "$file" ]
then

  while IFS='=' read -r key value
  do
    key=$(echo $key | tr '.' '_')
    eval "config_${key}='${value}'"
  done < <(grep -v '^#' $file)

  if [[ ${config_JRE_HOME} ]]; then export JRE_HOME=${config_JRE_HOME}; fi

  PROMPT_COMMAND="echo -ne ${config_instanceName}"
  export THINGWORX_PLATFORM_SETTINGS=$(pwd)
  export CATALINA_PID="$(pwd)/running.pid"
  pushd apache-tomcat > /dev/null

  #make sure all the files in the bin folder are executable
  chmod +x bin/*.sh

  echo -e "${RED}Finished parsing ${WHITE_BG}config.properties${NO_BG}${RED}. Starting tomcat on http port ${WHITE_BG}${config_http_port}${NO_BG}${RED} and https port ${WHITE_BG}${config_https_port}${NO_BG}${NC}"

  URL=http://localhost:${config_http_port}/Thingworx/Home
  [[ -x $BROWSER ]] && exec "$BROWSER" "$URL" &
  path=$(which xdg-open || which gnome-open || which open) && exec "$path" "$URL" &
  echo "Can't find browser"

  if [ "${config_debugging_enable}" == "true" ] ; then
    # only enable debugging if needed
    debugCommand="-agentlib:jdwp=transport=dt_socket,address=${config_debugging_port},server=y,suspend=n"
    echo -e "${RED}Debugging is enabled and starting on ${WHITE_BG}${config_debugging_port}${NO_BG}${NC}"
  fi

export CATALINA_OPTS="-server -Dfile.encoding=UTF-8 -Djava.library.path=webapps/Thingworx/WEB-INF/extensions -XX:+UseG1GC -Xms${config_config_minMemory} -Dport.http=${config_http_port} -Dport.https=${config_https_port} -Dhttps.keystorePassword=${config_https_keystorePassword} ${debugCommand} ${config_config_additionalParams} "
export CATALINA_HOME=$(pwd)

source bin/catalina.sh run $CATALINA_OPTS

popd > /dev/null

else
  echo "$file not found."
fi