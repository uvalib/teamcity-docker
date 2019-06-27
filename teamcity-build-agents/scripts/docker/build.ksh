if [ -z "$DOCKER_HOST" ]; then
   echo "ERROR: no DOCKER_HOST defined"
   exit 1
fi

echo "*****************************************"
echo "building on $DOCKER_HOST"
echo "*****************************************"

# set the definitions
INSTANCE=uva-teamcity-agent
NAMESPACE=uvadave

# which version of the agent do we want
#TAG=latest
#TAG=2017.2.4
#TAG=2018.1.1
#TAG=2018.2.1
#TAG=2018.2.4
TAG=2019.1

# pull base image to ensure we have the latest
docker pull jetbrains/teamcity-minimal-agent:$TAG

# build the image
docker build -t $NAMESPACE/$INSTANCE .

# return status
exit $?
