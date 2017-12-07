#
# script to generate release notes based on the output of the version_would_deploy.ksh script
#

DIR=$(dirname $0)

# source common
. $DIR/common.ksh

function release_notes {
   local title=$1
   local project=$2
   local first_build=$3
   local last_build=$4
   echo
   echo "$title"
   echo $title | sed -e 's/./=/g'

   TEAMCITY_PROJECT=$project $DIR/changes_between.ksh $first_build $last_build
}

function extract_build_number {
   local build=$1
   echo ${build#build-}
}

function notes_if_deploying {
   local deploy_file=$1
   local service=$2
   local project=$3

   # look for a deploy line and return if we cannot find one
   line=$(grep "$service" $deploy_file 2>/dev/null | head -1)
   if [ -z "$line" ]; then
      return
   fi

   line=$(echo $line | sed 's/^.*\(build-.*\) => \(build-.*\)/\1 \2/')

   current_build=$(echo $line | awk '{print $1}')
   deploy_build=$(echo $line | awk '{print $2}')

   current_build=$( extract_build_number $current_build)
   deploy_build=$( extract_build_number $deploy_build)

   start_build=$(expr $current_build + 1)
   release_notes "$service" "$project" $start_build $deploy_build
}

if [ $# -ne 1 ]; then
   echo "ERROR: deploy file not specified, aborting"
   exit 1
fi

DEPLOY_FILE=$1

if [ ! -f $DEPLOY_FILE ]; then
   echo "ERROR: $DEPLOY_FILE is not available or readable, aborting"
   exit 1
fi

# for each possible deployable thing
notes_if_deploying $DEPLOY_FILE "depositauth service" "DepositAuthorizerService"
notes_if_deploying $DEPLOY_FILE "depositreg service" "DepositRegService"
notes_if_deploying $DEPLOY_FILE "entityid service" "EntityIdService"
notes_if_deploying $DEPLOY_FILE "ORCID access service" "OrcidAccessService"
notes_if_deploying $DEPLOY_FILE "tokenauth service" "TokenAuthorizerService"
notes_if_deploying $DEPLOY_FILE "userinfo service" "UserInformationService"
notes_if_deploying $DEPLOY_FILE "libra-etd webapp" "Libra2"
notes_if_deploying $DEPLOY_FILE "libra-oc webapp" "LibraOpen"
notes_if_deploying $DEPLOY_FILE "depositreg webapp" "DepositRegistration"
notes_if_deploying $DEPLOY_FILE "libra-etd admin webapp" "Libra2Administration"

exit 0

#
# end of file
#
