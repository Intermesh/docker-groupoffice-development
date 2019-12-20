Group-Office docker compose
===========================

This docker compose environment can be used for development. 

To improve performance on MacOS and Windows you can optionally use Docker Sync (https://github.com/EugenMayer/docker-sync/).

It will install these services:

1. mariadb
2. mailserver based on dovecot and postfix
3. groupoffice apache web server with php 7.0 with ioncube and xdebug running on port 80
4. phpunit for testing
5. PhpMyAdmin running on port 8001. (see below on how to make phpmyadmin settings persist)
6. Webgrind for performance tuning runs on port 8002. 
7. PHP composer container to run composer commands
8. sass container that will watch and compile sass files for you.

Installation
------------

1. Make sure docker and docker-compose are installed.


2. Clone this repository:

   ```bash
   git clone --recurse-submodules https://github.com/Intermesh/groupoffice-docker-development.git
   ```


3. Optionally install docker-sync (Recommended on Mac OS to improve performance) https://github.com/EugenMayer/docker-sync/wiki/1.-Installation
   When you do this you must switch this repository to the "sync" branch:

   ```bash
   git checkout sync
   ```

4. Go into src/* dfirectories and checkout the branches:

   ```bash
   cd groupoffice-docker-development/src/63`
   git checkout 6.3.x
   cd ../master
   git checkout master
   ```

5. Run php composer install once:

   ```bash
   docker-compose run --rm composer install --ignore-platform-reqs
   ```

   Or for the 6.3 branch that's in src/63:

   ```bash
   docker-compose run -w /src/63/www --rm composer install --ignore-platform-reqs
   ```

6. Run the stack:

   ```bash
   docker-compose up -d
   ```

   Or when using docker-sync

   ```bash
   docker-sync-stack start
   ```

7. Visit PHPMyAdmin at http://localhost:8001 and create the database "groupoffice" and "groupoffice-master"

8. Install Group-Office by going to http://localhost. Note you should not see a page where you enter database connection details. If you see this something is wrong with the database container.

9. Configure a cron job on the host machine so that Group Office can run scheduled tasks. 
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

10. All done. Next time you only have to repeat step 5.

Unit testing
------------

> **WARNING**: This will destroy and recreate database called "groupoffice_phpunit".

```bash
docker-compose exec groupoffice-master ./www/vendor/phpunit/phpunit/phpunit -c tests/phpunit.xml tests
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
docker exec -it --user root groupoffice bash
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
apt-get install mysql-client # get a mysql client for running sql
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

Multiple branches:
------------------

Checkout new source in the "src" directory

```bash
cd src
git clone -b 6.3.x https://github.com/Intermesh/groupoffice.git 63
```

Run composer for the branch:

```bash
docker-compose run -w /root/src/63/www --rm composer install --no-dev --ignore-platform-reqs
```

See dockerfile for example:
Duplicate the go_web container and the go_data and go_etc volumes
Change the database to groupoffice-63
