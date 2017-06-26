#!/bin/bash

#configure here all the properties you would otherwise set in setenv.sh

#read the properties file
file="./config.properties"

if [ -f "$file" ]
then

  while IFS='=' read -r key value
  do
    key=$(echo $key | tr '.' '_')
    eval "config_${key}='${value}'"
  done < <(grep -v '^#' $file)

  if [[ ${config_JAVA_HOME} ]]; then export JAVA_HOME=${config_JAVA_HOME}; fi

  PROMPT_COMMAND="echo -ne ${config_instanceName}"
  export THINGWORX_PLATFORM_SETTINGS=$(pwd)
  export CATALINA_PID="$(pwd)/running.pid"
  pushd apache-tomcat
  
  #make sure all the files in the bin folder are executable
  chmod +x bin/*.sh

  if [ "${config_enableDebugging}" == "true" ] ; then
    # only enable debugging if needed
    debugCommand="-agentlib:jdwp=transport=dt_socket,address=${config_debuggingPort},server=y,suspend=n"
 fi
export CATALINA_OPTS="-Dserver -Dfile.encoding=UTF-8 -Djava.library.path=webapps/Thingworx/WEB-INF/extensions -Dd64 -XX:+UseNUMA -XX:+UseConcMarkSweepGC -XX:PermSize=128m -XX:MaxPermSize=2048m -Xms512M -Dport.http=${config_httpPort} -Dport.https=${config_httpsPort} -Dshutdownport.http=${config_shutdownPort} ${debugCommand}"
export CATALINA_HOME=$(pwd)

source bin/catalina.sh run $CATALINA_OPTS

popd

else
  echo "$file not found."
fi