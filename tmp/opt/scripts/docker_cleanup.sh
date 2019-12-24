#!/bin/bash
docker rm $(docker ps -qa --no-trunc --filter "status=exited")
docker image prune --all --force
docker volume rm $(docker volume ls -qf dangling=true)
