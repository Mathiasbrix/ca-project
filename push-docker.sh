#!/bin/bash

docker push "$docker_username/CoDeChan:1.0-${GIT_COMMIT::4}" 
docker push "$docker_username/CoDeChan:latest" &
wait