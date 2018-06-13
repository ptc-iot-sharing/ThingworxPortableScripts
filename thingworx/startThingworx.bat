@echo off
SETLOCAL enabledelayedexpansion

echo ==========================================
echo ==========================================
echo Starting up portable thingworx instance...
echo ==========================================
echo Reading config.properties...
echo ==========================================
echo ==========================================

rem read the properties file
for /F "eol=# delims== tokens=1,*" %%a in (config.properties) do (
    set aux=%%a
    if NOT "%%a"=="" if NOT "%%b"=="" set config_!aux:.=_!=%%b
)

IF DEFINED config_JRE_HOME (
    SET JRE_HOME=%config_JRE_HOME%
)
IF NOT DEFINED JRE_HOME ( 
    rem attempt to get the JRE_HOME from registry

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

    set JRE_HOME=
    for /f "tokens=2,*" %%a in ('reg query !KEY! /v !VALUE! ^| findstr !VALUE!') do (
        set JRE_HOME=%%b
        echo Using the JRE_HOME found in registry under %JRE_HOME%
    )
)

rem check if the ports are open
set freePort=
set startPort=%config_http_port%

:SEARCHHTTPPORT
netstat -o -n -a | find "LISTENING" | find ":%startPort% " > NUL
if "%ERRORLEVEL%" equ "0" (
  echo The HTTP port %startPort% is unavailable. Searching for a available one...
  set /a startPort +=1
  GOTO :SEARCHHTTPPORT
) ELSE (
  set freePort=%startPort%
  if "%startPort%" == "%config_http_port%" (
    GOTO :FINISHEDHTTPPORT
  ) ELSE (
    GOTO :FOUNDHTTPPORT
  )
)

:FOUNDHTTPPORT
choice /M "Found the following free port for HTTP: %freePort%. Would you like to use it?" /c YN
if errorlevel 255 (
  echo Error. Please answer with yes no
  GOTO :CLOSE
) else if errorlevel 2 (
  echo Thingworx cannot start because port %config_http_port% is not free. Please use a free port in config.properties.
  GOTO :CLOSE
) else if errorlevel 1 (
  echo Using port %freePort% for http. Please update the config.properties to keep using this port.
  set config_http_port=%freePort%
  pause
) else if errorlevel 0 (
  echo Error. Please answer with yes no
  GOTO :CLOSE
)

:FINISHEDHTTPPORT
rem check if the ports are open
set freePort=
set startPort=%config_https_port%

:SEARCHHTTPSPORT
netstat -o -n -a | find "LISTENING" | find ":%startPort% " > NUL
if "%ERRORLEVEL%" equ "0" (
  echo The HTTPS port %startPort% is unavailable. Searching for a available one...
  set /a startPort +=1
  GOTO :SEARCHHTTPSPORT
) ELSE (
  set freePort=%startPort%
  if "%startPort%" == "%config_https_port%" (
    GOTO :FINISHEDHTTPSPORT
  ) ELSE (
    GOTO :FOUNDHTTPSPORT
  )
  GOTO :FOUNDHTTPSPORT
)

:FOUNDHTTPSPORT
choice /M "Found the following free port for HTTPS: %freePort%. Would you like to use it?" /c YN
if errorlevel 255 (
  echo Error. Please answer with yes no
  GOTO :CLOSE
) else if errorlevel 2 (
  echo Thingworx cannot start because port %config_https_port% is not free. Please use a free port in config.properties.
  GOTO :CLOSE
) else if errorlevel 1 (
  echo Using port %freePort% for https. Please update the config.properties to keep using this port.
  set config_https_port=%freePort%
  pause
) else if errorlevel 0 (
  echo Error. Please answer with yes no
  GOTO :CLOSE
)
:FINISHEDHTTPSPORT
set JRE_HOME
rem set the terminal title
TITLE %config_instanceName%
rem the platform_settigns.json is in the same folder 
SET THINGWORX_PLATFORM_SETTINGS=%cd%
echo ==========================================
echo ==========================================
echo Finished parsing config.properties. Starting tomcat on http port %config_http_port% and https port %config_https_port% and using JRE HOME: %JRE_HOME%

GOTO :WRITEURLFILE

:STARTTHINGWORX
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

GOTO :CLOSE

:WRITEURLFILE
echo [InternetShortcut]> launchThingworx.url
echo URL=http://localhost:%config_http_port%/Thingworx/Home>> launchThingworx.url
rem also open the url
start "" http://localhost:%config_http_port%/Thingworx/Home
GOTO :STARTTHINGWORX

:CLOSE
rem cleanup namespace config.
for /F "tokens=1 delims==" %%v in ('set config_ 2^>nul') do (
   set %%v=
)
pause