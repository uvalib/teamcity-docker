if [ -z "$DOCKER_HOST" ]; then
   DOCKER_TOOL=docker
else
   DOCKER_TOOL=docker-legacy
fi

# set the definitions
REPO=115119339709.dkr.ecr.us-east-1.amazonaws.com
INSTANCE=teamcity-agent
NAMESPACE=uvalib
TAG=build-20210218150657

$DOCKER_TOOL run -ti $REPO/$NAMESPACE/$INSTANCE:$TAG /bin/bash -l
