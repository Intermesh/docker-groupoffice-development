Group-Office docker compose
===========================

This docker compose environment can be used for development. 
It will install these services:

1. mariadb
2. mailserver based on dovecot and postfix
3. groupoffice apache web server with php 7.3, ioncube, composer and xdebug running on port 8000
4. phpunit for testing
5. PhpMyAdmin running on port 8001. (see below on how to make phpmyadmin settings persist)
6. Webgrind for performance tuning runs on port 8002. 
7. sass container that will watch and compile sass files for you.

Installation
------------

1. Make sure docker and docker-compose are installed.


2. Clone this repository:

   ```bash
   git clone --recurse-submodules https://github.com/Intermesh/groupoffice-docker-development.git
   ```

3. Go into the source dfirectory and checkout the 'master' branch:

   ```bash
   cd groupoffice-docker-development/src/master
   git checkout master
   git pull
   ```

4. Run the stack:

   ```bash
   docker-compose up -d
   ```
   
   Note: The first time you run it 'composer install' will run. This can take some time to complete. View the logs to see the progress.

5. Install Group-Office by going to http://localhost/install/. Note you should not see a page where you enter database connection details. If you see this something is wrong with the database container.

6. Configure a cron job on the host machine so that Group Office can run scheduled tasks. 
   On Linux create a file /etc/cron.d/groupoffice and add:

   ```cron
   * * * * * root docker exec --user www-data go_web php /usr/local/share/groupoffice/cron.php
   ```

    > On MacOS I ran on the terminal:
    >
    > ```bash
    > crontab -e
    > ```
    >
    > And added:
    >
    > ```bash
    > * * * * * /usr/local/bin/docker exec --user www-data go_web php /usr/local/share/groupoffice/cron.php
    > ```

7. All done. Happy coding!

Unit testing
------------

> **WARNING**: This will destroy and recreate database called "groupoffice_phpunit".

```bash
docker-compose exec groupoffice ./www/vendor/phpunit/phpunit/phpunit -c tests/phpunit.xml tests
```

Profiling
---------

You can create a profile by setting the GET parameter `XDEBUG_PROFILE=1`.
Also see the xdebug docs for more options.

Debugging
---------

Xdebug is ready to run. You just need to setup path mappings. 
Map your local folder
 "$YOUR_INSTALL_PATH/docker-groupoffice-development/src/master" to "/usr/local/share/src" 
in the Docker container to tell your IDE that's where the source files are on the server.

### PHPStorm

For PHPStorm debugging on the command line make sure you set mappings for "localhost" at Settings -> Languages & Frameworks -> PHP -> Servers. Because we set the 'PHP_IDE_CONFIG' environment vairable to "localhost" in docker-compose.yml.

See also:
https://www.jetbrains.com/help/phpstorm/zero-configuration-debugging-cli.html#6e577196

Open shell
----------

If you'd like to open a shell inside the container then you can run:

```bash
docker-compose exec groupoffice bash
```

PhpMyAdmin
----------

PhpMyAdmin runs on localhost:8001 by default. But it has no place to store it's
settings yet. You can fix that by running:

```sh
# in host (login to the correct docker container)
docker exec -it --user root go_phpmyadmin sh
# in container
apt-get update # update the package database
apt-get install mariadb-client # get a mysql client for running sql
mysql -u root -pgroupoffice -h db < sql/create_tables.sql # create the database
exit
```

Now recreate the containers on the host:

```bash
docker-compose down
docker-compose up -d
```

Check the main settings page and the warning message should be gone and the
settings will persist.

Useful commands
---------------
Run composer:
```bash
docker-compose exec -w /usr/local/src/www groupoffice composer update
```

Run legacy CLI commands:
```bash
docker-compose exec groupoffice php ./www/groupofficecli.php -r=postfixadmin/mailbox/cacheUsage -c=/etc/groupoffice/config.php -q
```

Run cron:
```bash
docker-compose exec groupoffice php ./www/cron.php
```
Import language file:
```
docker-compose exec groupoffice-64 php www/cli.php community/dev/Language/import --path=lang.csv
```
