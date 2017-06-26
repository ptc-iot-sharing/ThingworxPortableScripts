@echo off
SETLOCAL enabledelayedexpansion

rem configure any other sys variables you would have in setenv.bat here

rem read the propeties file
for /F "eol=# delims== tokens=1,*" %%a in (config.properties) do (
    if NOT "%%a"=="" if NOT "%%b"=="" set config.%%a=%%b
)

IF DEFINED config.JAVA_HOME (
    SET JAVA_HOME=%config.JAVA_HOME%
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
TITLE %config.instanceName%
rem the platform_settigns.json is in teh same folder 
SET THINGWORX_PLATFORM_SETTINGS=%cd%

pushd apache-tomcat
IF /I "%config.enableDebugging%"=="true" (
    rem only enable debugging if needed
    SET debugCommand=-agentlib:jdwp=transport=dt_socket,address=%config.debuggingPort%,server=y,suspend=n
)
set CATALINA_OPTS=-Dserver -Dfile.encoding=UTF-8 -Djava.library.path=webapps/Thingworx/WEB-INF/extensions  -Dd64 -XX:+UseNUMA -XX:+UseConcMarkSweepGC -XX:PermSize=128m -XX:MaxPermSize=2048m -Xms1024M -Dport.http=%config.httpPort% -Dport.https=%config.httpsPort% -Dshutdownport.http=%config.shutdownPort% %debugCommand%
SET CATALINA_HOME=%CURRENT_DIR%
call bin\catalina.bat run %CATALINA_OPTS%

popd

rem cleanup namespace config.
for /F "tokens=1 delims==" %%v in ('set config. 2^>nul') do (
    set %%v=
)
