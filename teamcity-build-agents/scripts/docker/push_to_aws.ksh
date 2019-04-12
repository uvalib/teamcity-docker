#
# Push the current team city agent build to the AWS registry
#

# helper dir
HELPER_DIR=$HOME/Sandboxes/build-deploy-scripts

# source the necessary support
. $HELPER_DIR/common/aws-support.ksh

# define the upload tool to use
UPLOADER_TOOL=$HELPER_DIR/common/upload-to-ecr.ksh

if [ -z "$DOCKER_HOST" ]; then
   echo "ERROR: no DOCKER_HOST defined"
   exit 1
fi

if [ ! -x "$UPLOADER_TOOL" ]; then
   echo "ERROR: $UPLOADER_TOOL is not available"
   exit 1
fi

# upload the image
$UPLOADER_TOOL $DOCKER_HOST uvadave/uva-teamcity-agent:latest $AWS_DEFAULT_REGISTRY/uvalib/teamcity-agent:latest
res=$?

echo "terminating with status $res"
exit $res

#
# end of file
#
