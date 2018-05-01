Group-Office docker compose
===========================

This docker compose environment can be used for development.


Installation
------------

1. Clone this repository:

   `````````````````````````````````````````````````````````````````````````
   git clone --recurse-submodules https://github.com/Intermesh/groupoffice-docker-development.git
   `````````````````````````````````````````````````````````````````````````

2. Run the containers:

   ````````````````````
   docker-compose up -d
   ````````````````````

4. Run php composer install once:

   ```````````````````````````````````
   docker-compose run composer install --no-dev --optimize-autoloader
   ```````````````````````````````````

5. Build css (or do this without IDE):

   `````````````````````````````````````````````````````````````````````````````````````````````
   docker-compose run sass ./views/Extjs3/themes/Paper/src/style.scss ./views/Extjs3/themes/Paper/style.css
   docker-compose run sass ./views/Extjs3/themes/Paper/src/style-mobile.scss ./views/Extjs3/themes/Paper/style-mobile.css
   `````````````````````````````````````````````````````````````````````````````````````````````

5. Install Group-Office by going to http://localhost

6. PhpMyAdmin runs on port 8001.

7. Stop the containers:

   ```````````````````
   docker-compose stop
   ```````````````````

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
