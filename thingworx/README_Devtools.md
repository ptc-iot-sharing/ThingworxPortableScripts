# Portable Thingworx DevTools

***
    IT IS NOT ADVISED TO SHARE THIS THINGWORX SERVER WITH CUSTOMERS OR USE IT IN PRODUCTION ENVIRONMENTS
    INTENDED USE IS IN DEVELOPMENT OF THINGWORX APPLICATIONS. BECAUSE IT'S NOT AN OFFICIAL THINGWORX DEPLOYMENT, SUPPORT MAY REJECT TICKETS.
***

This is a fully portable version of Thingworx. You will have a single folder that you can share around which contains an entire Thingworx. It uses the H2 persistence provider, you can run multiple TWXs at the same time on the same machine. It's tested on Windows, Linux and macOS.
It also includes multiple additions that make the life of a developer nicer. It's best to use it while developing Thingworx applications.

## Licensing

**This package contains an unlimited trial lincense. However, it's recommended that you get your own license from the [support portal](https://support.ptc.com/apps/licensePortal/auth/ssl/index?wcn=341) or the internal [Apollo website](http://apollo.ptcnet.ptc.com/Procedures/ThingXRequest.html)**.

## How to use

Open the `config.properties` file in order to configure ports/other settings. 

Once configured, run `startThingworx` script, selecting the `bat` or the `sh` version depending on your operating systems. For Windows, run `startThingworx.bat`.

If the port is currently occupied the startup script will begin searching for an available one. Please note that you must manually update the `config.properties` file with the found port if you want to persist it.

The startup script will also automatically open a web browser to the HTTP version of thingworx. A `launchThingworx` shortcut is also created allowing you to easily launch the Thingworx Compsoer.

**PLEASE NOTE** that the default credentials are **Administrator**, **admin**.

Here are the links to the default ports:

* [http://localhost:8015/Thingworx](http://localhost:8015/Thingworx)
* [https://localhost:8443/Thingworx](https://localhost:8443/Thingworx)

When you want to share this with a collegue, you can just zip the entire folder and send it.

## Download

You can always find information about the latest version [here](http://roicentersvn/placatus/ThingworxPortableScripts/src/branch/master/thingworx/README_Devtools.md)
Download from here: [here (ftp server)](ftp://rostorage.ptcnet.ptc.com/SHARE/Petrisor/Thingworx/Thingworx%208.2%20DevTools.zip). Username: **guest1**, Password: **guest**. It is based in **8.2.3**

## What's included

### Thingworx JS Services Debugger

Used for debugging the Javascript services from the Thingworx entities. You can debug either when in Composer, when testing services, or in Mashup Runtime (by interceping service calls). Developed by [Bogdan Mihaiciuc](mailto:bmihaiciuc@ptc.com).
[Documentation is available here](https://share.ptc.com/sites/sales/ic/IoT%20Presales%20Enablement/Shared%20Documents/Custom%20Extensions%20and%20Edge%20MicroServers/Thingworx%20Services%20Debugger%20-%20User%20Guide.pdf).

### Better Script Editor - Monaco Code editor

Replaces the standard code editor in the Standard Composer with a new, more advanced one, with powerfull autocompletion and focused on keyboard shortcuts. Also, allows writing services using typescript. Developed by [Petrisor Lacatus](mailto:placatus@ptc.com).
[Documentation is available here](http://roicentersvn/placatus/MonacoScriptEditorWidget).

### Custom Javascript and CSS in mashups

Two additional widgets, `Object` and `Style` allow you to write code that changes the mashup runtime. See more [here](http://roicentersvn/BogdanMihaiciuc/BMCodeHost/releases). Developed by [Bogdan Mihaiciuc](mailto:bmihaiciuc@ptc.com).

### Collection View widget

A very powerful widget, that, in most simple usecases can be used as a replacement for a repeater, but is capable of much more advanced usages. Please note that while 8.2 contains the `Collection` widget out of the box, the `Collection View` has more features and an automatic configurator.
[More information here](https://share.ptc.com/sites/sales/ic/IoT%20Presales%20Enablement/blog/Lists/Posts/Post.aspx?ID=69), and recent releases [here](http://roicentersvn/BogdanMihaiciuc/BMCollectionView/releases). Developed by [Bogdan Mihaiciuc](mailto:bmihaiciuc@ptc.com).

### View widget

A constraint based layout allowing you to create UIs by specifying constaints between the elements inside the layout. More information about it can be found [here](http://roicentersvn/BogdanMihaiciuc/BMCoreUI/releases#bmview). New releases can be obtained from [here](http://roicentersvn/BogdanMihaiciuc/BMView/releases). Developed by [Bogdan Mihaiciuc](mailto:bmihaiciuc@ptc.com).

### Git Backup Extension

Easily export a project to a git repository. Comes with a complete UI for quick git operations like, push, pull or branching. Also contaisn a tool allowing exporting of all the installed extensions. See more details [here](https://ptccloud-my.sharepoint.com/personal/vrosu_ptc_com/_layouts/15/onedrive.aspx?slrid=cf51609e-1087-5000-8c32-84baf7a5a1a7&id=%2Fpersonal%2Fvrosu_ptc_com%2FDocuments%2FGit%20Backup%20Extension&FolderCTID=0x012000DE84CCB884F1A24A94064FADC5B33B6F). Developed by [Vladimir Rosu](vrosu@ptc.com).

### Source Control Exporter

More easily export and import projects in a dedicated UI. Exporting also strips away the change history for better source control integration. See more details [here](https://share.ptc.com/sites/sales/ic/IoT%20Presales%20Enablement/blog/Lists/Posts/Post.aspx?ID=73). Developed by [Moritz von Hasselbach](mailto:mvonhasselbach@ptc.com).

### Refactoring Helper

Move services from one thing to another, change the ThingTemplate of a Thing. All of this is possible with the Refactoring Helper extension. More details [here](https://share.ptc.com/sites/sales/ic/IoT%20Presales%20Enablement/blog/Lists/Posts/Post.aspx?ID=74). Developed by [Moritz von Hasselbach](mailto:mvonhasselbach@ptc.com).

### Extension AutoUpdater

For some of the extensions mentioned above, auto-updating is supported. When the Composer loads, the extensions are checked for updates, and a simple UI allows the user to update them without leaving the Composer. The following extensions are supported by this mechanism: _Monaco Code Editor_, _BMCollectionView_, _BMView_, _BMCoreUI_, _BMCodeHost_. Developed by [Bogdan Mihaicuc](mailto:bmihaiciuc@ptc.com).

## Advanced Usages

### Other Thingworx versions

You can also find previous versions of the package [here](ftp://rostorage.ptcnet.ptc.com/SHARE/Petrisor/Thingworx/) (including 6.5 versions)

### Generating services for an instance

If you ever want to create a service for a particular instance, in order to add in to startup, you have some scripts in the `utils` folder.

On Windows, the `windows_service.bat` script will automatically create a service based on the configuration in your `config.properties`. You can then user the native Windwos UI to control the startup options.

On Linux system with _SystemD_ the `systemd_unit.sh` script can automatically generate a unit for a Thingworx instance. Just make sure to edit it by adding the service name.

## **Not working. What to do?**

* Ensure that Java is installed on the machine. You can set the JRE_HOME variable inside the config.properties file, but it's not required.
* On linux/macOS make sure that the sh files are marked as executable (find . -iname \*.sh | xargs chmod +x )
* Contact me [placatus@ptc.com](mailto:placatus@ptc.com)