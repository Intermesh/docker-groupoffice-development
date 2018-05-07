Group-Office docker compose
===========================

This docker compose environment can be used for development. It will install these services:

1. mariadb
2. mailserver based on dovecot and postfix
3. groupoffice apache web server with php 7.0 with ioncube and xdebug
4. phpunit for testing
5. composer
6. sass


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
   docker-compose run composer install --no-dev
   ```````````````````````````````````

5. Build css (or do this without IDE):

   `````````````````````````````````````````````````````````````````````````````````````````````
   docker-compose run sass ./views/Extjs3/themes/Paper/src/style.scss ./views/Extjs3/themes/Paper/style.css
   docker-compose run sass ./views/Extjs3/themes/Paper/src/style-mobile.scss ./views/Extjs3/themes/Paper/style-mobile.css
   `````````````````````````````````````````````````````````````````````````````````````````````

6. Install Group-Office by going to http://localhost

7. PhpMyAdmin runs on port 8001.

8. Webgrind for performance tuning runs on port 8002. You can create a profile 
   by setting the GET parameter XDEBUG_PROFILE=1. Also see the xdebug docs.

Open shell
----------

`````````````````````````````````````````````````````
docker exec -it --user root groupoffice bash
`````````````````````````````````````````````````````

Unit testing
------------

WARNING: This will destroy and recreate database called "groupoffice_phpunit"
`````````````````````````````````````````````````````
docker-compose run phpunit -c tests/phpunit.xml tests
`````````````````````````````````````````````````````
