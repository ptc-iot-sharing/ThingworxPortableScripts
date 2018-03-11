# Portable Blank Thingworx 

***
    IT IS NOT ADVISED TO SHARE THIS THINGWORX SERVER WITH CUSTOMERS OR USE IT IN PRODUCTION ENVIRONMENTS
    INTENDED USE IS IN DEVELOPMENT OF THINGWORX APPLICATIONS. BECAUSE IT'S NOT AN OFFICIAL THINGWORX DEPLOYMENT, SUPPORT MAY REJECT TICKETS.
***

This is a fully portable version of Thingworx. You will have a single folder that you can share around which contains an entire Thingworx. It uses the H2 persistence provider, you can run multiple TWXs at the same time on the same machine. It's tested on Windows, Linux and macOS.

## Licensing
**This package contains an unlimited trial lincense. However, it's recommended that you get your own license from the [support portal](https://support.ptc.com/apps/licensePortal/auth/ssl/index?wcn=341)**. Please note that you must obtain a official license in order to import Manufacturing Apps.


## How to use:

Open the `config.properties` file in order to configure ports/other settings. 

Once configured, run `startThingworx` script, selecting the `bat` or the `sh` version depending on your operating systems. For Windows, run `startThingworx.bat`.   

If the port is currently occupied the startup script will begin searching for an available one. Please note that you must manually update the `config.properties` file with the found port if you want to persist it.

The startup script will also automatically open a web browser to the HTTP version of thingworx. A `launchThingworx` shortcut is also created allowing you to easily launch the Thingworx Compsoer.

**PLEASE NOTE** THAT IN Thingworx 8.2 the default administrator password has been changed to: Login Name: **Administrator** Password: **trUf6yuz2?_Gub**

Here are the links to the default ports:
*   [http://localhost:8015/Thingworx](http://localhost:8015/Thingworx)
*   [https://localhost:8443/Thingworx](https://localhost:8443/Thingworx)

When you want to share this with a collegue, you can just zip the entire folder and send it.


## Advanced Usages
### Changing the Thingworx Version

By default, this package uses Thingworx with H2. To change the TWX version just replace the `Thingworx.war` file in `apache-tomcat/webapps` with your war file. Please note that in place upgrades WILL not work between TWX versions with different version providers. If you want to change the `platform-settings.json` file, you can find it in the root directory of the archive.

You can also find previous versions of the package here :

[ftp://rostorage.ptcnet.ptc.com/SHARE/Petrisor/Thingworx/](ftp://rostorage.ptcnet.ptc.com/SHARE/Petrisor/Thingworx/) (including 6.5 versions)  

### Thingworx Portable with DevTools

A blank Thingworx package with multiple additions that make the life of a developer nicer. It's best to use it while developing Thingworx applications.

Download from here: [here (ftp server)](ftp://rostorage.ptcnet.ptc.com/SHARE/Petrisor/Thingworx/Thingworx%208.2%20DevTools.zip). Username: **guest1**, Password: **guest**. It is based in **8.2**.

Included in the DevTools you have:

#### Thingworx JS Services Debugger

Used for debugging the Javascript services from the Thingworx entities. You can debug either when in Composer, when testing services, or in MashupViewer (by interceping service calls).

[Documentation is available here](https://share.ptc.com/sites/sales/ic/IoT%20Presales%20Enablement/Shared%20Documents/Custom%20Extensions%20and%20Edge%20MicroServers/Thingworx%20Services%20Debugger%20-%20User%20Guide.pdf).

#### Better Script Editor - Monaco Code editor

Replaces the standard code editor in the Standard Composer with a new, more advanced one, with powerfull autocompletion and focused on keyboard shortcuts. Also, allows writing services using typescript.

[Documentation is available here](http://roicentersvn/placatus/MonacoScriptEditorWidget)

#### Custom Javascript and CSS in mashups

Two additional widgets, `Javascript` and `CSS` allow you to write code that changes the mashup runtime.

#### Collection View widget

A very powerfull widget, that, in most simple usecases can be used as a replacement for a repeater, but is capable of much more advanced usages.

[More information here](https://share.ptc.com/sites/sales/ic/IoT%20Presales%20Enablement/blog/Lists/Posts/Post.aspx?ID=69)

## **Not working. What to do?**

*   Ensure that Java is installed on the machine. You can set the JRE_HOME variable inside the config.properties file, but it's not required.
*   On linux/OSX make sure that the sh files are marked as executable (find . -iname \*.sh | xargs chmod +x )
*   Contact me [placatus@ptc.com](mailto:placatus@ptc.com)

