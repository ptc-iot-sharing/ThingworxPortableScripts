# ThingWorx Migration scripts for PostgreSQL

This folder should contain subfolders with the relevant migration for all ThingWorx Postgres options.

Please see the official instructions on how to apply them. For example under [Configure and Execute the PostgreSQL Database Script](https://support.ptc.com/help/thingworx/platform/r9.5/en/#page/ThingWorx/Help/Installation/Installation/install_and_configure_postgresql_windows.html#) you can find the instructions for running the scripts on windows.

The scripts require `psql` installed. It is usually installed when you install the PostgreSQL server.
However, you can also install it separately, by following the instructions [here](https://docs.risingwave.com/docs/current/install-psql-without-postgresql/).

A common workflow for is to:
1. Prerequisites
   1. Ensure that `psql` is installed and in your PATH. You can check this by running `psql --version` in a terminal.
   2. Ensure you have a postgresql server that will host this database, and that your machine can connect to it using a user that has `CREATE DATABASE` privileges.
   3. Create a new user on that database with credentials. You can either do this from a UI tool, or by running `sudo psql -U postgres -c "CREATE USER twadmin WITH PASSWORD '<unique postgres password>';"`.
   4. Note that if this is just a local test environment, you can use the default `postgres` user.
2. Edit first couple of lines of `thingworxPostgresDBSetup.sh` (or the `.bat` if running on windows), to point all the variables to your database.
    ```bash
    server="localhost"                              # Where the database is hosted, usually localhost for local databases
    port=5432                                       # The port the database is listening on          
    database="thingworx_portable_test"              # The name of the database to create
    tablespace="thingworx_portable_test"            # Completely arbitrary name for the tablespace
    tablespace_location=""                          # The location of the tablespace, leave empty for default
    adminusername="postgres"                        # The username of the admin user. Usually postgres
    thingworxusername="twadmin"                     # The username for the ThingWorx user, created in step 1.3
   ```
3. Run `thingworxPostgresDBSetup.sh`
4. Edit first couple of lines of `thingworxPostgresSchemaSetup.sh` (or the `.bat` if running on windows), to point all the variables to your database.
    ```bash
    server="localhost"                            # Where the database is hosted, usually localhost for local databases 
    database="thingworx_portable_test"            # The name of the database that was created in the previous step
    port=5432                                     # The port the database is listening on
    username="twadmin"                            # The username for the ThingWorx user, created in step 1.3
    schema="public"                               # The schema to create the ThingWorx tables in, usually public
    ```
5. Run `thingworxPostgresSchemaSetup.sh`
6. Open `platform-settings.json` and adjust the `PersistenceProviderPackageConfigs.PostgresPersistenceProviderPackage.ConnectionInformation` section.
7. Run ThingWorx using `startThingworx.sh` (or `.bat` if running windows)

## Backup and restore

You may often need to backup and restore your database. This is not covered by the PTC-provided scripts, but is a common operation that's easy to do.

The easiest way to backup and restore a PostgreSQL database is to use the [`pg_dump`](https://www.postgresql.org/docs/current/app-pgdump.html) and [`pg_restore`](https://www.postgresql.org/docs/current/app-pgrestore.html) utilities. These are command-line tools that come with the PostgreSQL installation.
Ensure that you have them in your PATH.

To execute a backup, you can run the following command:

```bash
pg_dump -Fc dbname_to_backup -f filename.bak -U username
```


To restore a backup, you must first ensure that the database you are restoring to exists. You can create it using the following command:
```sql
CREATE DATABASE dbname_restored OWNER username;
```
    
Then you can restore the backup using the following command:

```bash
pg_restore -d dbname_restored  -U username filename.bak
```

After restoring the database, you may need to adjust the `platform-settings.json` file to point to the new database.