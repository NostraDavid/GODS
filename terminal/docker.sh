#!/usr/bin/env bash
# variables
NETWORK=postgres-net
POSTGRES_INSTANCE=postgres-dev-test
PGADMIN_INSTANCE=pgadmin-dev-test
PASSWORD=ZXASqw12
POSTGRES_IMAGE=postgres:latest
PGADMIN_IMAGE=dpage/pgadmin4:latest

# == show available images ==
docker images

# == show running instances ==
docker ps

# == create network ==
docker network create $NETWORK

# == show networks ==
docker network ls

# == get image ==
docker pull $POSTGRES_IMAGE
docker pull $PGADMIN_IMAGE

# == create and start postgres ""
# from https://hub.docker.com/_/postgres
docker run --name $POSTGRES_INSTANCE -e POSTGRES_PASSWORD=$PASSWORD -p 5432:5432 -d $POSTGRES_IMAGE
docker run -it --rm --network $NETWORK $POSTGRES_IMAGE psql -h $NETWORK -U $POSTGRES_IMAGE

# == open a new bash inside the instance ==
docker exec -it $POSTGRES_INSTANCE bash
su postgres
psql
    \conninfo
    \q

# == create and start PGAdmin ==
docker run --name $PGADMIN_INSTANCE -e 'PGADMIN_DEFAULT_EMAIL=nostradavid@gmail.com' -e 'PGADMIN_DEFAULT_PASSWORD=ZXASqw12' -p 80:80 -d dpage/pgadmin4

# == start previously created image ==
docker start $PGADMIN_INSTANCE
docker start $POSTGRES_INSTANCE

# == get instance IP ==
docker inspect a66a8f9cd659 | grep IPAddress # pgadmin 172.17.0.2
docker inspect ff7f2ff07132 | grep IPAddress # postgres 172.17.0.3
