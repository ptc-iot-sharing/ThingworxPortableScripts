@echo off
SETLOCAL enabledelayedexpansion

echo Creates a new windows service based in this portable instance.
echo This script must run as a administrator


:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------    
rem modify this if you want to automatically start this service
set SERVICE_STARTUP_MODE=manual
echo Reading config.properties...
echo ==========================================

rem read the properties file
for /F "eol=# delims== tokens=1,*" %%a in (..\config.properties) do (
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
    )
)

set JRE_HOME
pushd ..\
SET THINGWORX_PLATFORM_SETTINGS=%cd%
popd
pushd ..\apache-tomcat
SET CATALINA_HOME=%cd%
set JvmArgs=-Dfile.encoding=UTF-8;-Djava.library.path=%CATALINA_HOME%/webapps/Thingworx/WEB-INF/extensions;-XX:+UseG1GC;-Dport.http=%config_http_port%;-Dport.https=%config_https_port%;-Dhttps.keystorePassword=%config_https_keystorePassword%;%config_config_additionalParams%; 
set PR_Environment=THINGWORX_PLATFORM_SETTINGS=%THINGWORX_PLATFORM_SETTINGS%
set PR_DisplayName=Thingworx Tomcat %config_instanceName%
set JvmMs=%config_config_minMemory%
set JvmMx=%config_config_minMemory%
call bin\service.bat install
popd