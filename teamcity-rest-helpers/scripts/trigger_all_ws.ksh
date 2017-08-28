#
# script to trigger builds for all web services
#

DIR=$(dirname $0)

# source common
. $DIR/common.ksh

SERVICES="DepositAuthorizerService \
          DepositRegService \
          EntityIdService \
          OrcidAccessService \
          TokenAuthorizerService \
          UserInformationService"

for build in $SERVICES; do

   echo "triggering build for $build"
   export TEAMCITY_PROJECT=$build
   $DIR/new_build.ksh
done

#
# end of file
#
