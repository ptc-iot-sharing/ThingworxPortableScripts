# Portable Thingworx [and DevTools]

***

    !!! 

    IT IS NOT ADVISED TO SHARE THIS THINGWORX SERVER WITH CUSTOMERS OR USE IT IN PRODUCTION ENVIRONMENTS
    INTENDED USE IS IN DEVELOPMENT OF THINGWORX APPLICATIONS. BECAUSE IT'S NOT AN OFFICIAL THINGWORX DEPLOYMENT, SUPPORT MAY REJECT TICKETS.

***

**For download all links, use the next credentials to login:** Username: **guest1**, Password: **guest**

This is a fully portable version of Thingworx. You will have a single folder that you can share around which contains an entire Thingworx. It uses the H2 persistence provider, you can run multiple TWXs at the same time on the same machine. 

## Licensing
**While all versions come prepackaged with an unlimited test license, it's recommended that you get your own license from the support portal [https://support.ptc.com/apps/licensePortal/auth/ssl/index?wcn=341](https://support.ptc.com/apps/licensePortal/auth/ssl/index?wcn=341)**

## How to use:

1. Download, extract the entire repository.
2. Open the _config.properties_ file in order to configure ports/other settings.
3. Download Tomcat from https://tomcat.apache.org/download-90.cgi, grabbing the core zip folder.
4. Extract tomcat into the tomcat folder, making sure that no files are overwritten.
5. Download the ThingWorx H2 version you want to use from the PTC Support portal
6. Place the Thingworx.war file under `/apache-tomcat/webapps`
7. Start thingworx using one of the two scripts `startThingworx.bat` or `startThingworx.sh`.
8. Access one of the URLs in the Browser, using _Administrator/admin_ (versions \<8) credentials, or _Administrator/trUf6yuz2?\_Gub_ (version 8.0 and later).

**PLEASE NOTE THAT IN Thingworx 8.0 the default administrator password has been changed to:** Login Name: **Administrator **Password: **trUf6yuz2?_Gub**

*   [http://localhost:8015/Thingworx](http://localhost:8015/Thingworx)

*   [https://localhost:8443/Thingworx](https://localhost:8443/Thingworx)

## What port does it use

Open the _config.properties_ file to find out the used ports for http and https.

## Changing the Thingworx Version

By default, this package uses Thingworx with H2. To change the TWX version just replace the Thingworx.war file in `apache-tomcat/webapps` with your war file. Please note that in place upgrades WILL not work between TWX versions with different version providers. If you want to change the `platform-settings.json` file, you can find it in the root directory of the archive.

Functionalities:

*   All configuration is stored inside the _config.properties_ file.
*   SSL configuration enabled by default (it can also be accessed on simple http).
*   Linux/OSX support. Run the corresponding startThingworx.sh file.
*   Windows support. Run the corresponding startThingworx.bat file.
*   Can easily share whole bundle between windows-linux.

## Related projects

### Better Script Editor - Monaco Code editor

A better script editor with a lot of more features, that grealty simplifies writing services.

[Documentation is here](https://github.com/ptc-iot-sharing/MonacoEditorTWX)

### Thingworx JS Services Debugger

**DEPRECATED: This tool is not mantained and may not work in any new Thingworx versions. Contact placatus@iqnox.com for more details.** 

Used for debugging the Javascript services from the Thingworx entities. You can debug either when in Composer(development time) or in MashupViewer(run time).

[Documentation is here](https://share.ptc.com/sites/sales/ic/IoT%20Presales%20Enablement/Shared%20Documents/Custom%20Extensions%20and%20Edge%20MicroServers/Thingworx%20Services%20Debugger%20-%20User%20Guide.pdf).


## **Not working. What to do?**

*   Ensure that Java is installed on the machine. You can set the JAVA_HOME variable inside the config.properties file, but it's not required.
*   Ensure that you have no other programs listening on the same ports as the ones you configured in config.properties. On windows, you can view the LISTENING ports using (nestat –a –b or using resmon.exe).
*   On linux/OSX make sure that the sh files are marked as executable (find . -iname \*.sh | xargs chmod +x )
*   Contact me [placatus@iqnox.com](mailto:placatus@iqnox.com)

### Changelog

*   Nicer config.properties with more options.
*   Added a bash generator for systemd units (create linux service from an instance)
*   Added a script that generates a windows service out of a portable instance
*   Windows only: added checks for open ports (if the port set is in use, then automatically find an open one)
*   Removed the need to set a shutdown port
*   Added Thingworx Blank 8.0
*   Updated the packages to 7.2.7. Added link to the blank version for 7.3 
*   Updated the packages to 7.2.5 
*   Update to the latest CodeMirror enhacement: Use js_beautify (the same as behind [http://jsbeautifier.org/](http://jsbeautifier.org/) for formatting code
*   Updated the packages to 7.2.4 
*   Updated the packages to 7.2.2
*   Upgraded the packages to 7.2.1
*   Upgraded the packages to 7.2
*   Added the new Charts in the package
