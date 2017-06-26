@echo off
SETLOCAL enabledelayedexpansion

echo ==========================================
echo Starting up portable thingworx instance...
echo ==========================================
echo Reading config.properties...
echo ==========================================

rem read the properties file
for /F "eol=# delims== tokens=1,*" %%a in (config.properties) do (
    set aux=%%a
    if NOT "%%a"=="" if NOT "%%b"=="" set config_!aux:.=_!=%%b
)

IF DEFINED config_JAVA_HOME (
    SET JAVA_HOME=%config_JAVA_HOME%
)
IF NOT DEFINED JAVA_HOME ( 
    rem attempt to get the JAVA_HOME from registry

    set KEY="HKLM\SOFTWARE\JavaSoft\Java Runtime Environment"
    set VALUE=CurrentVersion
    reg query !KEY! /v !VALUE! >nul 2>nul || (
        echo JRE not installed 
        exit /b 1
    )
    set JRE_VERSION=
    for /f "tokens=2,*" %%a in ('reg query !KEY! /v !VALUE! ^| findstr !VALUE!') do (
        set JRE_VERSION=%%b
    )

    ::- Get the JavaHome
    set KEY="HKLM\SOFTWARE\JavaSoft\Java Runtime Environment\!JRE_VERSION!"
    set VALUE=JavaHome
    reg query !KEY! /v !VALUE! >nul 2>nul || (
        echo JavaHome not installed
        exit /b 1
    )

    set JAVA_HOME=
    for /f "tokens=2,*" %%a in ('reg query !KEY! /v !VALUE! ^| findstr !VALUE!') do (
        set JAVA_HOME=%%b
    )
)

set JAVA_HOME
rem set the terminal title
TITLE %config_instanceName%
rem the platform_settigns.json is in the same folder 
SET THINGWORX_PLATFORM_SETTINGS=%cd%
echo ==========================================
echo ==========================================
echo Finished parsing config.properties. Starting tomcat on http port %config_http_port% and https port %config_https_port%
pushd apache-tomcat
IF /I "%config_debugging_enable%"=="true" (
    rem only enable debugging if needed
    SET debugCommand=-agentlib:jdwp=transport=dt_socket,address=%config_debugging_port%,server=y,suspend=n
    echo Debugging is enabled and starting on %config_debugging_port%.
)
echo ==========================================
echo ==========================================
set CATALINA_OPTS=-server -Dfile.encoding=UTF-8 -Djava.library.path=webapps/Thingworx/WEB-INF/extensions -d64 -XX:+UseG1GC -Xms%config_config_minMemory% -Dport.http=%config_http_port% -Dport.https=%config_https_port% -Dhttps.keystorePassword=%config_https_keystorePassword% %debugCommand% %config_config_additionalParams% 
SET CATALINA_HOME=%CURRENT_DIR%
call bin\catalina.bat run %CATALINA_OPTS%

popd

rem cleanup namespace config.
for /F "tokens=1 delims==" %%v in ('set config_ 2^>nul') do (
   set %%v=
)
pause