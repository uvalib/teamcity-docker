if [ -z "$DOCKER_HOST" ]; then
   echo "ERROR: no DOCKER_HOST defined, aborting"
   exit 1
fi

echo "*****************************************"
echo "starting agents on $DOCKER_HOST"
echo "*****************************************"

# set the definitions
INSTANCE=uva-teamcity-agent
NAMESPACE=uvadave
AGENT_COUNT=5

#TEAMCITY_HOST=http://teamcity.lib.virginia.edu:8080/
TEAMCITY_HOST=http://docker3.lib.virginia.edu:8080/
HOST_FS=/shareddockerfs/teamcity/agents

for agent in $(seq $AGENT_COUNT) ; do
   echo "stopping agent ${agent}"
   docker stop agent${agent}
   echo "removing agent ${agent}"
   docker rm agent${agent}
done

for agent in $(seq $AGENT_COUNT) ; do
   echo "starting agent ${agent}"
   docker run -d --name agent${agent} \
      --log-opt tag="agent${agent}" \
      --restart=always \
      -v $HOST_FS/conf/${agent}:/data/teamcity_agent/conf \
      -v $HOST_FS/logs/${agent}:/opt/buildagent/logs \
      -e SERVER_URL=$TEAMCITY_HOST $NAMESPACE/$INSTANCE
done
