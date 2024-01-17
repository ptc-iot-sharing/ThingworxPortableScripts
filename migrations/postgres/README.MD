# ThingWorx Migration scripts for PostgreSQL

This folder should contain subfolders with the relevant migration for all ThingWorx Postgres options.

Please see the official instructions on how to apply them. For example under [Configure and Execute the PostgreSQL Database Script](https://support.ptc.com/help/thingworx/platform/r9.5/en/#page/ThingWorx/Help/Installation/Installation/install_and_configure_postgresql_windows.html#) you can find the instructions for running the scripts on windows.

The scripts require `psql` installed. It is usually installed when you install the PostgreSQL server.
However, you can also install it separately, by following the instructions [here](https://docs.risingwave.com/docs/current/install-psql-without-postgresql/).

A common workflow for is to:
0. Prerequisites
   1. Ensure you have a postgresql server that will host this database, and that your machine can connect to it using a user that has `CREATE DATABASE` privileges.
   2. Create a new user on that database with credentials. You can either do this from an UI tool, or by running `sudo psql -U postgres -c "CREATE USER twadmin WITH PASSWORD '<unique postgres password>';"`
1. Edit first couple of lines of `thingworxPostgresDBSetup.sh` (or the `.bat` if running on windows), to point all the variables to your database.
2. Run `thingworxPostgresDBSetup.sh`
3. Edit first couple of lines of `thingworxPostgresSchemaSetup.sh` (or the `.bat` if running on windows), to point all the variables to your database.
4. Run `thingworxPostgresSchemaSetup.sh`
5. Open `platform-settings.json` and adjust the `PersistenceProviderPackageConfigs.PostgresPersistenceProviderPackage.ConnectionInformation` section.
6. Run ThingWorx using `startThingworx.sh` (or `.bat` if running windows)
