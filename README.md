# Portable Blank Thingworx

---

> [!CAUTION]
> IT IS NOT ADVISED TO USE THIS THINGWORX DEPLOYMENT IN PRODUCTION ENVIRONMENTS.
> THE INTENDED USE IS IN DEVELOPMENT OF THINGWORX APPLICATIONS. BECAUSE IT'S NOT AN OFFICIAL THINGWORX DEPLOYMENT, PTC SUPPORT MAY REJECT TICKETS.

---

This is portable version of Thingworx. It's tested on Windows, Linux and macOS.
When using ThingWorx with H2 (versions lower than 9.5), it means that a single folder contains the entire ThingWorx server, that can be archived and moved around.

When using ThingWorx 9.5 or greater, which no longer has H2 database support, configuration for the target database is needed. Please see the [official docs](https://support.ptc.com/help/thingworx/platform/r9.5/en/#page/ThingWorx/Help/Installation/Installation/database_installation_and_configuration_windows.html#) for more information.

## How to use

### Prepare an initial package

This repository only contains scripts and configuration files, and does not redistribute any of the required software packages required to run the Portable ThingWorx.

The following steps must be done to add these software packages on top of this codebase:

1. Unzip the entire package downloaded from git.
2. Download [Apache Tomcat 9](https://tomcat.apache.org/download-90.cgi), the `zip` binary distribution.
3. Unzip it into the `apache-tomcat` folder, ensuring that the files that already exist in it are not overwritten (`/conf` and `/webapps/ROOT` folders).
4. Download the ThingWorx version of your choosing from the PTC Support portal.
5. Place the `Thingworx.war` file in `apache-tomcat/webapps`.

The folder will now contain both the scripts and configuration, and the actual software packages. This folder can be used as the "seed" for multiple other environments, by just duplicating it, or zipping it up and sharing it.

### Configuring the package

Open the `config.properties` file in order to configure ports/other settings.

Once configured, run `startThingworx` script, selecting the `bat` or the `sh` version depending on your operating systems. For Windows, run `startThingworx.bat`.

If the port is currently occupied the startup script will begin searching for an available one (windows only). Please note that you must manually update the `config.properties` file with the found port if you want to persist it.

The startup script will also automatically open a web browser to the HTTP version of thingworx. A `launchThingworx` shortcut is also created allowing you to easily launch the Thingworx Composer.

Here are the links to the default ports:

- [http://localhost:8015/Thingworx](http://localhost:8015/Thingworx)
- [https://localhost:8443/Thingworx](https://localhost:8443/Thingworx)

## Advanced Usages

### Changing the Thingworx Version or the Persistance Package

By default, this package uses Thingworx with PostgreSQL. To change the TWX version just replace the `Thingworx.war` file in `apache-tomcat/webapps` with your war file. Please refer to the migration guide for information on how to move across persistance provider packages. If you want to change the `platform-settings.json` file, you can find it in the root directory of the archive.

### Generating services for an instance

If you ever want to create a service for a particular instance, in order to add in to startup, you have some scripts in the `utils` folder.

On Windows, the `windows_service.bat` script will automatically create a service based on the configuration in your `config.properties`. You can then user the native Windows UI to control the startup options.

On Linux system with _systemd_ the `systemd_unit.sh` script can automatically generate a unit for a Thingworx instance. Just make sure to edit it by adding the service name.

## **Not working. What to do?**

- Ensure that Java is installed on the machine. You can set the JRE_HOME variable inside the config.properties file, but it's not required.
- On linux/macOS make sure that the _sh_ files are marked as executable (`find . -iname \*.sh | xargs chmod +x` )
- Create an issue on github, or contact me [placatus@iqnox.com](mailto:placatus@iqnox.com)
