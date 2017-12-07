#
# script to display running builds for a specified project
#

#set -x

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

curl $BASIC_AUTH_OPTION -H "$ACCEPT_JSON_OPTION" "$TEAMCITY_API/builds?locator=project:$TEAMCITY_PROJECT,state:running" > $RESFILE 2>/dev/null
exit_on_error $?

cat $RESFILE | jq '.count' | tr -d "\"" 
rm $RESFILE > /dev/null 2>&1

#
# end of file
#
