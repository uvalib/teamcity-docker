if [ -z "$DOCKER_HOST" ]; then
   echo "ERROR: no DOCKER_HOST defined"
   exit 1
fi

echo "*****************************************"
echo "stopping agents on $DOCKER_HOST"
echo "*****************************************"

AGENT_COUNT=5

for agent in $(seq $AGENT_COUNT) ; do
   echo "stopping agent ${agent}"
   docker stop agent${agent}
   echo "removing agent ${agent}"
   docker rm agent${agent}
done
