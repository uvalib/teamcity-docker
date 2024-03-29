if [ -z "$DOCKER_HOST" ]; then
   echo "ERROR: no DOCKER_HOST defined, aborting"
   exit 1
fi

if [ $# -ne 1 ]; then
   echo "ERROR: must specify agent number, aborting"
   exit 1
fi

echo "*****************************************"
echo "starting agent on $DOCKER_HOST"
echo "*****************************************"

# set the definitions
INSTANCE=teamcity-minimal-agent
NAMESPACE=jetbrains
#TAG=latest
TAG=2017.2.2

TEAMCITY_HOST=http://teamcity.lib.virginia.edu:8080/
HOST_FS=/shareddockerfs/teamcity/agents

agent=agent${1}

echo "stopping ${agent}"
docker stop ${agent}
echo "removing ${agent}"
docker rm ${agent}

echo "starting ${agent}"
docker run -d --name ${agent} \
   --log-opt tag="${agent}" \
   --restart=always \
   -v $HOST_FS/conf/${1}:/data/teamcity_agent/conf \
   -v $HOST_FS/logs/${1}:/opt/buildagent/logs \
   -e AGENT_NAME=${agent} \
   -e SERVER_URL=$TEAMCITY_HOST $NAMESPACE/$INSTANCE:$TAG
