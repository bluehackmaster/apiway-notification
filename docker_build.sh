#!/usr/bin/env bash

REPOSITORY="apiway-notification"
TAG=$1
AWS_CONTAINER_REGISTRY="539277938309.dkr.ecr.us-west-2.amazonaws.com"


aws ecr get-login --region us-west-2 > ecr_login.sh
chmod +x ecr_login.sh
./ecr_login.sh

docker build -t $REPOSITORY:$TAG .
docker tag $REPOSITORY:$TAG $AWS_CONTAINER_REGISTRY/$REPOSITORY:$TAG
docker push $AWS_CONTAINER_REGISTRY/$REPOSITORY:$TAG
kubectl set image deployment/$REPOSITORY apiway-notification=$AWS_CONTAINER_REGISTRY/$REPOSITORY:$TAG
kubectl rollout status deployment/$REPOSITORY
kubectl delete pods -l name=$REPOSITORY

rm -f ecr_login.sh
