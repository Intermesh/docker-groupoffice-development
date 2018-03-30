Group-Office docker compose
===========================

This docker compose environment can be used for development.


Installation
------------

1. Clone this repository:

   `````````````````````````````````````````````````````````````````````````
   git clone https://github.com/Intermesh/groupoffice-docker-development.git
   `````````````````````````````````````````````````````````````````````````

2. Run the containers:

   ````````````````````
   docker-compose up -d
   ````````````````````

4. Run php composer install once:

   ```````````````````````````````````
   docker-compose run composer install
   ```````````````````````````````````

5. Install Group-Office by going to http://localhost/install

6. Stop the containers:

   ```````````````````
   docker-compose stop
   ```````````````````

Open shell
----------

`````````````````````````````````````````````````````
docker exec -it --user root docker_groupoffice_1 bash
`````````````````````````````````````````````````````
