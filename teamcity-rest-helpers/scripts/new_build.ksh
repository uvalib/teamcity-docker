#
# script to trigger a new buildassociated with the specified TeamCity project
#

DIR=$(dirname $0)
FNAME=$(basename $0)

# source common
. $DIR/common.ksh

if [ -z "$TEAMCITY_PROJECT" ]; then
   echo "ERROR: no TEAMCITY_PROJECT defined, aborting"
   exit 1
fi 

# results file
RESFILE=/tmp/$FNAME.$$

# expected build type, only the image builds are interesting
BUILD_TYPE=${TEAMCITY_PROJECT}_BuildImage

curl $BASIC_AUTH_OPTION -H "$ACCEPT_JSON_OPTION" -H "$CONTENT_XML_OPTION" -X POST -d "<build><buildType id=\"$BUILD_TYPE\"/></build>" "$TEAMCITY_API/buildQueue" > $RESFILE 2>/dev/null
exit_on_error $?

cat $RESFILE | jq '.state' | tr -d "\""| awk '{printf "status -> %s\n", $1}'
rm $RESFILE > /dev/null 2>&1

#
# end of file
#
