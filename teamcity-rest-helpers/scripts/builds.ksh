#
# script to display the set of builds associated with the specified TeamCity project
#

DIR=$(dirname $0)
FNAME=$(basename $0)

# source common
. $DIR/common.ksh

# results file
RESFILE=/tmp/$FNAME.$$

curl $BASIC_AUTH_OPTION -H "$ACCEPT_JSON_OPTION" "$TEAMCITY_API/builds?locator=project:$TEAMCITY_PROJECT,count:20" > $RESFILE 2>/dev/null
exit_on_error $?

cat $RESFILE | jq '.build[] | "\(.number)  \(.id)"' | tr -d "\"" | sort -rn | awk '{printf "build-%s id:%s\n", $1, $2}'
rm $RESFILE > /dev/null 2>&1

#
# end of file
#
