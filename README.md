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

2. Optionally install docker-sync (Recommended on Mac OS to improve performance) https://github.com/EugenMayer/docker-sync/wiki/1.-Installation
   When you do this you must edit docker-compose.yml and switch the mounts for groupoffice-master and groupoffice-63 too.

3. Clone this repository:

   ```
   git clone --recurse-submodules https://github.com/Intermesh/groupoffice-docker-development.git
   ```

3. Go into src/63 and checkout the 6.3.x branch:

   ```
   cd groupoffice-docker-development/src/63`
   git checkout 6.3.x
   ```

4. Run php composer install once:

   ```
   docker-compose run --rm composer install --no-dev --ignore-platform-reqs
   ```

5. Run the stack:

   ```
   docker-compose up -d
   ```
   
	 Or when using docker-sync

   ```
   docker-sync-stack start
   ```

6. Install Group-Office by going to http://localhost

7. Configure a cron job on the host machine so that Group Office can run scheduled tasks. 
   On Linux create a file /etc/cron.d/groupoffice and add:

   ```
   * * * * * root docker exec --user www-data go_web php /usr/local/share/groupoffice/cron.php
   ```

    > On MacOS I ran on the terminal:
    > ```
    > crontab -e
    > ```
    >
    > And added:
    > ```
    > * * * * * /usr/local/bin/docker exec --user www-data go_web php /usr/local/share/groupoffice/cron.php
    > ```

8. All done. Next time you only have to repeat step 5.


Unit testing
------------

> **WARNING**: This will destroy and recreate database called "groupoffice_phpunit".

```
docker-compose run --rm phpunit -c master/tests/phpunit.xml master/tests
```

Profiling
---------
You can create a profile by setting the GET parameter `XDEBUG_PROFILE=1`.
Also see the xdebug docs for more options.

Open shell
----------
If you'd like to open a shell inside the container then you can run:

```
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
apk update # update the package database
apk add mysql-client # get a mysql client for running sql
mysql -u root -pgroupoffice -h db < /www/sql/create_tables.sql # create the database
exit
```

Now recreate the containers on the host:

```
docker-compose down
docker-compose up -d
```

Check the main settings page and the warning message should be gone and the
settings will persist.


Multiple branches:
------------------

Checkout new source in the "src" directory

```
cd src
git clone -b 6.3.x https://github.com/Intermesh/groupoffice.git 63
```

Run composer for the branch:

```
docker-compose run -w /root/src/63/www --rm composer install --no-dev --ignore-platform-reqs
```


See dockerfile for example:
Duplicate the go_web container and the go_data and go_etc volumes
Change the database to groupoffice-63



