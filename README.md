Group-Office docker compose
===========================

This docker compose environment can be used for development. It will install these services:

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

1. Clone this repository:

   `````````````````````````````````````````````````````````````````````````
   git clone --recurse-submodules https://github.com/Intermesh/groupoffice-docker-development.git
   `````````````````````````````````````````````````````````````````````````
   
2. Go into the cloned directory:
   `````````````````````````````````
   cd groupoffice-docker-development
   `````````````````````````````````

3. Run the containers:

   ````````````````````
   docker-compose up -d
   ````````````````````

4. Run php composer install once:

   ```````````````````````````````````
   docker-compose run composer install --no-dev --ignore-platform-reqs
   ```````````````````````````````````

5. Install Group-Office by going to http://localhost
6. All done


Unit testing
------------

WARNING: This will destroy and recreate database called "groupoffice_phpunit"
`````````````````````````````````````````````````````
docker-compose run phpunit -c tests/phpunit.xml tests
`````````````````````````````````````````````````````

Profiling
---------
You can create a profile by setting the GET parameter XDEBUG_PROFILE=1. Also see the xdebug docs for more options.

Open shell
----------
If you'd like to open a shell inside the container then you can run:

`````````````````````````````````````````````````````
docker exec -it --user root groupoffice bash
`````````````````````````````````````````````````````


PhpMyAdmin
----------

PhpMyAdmin runs on localhost:8001 by default. But it has no place to store it's
settings yet. You can fix that by running:

```sh
# in host (logs into the correct docker container)
docker exec -it --user root go_phpmyadmin sh
# in container
apk update # update the package database
apk add mysql-client # get a mysql client for running sql
mysql -u root -pgroupoffice -h db < /www/sql/create_tables.sql # create the database
```

Now recreate the containers:

```
docker-compose down
docker-compose up -d
```

Check the main settings page and the warning message should be gone and the 
settings will persist.
