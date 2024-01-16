# Portable Blank Thingworx

---

> [!CAUTION]
> IT IS NOT ADVISED TO SHARE THIS THINGWORX SERVER WITH CUSTOMERS OR USE IT IN PRODUCTION ENVIRONMENTS
> INTENDED USE IS IN DEVELOPMENT OF THINGWORX APPLICATIONS. BECAUSE IT'S NOT AN OFFICIAL THINGWORX DEPLOYMENT, SUPPORT MAY REJECT TICKETS.

---

This is portable version of Thingworx. It's tested on Windows, Linux and macOS.
When using ThingWorx with H2 (versions lower than 9.5), it means that a single folder contains the entire ThingWorx server, that can be archived and moved around.

When using ThingWorx 9.5 or greater, configuration for the target database is needed. Please see the [official docs](https://support.ptc.com/help/thingworx/platform/r9.5/en/#page/ThingWorx/Help/Installation/Installation/database_installation_and_configuration_windows.html#) for more information.

## How to use

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
- Contact me [placatus@iqnox.com](mailto:placatus@iqnox.com)
