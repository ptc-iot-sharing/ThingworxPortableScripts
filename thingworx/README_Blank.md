# Portable Blank Thingworx

***
    IT IS NOT ADVISED TO SHARE THIS THINGWORX SERVER WITH CUSTOMERS OR USE IT IN PRODUCTION ENVIRONMENTS
    INTENDED USE IS IN DEVELOPMENT OF THINGWORX APPLICATIONS. BECAUSE IT'S NOT AN OFFICIAL THINGWORX DEPLOYMENT, SUPPORT MAY REJECT TICKETS.
***

This is a fully portable version of Thingworx. You will have a single folder that you can share around which contains an entire Thingworx. It uses the H2 persistence provider, you can run multiple TWXs at the same time on the same machine. It's tested on Windows, Linux and macOS.

## Licensing

**This package contains an unlimited trial lincense. However, it's recommended that you get your own license from the [support portal](https://support.ptc.com/apps/licensePortal/auth/ssl/index?wcn=341) or the internal [Apollo website](http://apollo.ptcnet.ptc.com/Procedures/ThingXRequest.html)**.

## Download

You can always find information about the latest version [here](http://roicentersvn/placatus/ThingworxPortableScripts/src/branch/master/thingworx/README_Blank.md)
Download from here: [here (ftp server)](ftp://rostorage.ptcnet.ptc.com/SHARE/Petrisor/Thingworx/Thingworx_8.3_Blank.zip). Username: **guest1**, Password: **guest**. It is based on **8.3.1**.

## How to use

Open the `config.properties` file in order to configure ports/other settings.

Once configured, run `startThingworx` script, selecting the `bat` or the `sh` version depending on your operating systems. For Windows, run `startThingworx.bat`.

If the port is currently occupied the startup script will begin searching for an available one. Please note that you must manually update the `config.properties` file with the found port if you want to persist it.

The startup script will also automatically open a web browser to the HTTP version of thingworx. A `launchThingworx` shortcut is also created allowing you to easily launch the Thingworx Compsoer.

**PLEASE NOTE** THAT IN Thingworx 8.3 the default administrator password has been changed to: Login Name: **Administrator** Password: **Administrator**

Here are the links to the default ports:

* [http://localhost:8015/Thingworx](http://localhost:8015/Thingworx)
* [https://localhost:8443/Thingworx](https://localhost:8443/Thingworx)

When you want to share this with a collegue, you can just zip the entire folder and send it.

## Advanced Usages

### Changing the Thingworx Version or the Persistance Package

By default, this package uses Thingworx with H2. To change the TWX version just replace the `Thingworx.war` file in `apache-tomcat/webapps` with your war file. Please refer to the migration guide for information on how to move across persistance provider packages. If you want to change the `platform-settings.json` file, you can find it in the root directory of the archive.

You can also find previous versions of the package here:

[ftp://rostorage.ptcnet.ptc.com/SHARE/Petrisor/Thingworx/](ftp://rostorage.ptcnet.ptc.com/SHARE/Petrisor/Thingworx/) (including 6.5 versions)

### Generating services for an instance

If you ever want to create a service for a particular instance, in order to add in to startup, you have some scripts in the `utils` folder.

On Windows, the `windows_service.bat` script will automatically create a service based on the configuration in your `config.properties`. You can then user the native Windwos UI to control the startup options.

On Linux system with _systemD_ the `systemd_unit.sh` script can automatically generate a unit for a Thingworx instance. Just make sure to edit it by adding the service name.

### Thingworx Portable with DevTools

A blank Thingworx package with multiple additions that make the life of a developer nicer. It's best to use it while developing Thingworx applications.

You can find more details about it [here](http://roicentersvn/placatus/ThingworxPortableScripts/src/branch/master/thingworx/README_Devtools.md), and download [here (ftp server)](ftp://rostorage.ptcnet.ptc.com/SHARE/Petrisor/Thingworx/Thingworx%208.3%20DevTools.zip). Username: **guest1**, Password: **guest**. It is based in **8.3**.

Included in the DevTools you have:

* Thingworx JS Services Debugger
* Better Script Editor - Monaco Code editor
* Custom Javascript and CSS in mashups
* Collection View widget
* View Widget
* Refactoring Helper
* Git Export Extension
* Web design Kit

## **Not working. What to do?**

* Ensure that Java is installed on the machine. You can set the JRE_HOME variable inside the config.properties file, but it's not required.
* On linux/macOS make sure that the _sh_ files are marked as executable (`find . -iname \*.sh | xargs chmod +x` )
* Contact me [placatus@ptc.com](mailto:placatus@ptc.com)