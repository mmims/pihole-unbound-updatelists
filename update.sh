#!/bin/bash

docker compose build --pull pihole
docker compose down
docker compose up -d
